const PositionPropagatorType = OrderedCollections.LittleDict{
    AbstractPosition,
    PropagatorType,
    Tuple{<:AbstractPosition,<:AbstractPosition,<:AbstractPosition},
    Tuple{PropagatorType,PropagatorType,PropagatorType},
}

"compute the self-energy type from positions save in `dict`."
function self_energy_type(dict::OrderedCollections.LittleDict)
    right = is_retarded(dict[Out()]) ? Quantum : Classical
    left = is_advanced(dict[In()]) ? Quantum : Classical

    if Int.([right, left]) == [0, 0]
        # G_K(1) = ...
        return Keldysh
    elseif Int.([right, left]) == [1, 0]
        # G_R(1) =  G₀_R Σ_A G₀_R
        return Advanced
    elseif Int.([right, left]) == [0, 1]
        # G_A(1) = G₀_A Σ_R G₀_A
        return Retarded
    else
        @show dict
        error("Classical-Classical for self-energy should be zero.")
    end
end

"Construct the self-energy from `expr`."
function construct_self_energy(expr::SymbolicUtils.Symbolic)
    self_energy = OrderedCollections.LittleDict{PropagatorType,SNuN}((
        Advanced => 0, Retarded => 0, Keldysh => 0
    ))
    return construct_self_energy!(self_energy, expr)
end

"Construct the self-energy from `expr` and save in LittleDict `self_energy`."
function construct_self_energy!(
    self_energy::OrderedCollections.LittleDict, expr::SymbolicUtils.Symbolic
)
    terms = SymbolicUtils.arguments(expr)
    for term in terms
        args = SymbolicUtils.arguments(term)
        idxs_c = findall(x -> !(x isa Average), args)
        idxs_p = setdiff(eachindex(args), idxs_c)
        args_p = args[idxs_p]

        positions = KeldyshContraction.position.(args_p)
        bulk_propagator = args_p[findfirst(isbulk, positions)]
        dict = OrderedCollections.freeze(
            OrderedCollections.OrderedDict(zip(positions, propagator_type.(args_p)))
        )

        to_add = isempty(idxs_c) ? bulk_propagator : *(args[idxs_c]...) * bulk_propagator
        self_energy[self_energy_type(dict)] += to_add
    end
    return self_energy
end

"""
$(TYPEDEF)

A struct representing the self-energy components in the Retarded-Advance-Keldysh basis ([`KeldyshContraction.PropagatorType`](@ref)).
The self-energy is divided into three components: Keldysh, retarded, and advanced.

# Fields
$(FIELDS)
where it assumed that the fields are of type `Union{SymbolicUtils.Symbolic{<:Number}, Number}`.


# Constructor
$(TYPEDSIGNATURES)
Constructs a `SelfEnergy` object from a [`DressedPropagator`](@ref).
The self-energy is computed based on the Keldysh Green's function (`G.keldysh`) and expanded into
its quantum-quantum (`qq`), classical-quantum (`cq`), and quantum-classical (`qc`) components.

"""
struct SelfEnergy{Tk,Tr,Ta}
    "The Keldysh component of the self-energy."
    keldysh::Tk
    " The retarded component of the self-energy."
    retarded::Tr
    "The advanced component of the self-energy."
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

"""
    matrix(Σ::SelfEnergy)

Returns the matrix representation of the self energy `Σ`
in the Retarded-Advanced-Keldysh basis.
```math
\\hat{\\Sigma}\\left(y_1, y_2\\right)=
\\left(\\begin{array}{cc}0 & \\Sigma^A\\left(y_1, y_2\\right) \\\\
\\Sigma^R\\left(y_1, y_2\\right) & \\Sigma^K\\left(y_1, y_2\\right)
\\end{array}
\\right)
```
"""
matrix(Σ::SelfEnergy) = SNuN[0 Σ.advanced; Σ.retarded Σ.keldysh]
# TODO: check matrix convention G_0 Σ G_0 and define above matric accordingly
