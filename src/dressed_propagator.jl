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
struct DressedPropagator{Tk,Tr,Ta}
    "The Keldysh component of the propagator"
    keldysh::Tk
    "The retarded component of the propagator"
    retarded::Tr
    "The advanced component of the propagator"
    advanced::Ta
    function DressedPropagator(keldysh::SNuN, retarded::SNuN, advanced::SNuN)
        return new{typeof(keldysh),typeof(retarded),typeof(advanced)}(
            keldysh, retarded, advanced
        )
    end
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
matrix(G::DressedPropagator) = SNuN[G.retarded G.keldysh; G.advanced 0]
