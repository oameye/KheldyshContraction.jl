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

"Collect and checks the rules for a physical propagator"
function propagator_checks(out::QSym, in::QSym)::Nothing
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
is_advanced(x::Average) = Int(propagator_type(x)) == Int(Advanced)
is_retarded(x::Average) = Int(propagator_type(x)) == Int(Retarded)
is_keldysh(x::Average) = Int(propagator_type(x)) == Int(Keldysh)

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
function positions(p::Average)::NTuple{2, AbstractPosition}
    pos = position.(fields(p))
    return ntuple(i->pos[i], 2)
end
function positions(p::Vector{QField})::NTuple{2, AbstractPosition}
    pos = position.(p)
    return ntuple(i->pos[i], 2)
end
function integer_positions(p::Average)::NTuple{2, Int}
    return Int.(positions(p))
end
propagator_type(p::SymbolicUtils.BasicSymbolic{Propagator{T}}) where {T} = T

function position(p::Average)
    _positions = positions(p)
    if length(findall(x -> x isa In, _positions)) == 1
        return In()
    elseif length(findall(x -> x isa Out, _positions)) == 1
        return Out()
    elseif all(isbulk, _positions)
        idxs = getproperty.(_positions, :index)
        if isequal(idxs...)
            return _positions[1]
        else
            return minimum(_positions)
            # ^  TODO what to do if both are bulk with different index?
            # This function should not exist
        end
    else
        throw(ArgumentError("Not a valid propagator."))
    end
end

function same_position(p::Average)
    _positions = positions(p)
    return isequal(_positions...)
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

function get_unique_propagators(v::T) where {T<:SymbolicUtils.Symbolic}
    if v isa Average
        return T[v]
    elseif SymbolicUtils.iscall(v)
        args = map(get_unique_propagators, SymbolicUtils.arguments(v))
        return unique(collect(Iterators.flatten(args)))
    else
        return T[]
    end
end
get_unique_propagators(v) = SymbolicUtils.Symbolic[]
function get_propagators(v::T) where {T<:SymbolicUtils.Symbolic}
    out = T[]
    if v isa Average
        out = T[v]
    elseif SymbolicUtils.iscall(v)
        if SymbolicUtils.ispow(v)
            base, exp = v.base, v.exp
            args = fill(map(get_propagators, base), exp)
            out = collect(Iterators.flatten(args))
        else
            args = map(get_propagators, SymbolicUtils.arguments(v))
            out = collect(Iterators.flatten(args))
        end
    end
    return out
end
get_propagators(v) = SymbolicUtils.Symbolic[]

# find_retarded_idx(ps) = findfirst(is_retarded, propagator_type.(ps))
function find_advanced_idx_with_equal_coordinate(ps)
    return findfirst(x -> is_advanced(x) && same_position(x), ps)
end

"""
    advanced_to_retarded(x::T) where {T<:SymbolicUtils.Symbolic}

Apply the transformation to change the advanced propagator to retarded:

``G^A(y, y)=-G^R(y, y)``

with ``y =(\\vec{y},t)``.
Note the expression is only valid for equal space-time coordinates.
"""
function advanced_to_retarded(x::T) where {T<:SymbolicUtils.Symbolic}
    props = get_unique_propagators(x)
    adv_idx = find_advanced_idx_with_equal_coordinate(props)
    if isnothing(adv_idx)
        return x
    end
    to_sub = Dict(props[adv_idx] => -1 * _conj(props[adv_idx]))
    return SymbolicUtils.substitute(x, to_sub)
end
