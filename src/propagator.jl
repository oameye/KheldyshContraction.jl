"""
    PropagatorType `Keldysh`, `Advanced`, `Retarded`

The type of propagator taken of two fields with the x-y Contour where `x` is the Contour of the [`Destroy`](@ref) field and `y` the contour of the [`Create`](@ref) field.
- `Keldysh` propagator of a Classical-Classical contour
- `Advanced` propagator of a Quantum-Classical contour
- `Retarded` propagator of a Classical-Quantum contour

The Quantum-Quantum propagator should always be zero.
"""
@enum PropagatorType begin
    Keldysh
    Advanced
    Retarded
end
"""
$(TYPEDSIGNATURES)

Determine the type of the propagator in the Retarded-Advance-Keldysh ([`PropagatorType`](@ref)) based on the contour of the output and input quantum field.
"""
function propagator_type(out::QSym, in::QSym)::PropagatorType
    contours = Int.(contour.((out, in)))
    diff_contour = first(-(contours...))
    if iszero(diff_contour)
        return Keldysh
    elseif isone(diff_contour)
        return Retarded
    else
        return Advanced
    end
end
is_advanced(x::PropagatorType) = Int(x) == Int(Advanced)
is_retarded(x::PropagatorType) = Int(x) == Int(Retarded)
is_keldysh(x::PropagatorType) = Int(x) == Int(Keldysh)

"Collect and checks the rules for a physical propagator"
function propagator_checks(out::QField, in::QField)::Nothing
    @assert isa(in, Create) "The `in` field must be a Create operator"
    @assert isa(out, Destroy) "The `out` field must be a Destroy operator"
    v = [out, in]

    positions = position.(v)
    @assert !(first(positions) isa In) "The outgoing field can't be the In<:Position` coordinate"
    @assert !(last(positions) isa Out) "The incoming field can't be the Out<:Position` coordinate"
    in_out = (In() ∈ positions ? !(Out() ∈ positions) : true)
    @assert in_out "Can't make a propagator with `In<:Position` and `Out<:Position` coordinate"
    contours = Int.(contour.(v))
    @assert !is_qq_contraction(v) "The quantum-quantum progator is zero"
    return nothing
end

"""
$(TYPEDEF)

Symbolic number representing the Propagator of two fields ϕ and ψ.
By convention apropagator is shown as G(ϕ, ψ) with ψ the incoming [`Create`](@ref) field
 and ϕ the outgoing [`Destroy`](@ref) field.

See also: [`propagator`](@ref)
"""
struct Propagator{T} <: Number end

"BasicSymbolic type for propagators. What will be used in the symbolic expressions"
const Average = SymbolicUtils.BasicSymbolic{<:Propagator}

"The type expressing the propagator as a function over two QSym"
function sym_average(T::PropagatorType) # Symbolic function for averages
    Tf = SymbolicUtils.FnType{Tuple{QSym,QSym},Propagator{T}}
    return SymbolicUtils.Sym{Tf}(:avg)
end

# Type promotion -- average(::QField)::Number
"A propagator of two fields is a number is of type `Propagator`"
function SymbolicUtils.promote_symtype(
    ::SymbolicUtils.BasicSymbolic{SymbolicUtils.FnType{Tuple{QSym,QSym},Propagator{T}}},
    ::Type{<:QSym},
    ::Type{<:QSym},
) where {T}
    return Propagator{T}
end

# needs a specific symtype overload, otherwise we build the wrong expressions with maketerm
# and `SymbolicUtils.expand` and `SymbolicUtils.simplify` will not work
function SymbolicUtils.symtype(::SymbolicUtils.BasicSymbolic{Propagator{T}}) where {T}
    return Propagator{T}
end

"""
$(TYPEDSIGNATURES)

Create the Keldysh two-point green's functions over two field `ψ` and `ϕ`:
```math
G(x_1,x_2) = -i \\langle \\phi(x_1) \\overline{\\psi}(x_2) \\rangle.
```

Here `ψ` is the incoming [`Create`](@ref) field at coordinate ``x_2=(\\vec{x}_1, t_1)``
and `ψ` the outgoing [`Destroy`](@ref) field at coordinate ``x_2=(\\vec{x}_2, t_2)``.
The created propagator will be a symbolic function of `SymbolicUtils.FnType` which maps
Tuple `Tuple{QSym,QSym}` to `SymbolicUtils.BasicSymbolic{Propagator{T}}` where `T` is
the type [`PropagatorType`](@ref).

The name of the symbolic function is `:avg` and is reserved as it is used internally for printing.
"""
function propagator(x::QSym, y::QSym)
    propagator_checks(x, y)
    return im * make_propagator(x, y)
end
"Make propagator without the prefactor, i.e., the imaginary unit"
function make_propagator(x::QSym, y::QSym)
    T = propagator_type(x, y)
    return SymbolicUtils.Term{Propagator{T}}(sym_average(T), [x, y])
end

# ensure that BasicSymbolic{<:Propagator} are only single averages
function Base.:*(a::Average, b::Average)
    if isequal(a, b)
        return SymbolicUtils.Mul(Number, 1, Dict(a => 2))
    end
    return SymbolicUtils.Mul(Number, 1, Dict(a => 1, b => 1))
end
function Base.:+(a::Average, b::Average)
    if isequal(a, b)
        return SymbolicUtils.Add(Number, 0, Dict(a => 2))
    end
    return SymbolicUtils.Add(Number, 0, Dict(a => 1, b => 1))
end

fields(p::Average) = SymbolicUtils.arguments(p)
function regularisations(p::Average)
    return regularisation.(fields(p))
end
contours(p::Average) = contour.(fields(p))
isbulk(p::Average) = all(isbulk.(fields(p)))
function positions(p::Average)
    return position.(fields(p))
end
propagator_type(p::SymbolicUtils.BasicSymbolic{Propagator{T}}) where {T} = T

function position(p::Average)
    _positions = positions(p)
    if In() ∈ _positions
        return In()
    elseif Out() ∈ _positions
        return Out()
    else
        return minimum(_positions) # TODO what to do if both are bulk?
    end
end

function get_propagator_idx(x::CSym)::Int
    args = KeldyshContraction.arguments(x)
    return get_propagator_idx(args)
end
function get_propagator_idx(args::SymbolicUtils.SmallVec{Any,Vector{Any}})
    p_idxs = isa.(args, KeldyshContraction.Average)
    @assert isone(sum(p_idxs)) "Only one propagator allowed"
    p_idx = findfirst(p_idxs)
    @assert p_idx !== nothing "No propagator found"
    return p_idx
end
function get_propagator(x::CSym)::Average
    args = KeldyshContraction.arguments(x)
    p_idx = get_propagator_idx(x)
    return args[p_idx]
end
for ff in [:regularisations, :contours, :isbulk, :positions, :position, :propagator_type]
    @eval begin
        $(ff)(x::CSym) = $(ff)(get_propagator(x))
    end
end

function Base.conj(q::Average)
    T = propagator_type(q)
    if is_keldysh(T)
        return -1 * q
    else # retarded || advanced
        x, y = fields(q)
        return make_propagator(y(position(x))', x(position(y))')
    end
end
Base.adjoint(q::Average) = conj(q)

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
