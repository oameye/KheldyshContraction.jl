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

function propagator_checks(out::QField, in::QField)::Nothing
    @assert isa(in, Create) "The `in` field must be a Create operator"
    @assert isa(out, Destroy) "The `out` field must be a Destroy operator"
    v = [out, in]

    positions = Int.(position.(v))
    @assert first(positions) <= 0 "The outgoing field can't be the In<:Position` coordinate"
    @assert last(positions) >= 0 "The incoming field can't be the Out<:Position` coordinate"
    @assert abs(-(positions...)) < 2 "Can't make a propagator with `In<:Position` and `Out<:Position` coordinate"
    contours = Int.(contour.(v))
    @assert !is_qq_contraction(v) "The quantum-quantum progator is zero"
    return nothing
end

"""
    Propagator <: Number

Symbolic number representing the Propagator of two fields ϕ and ψ. By convention a propagator is shown as G(ϕ, ψ) with ψ the incoming [`Create`](@ref) field and ϕ the outgoing [`Destroy`](@ref) field.

See also: [`propagator`](@ref)
"""
struct Propagator{T} <: Number end

const Average = SymbolicUtils.BasicSymbolic{<:Propagator}

function sym_average(T::PropagatorType) # Symbolic function for averages
    Tf = SymbolicUtils.FnType{Tuple{QSym,QSym},Propagator{T}}
    SymbolicUtils.Sym{Tf}(:avg)
end

# Type promotion -- average(::QField)::Number
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
    Propagator{T}
end

"""
    propagator(ψ::QSym, ϕ::QSym)

Create the Keldysh two-point green's functions over two field `ψ` and `ϕ`. Here `ψ` is the incoming [`Create`](@ref) field and `ψ` the outgoing [`Destroy`](@ref) field. The created propagator will be of type `SymbolicUtils.BasicSymbolic{Propagator{T}}` where `T` is the type [`PropagatorType`](@ref).
"""
function propagator(x::QSym, y::QSym)
    propagator_checks(x, y)
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

acts_on(p::Average) = acts_on(fields(p)...)
acts_on(x::QSym, y::QSym) = sum(acts_on.((x, y)))

##########################################
#       dressed green's function
##########################################

struct DressedPropagator{Tk,Tr,Ta}
    keldysh::Tk
    retarded::Tr
    advanced::Ta
    function DressedPropagator(expr_cc::SNuN, expr_cq::SNuN, expr_qc::SNuN)
        new{typeof(expr_cc),typeof(expr_cq),typeof(expr_qc)}(expr_cc, expr_cq, expr_qc)
    end
end
