##########################################
#       dressed green's function
##########################################
"""
$(TYPEDEF)

A structure representing dressed propagator in the Retarded-Advanced-Keldysh basis
([`PropagatorType`](@ref)).

# Fields
$(FIELDS)
where it assumed that the fields are of type `Union{SymbolicUtils.Symbolic{<:Number}, Number}`.

# Constructor
$(TYPEDSIGNATURES)

Constructs a `DressedPropagator` with the given Keldysh, retarded, and advanced components.
"""
struct DressedPropagator{E,T}
    "The Keldysh component of the propagator"
    keldysh::Diagrams{E,T}
    "The retarded component of the propagator"
    retarded::Diagrams{E,T}
    "The advanced component of the propagator"
    advanced::Diagrams{E,T}
end
"""
    matrix(G::DressedPropagator)

Returns the matrix representation of the dressed propagator `G`
in the Retarded-Advanced-Keldysh basis.
```math
\\hat{G}\\left(x_1, x_2\\right)
=\\left(
\\begin{array}{cc}
G^K\\left(x_1, x_2\\right) & G^R\\left(x_1, x_2\\right) \\\\
G^A\\left(x_1, x_2\\right) & 0
\\end{array}
\\right)
```
"""
function matrix(G::DressedPropagator{E}) where {E}
    Diagrams[G.retarded G.keldysh; G.advanced Diagrams(E)]
end

"""
    wick_contraction(L::InteractionLagrangian; order=1)


All the same coordinate advanced propagators are converted to retarded propagators.
"""
function DressedPropagator(L::InteractionLagrangian; order=1, simplify=true)
    ϕ = L.qfield
    ψ = L.cfield
    if order == 1
        keldysh = wick_contraction(ψ(Out()) * ψ'(In()) * L.lagrangian; simplify)
        retarded = wick_contraction(ψ(Out()) * ϕ'(In()) * L.lagrangian; simplify)
        advanced = wick_contraction(ϕ(Out()) * ψ'(In()) * L.lagrangian; simplify)
    elseif order == 2
        L1 = L
        L2 = L(2)
        prefactor = make_real(im^2) / 2
        keldysh = multiply!(
            wick_contraction(ψ(Out()) * ψ'(In()) * L1.lagrangian * L2.lagrangian; simplify),
            prefactor,
        )

        retarded = multiply!(
            wick_contraction(ψ(Out()) * ϕ'(In()) * L1.lagrangian * L2.lagrangian; simplify),
            prefactor,
        )
        advanced = multiply!(
            wick_contraction(ϕ(Out()) * ψ'(In()) * L1.lagrangian * L2.lagrangian; simplify),
            prefactor,
        )
    else
        error("higher order then two not implemented")
    end
    filter_nonzero!(keldysh)
    filter_nonzero!(retarded)
    filter_nonzero!(advanced)
    return DressedPropagator(keldysh, retarded, advanced)
end
