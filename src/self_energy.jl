const PositionPropagatorType = OrderedCollections.LittleDict{
    Int64,
    PropagatorType,
    Tuple{Int64,Int64,Int64},
    Tuple{PropagatorType,PropagatorType,PropagatorType},
}
function self_energy_type(dict::PositionPropagatorType)
    right = is_retarded(dict[-1]) ? Quantum : Classical
    left = is_advanced(dict[1]) ? Quantum : Classical

    if Int.([right, left]) == [0, 0]
        # G_K(1) = ...
        return Keldysh
    elseif Int.([right, left]) == [0, 1]
        # G_R(1) =  G₀_R Σ_A G₀_R
        return Advanced
    elseif Int.([right, left]) == [1, 0]
        # G_A(1) = G₀_A Σ_R G₀_A
        return Retarded
    else
        @show dict
        error("Classical-Classical for self-energy should be zero.")
    end
end

function construct_self_energy(expr::SymbolicUtils.Symbolic)
    self_energy = OrderedCollections.LittleDict{PropagatorType,SNuN}((
        Advanced => 0, Retarded => 0, Keldysh => 0
    ))
    return construct_self_energy!(self_energy, expr)
end
function construct_self_energy!(
    self_energy::OrderedCollections.LittleDict, expr::SymbolicUtils.Symbolic
)
    terms = SymbolicUtils.arguments(expr)
    for term in terms
        args = SymbolicUtils.arguments(term)
        idxs_c = findall(x -> !(x isa Average), args)
        idxs_p = setdiff(eachindex(args), idxs_c)
        args_p = args[idxs_p]

        positions = KeldyshContraction.acts_on.(args_p)
        bulk_propagator = args_p[findfirst(iszero, positions)]
        dict = OrderedCollections.freeze(
            OrderedCollections.OrderedDict(zip(positions, propagator_type.(args_p)))
        )

        to_add = isempty(idxs_c) ? bulk_propagator : *(args[idxs_c]...) * bulk_propagator
        self_energy[self_energy_type(dict)] += to_add
    end
    return self_energy
end

struct SelfEnergy{Tk,Tr,Ta}
    keldysh::Tk
    retarded::Tr
    advanced::Ta
    function SelfEnergy(G::DressedPropagator)
        self_energy = OrderedCollections.LittleDict{PropagatorType,SNuN}((
            Advanced => 0, Retarded => 0, Keldysh => 0
        ))
        construct_self_energy!(self_energy, G.keldysh)
        # ^ keldysh GF should contain everything
        # construct_self_energy!(self_energy, G.advanced)
        # construct_self_energy!(self_energy, G.retarded)

        # quantum-quantum is the keldysh term in the self-energy
        # classical-classical is zero
        qq, cq, qc = SymbolicUtils.expand.((
            self_energy[Keldysh], self_energy[Retarded], self_energy[Advanced]
        ))
        # G_R(1) =  G₀_R Σ_A G₀_R
        # G_A(1) = G₀_A Σ_R G₀_A
        # G_K(1) = G₀_R Σ_K G₀_A + G₀_R Σ_A G₀_K + G₀_K Σ_R G₀_A
        # G₀_K Σ_K G₀_K = 0

        return new{typeof(qq),typeof(cq),typeof(qc)}(qq, cq, qc)
    end
end
matrix(Σ::SelfEnergy) = SNuN[0 Σ.advanced; Σ.retarded Σ.keldysh]
