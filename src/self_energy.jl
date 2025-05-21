const PositionPropagatorType = OrderedCollections.LittleDict{
    AbstractPosition,
    PropagatorType,
    Tuple{<:AbstractPosition,<:AbstractPosition,<:AbstractPosition},
    Tuple{PropagatorType,PropagatorType,PropagatorType},
}

"compute the self-energy type from positions save in `dict`."
function self_energy_type(dict::OrderedCollections.LittleDict)
    # G1K = GA[y1,x2] GK[x1,y1] ΣA[y1,y1]+GA[y1,x2] GR[x1,y1] Σ+GK[y1,x2] GR[x1,y1]ΣR[y1,y1]
    if is_keldysh(dict[Out()]) && is_advanced(dict[In()])
        return Advanced
    elseif is_retarded(dict[Out()]) && is_keldysh(dict[In()])
        return Retarded
    elseif is_retarded(dict[Out()]) && is_advanced(dict[In()])
        return Keldysh
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
    self_energy::OrderedCollections.LittleDict, expr::SymbolicUtils.Symbolic; order::Int=1
)
    if order > 2
        error("Higher then second order in self-energy is not supported.")
    end
    terms = SymbolicUtils.arguments(SymbolicUtils.expand(expr))

    for term in terms
        args = SymbolicUtils.arguments(term)
        arg_c = get_prefactor(term)
        args_p = get_propagators(term) # type-unstable

        mult = bulk_multiplicity(args_p)
        if !isempty(mult) && first(mult) < order
            continue
        end

        positions = KeldyshContraction.position.(args_p)
        types_p = propagator_type.(args_p)
        dict = OrderedCollections.freeze(
            OrderedCollections.OrderedDict(zip(positions, types_p))
        )

        bulk_propagator = args_p[findall(isbulk, positions)]
        to_add = arg_c * prod(bulk_propagator)
        self_energy[self_energy_type(dict)] += to_add
    end
    return self_energy
end

"""
$(TYPEDEF)

A struct representing the self-energy components in the Retarded-Advance-Keldysh basis ([`PropagatorType`](@ref)).
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
    function SelfEnergy(G::DressedPropagator; order=1)
        self_energy = OrderedCollections.LittleDict{PropagatorType,SNuN}((
            Advanced => 0, Retarded => 0, Keldysh => 0
        ))
        construct_self_energy!(self_energy, G.keldysh; order)
        # ^ keldysh GF should contain everything
        # construct_self_energy!(self_energy, G.advanced)
        # construct_self_energy!(self_energy, G.retarded)

        # quantum-quantum is the keldysh term in the self-energy
        # classical-classical is zero
        qq, cq, qc = SymbolicUtils.expand.((
            self_energy[Keldysh], self_energy[Retarded], self_energy[Advanced]
        ))
        # G_R(1) = G₀_R Σ_R G₀_R
        # G_A(1) = G₀_A Σ_A G₀_A
        # G_K(1) = G₀_K(x1) Σ_A(y) G₀_A(x2) + G_A(x2) Σ_A(y) G_R(x1) + G_R(x1) Σ_R(y) G_K(x2)
        # G₀_K Σ_K G₀_K = 0

        return new{typeof(qq),typeof(cq),typeof(qc)}(qq, cq, qc)
    end
    function SelfEnergy(L::InteractionLagrangian; order=1, simplify=true)
        ϕ = L.qfield
        ψ = L.cfield
        if order == 1
            keldysh = wick_contraction(ψ(Out()) * ψ'(In()) * L.lagrangian)
        elseif order == 2
            L1 = L
            L2 = L(2)
            prefactor = make_real(im^2) / 2
            keldysh =
                prefactor *
                wick_contraction(ψ(Out()) * ψ'(In()) * L1.lagrangian * L2.lagrangian)
        else
            error("higher order then two not implemented")
        end
        if simplify
            keldysh = SymbolicUtils.expand(advanced_to_retarded(keldysh))
        end

        self_energy = OrderedCollections.LittleDict{PropagatorType,SNuN}((
            Advanced => 0, Retarded => 0, Keldysh => 0
        ))
        construct_self_energy!(self_energy, keldysh)

        qq, cq, qc = SymbolicUtils.expand.((
            self_energy[Keldysh], self_energy[Retarded], self_energy[Advanced]
        ))

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
