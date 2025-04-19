########################
#   Field Types
########################

"""
    QField

Abstract type representing any expression involving Fields.
"""
abstract type QField end
const SNuN = Union{SymbolicUtils.Symbolic{<:Number},Number}
const QSymbol = Union{QField,SNuN}

"""
    QSym <: QField

Abstract type representing fundamental Field types.
"""
abstract type QSym <: QField end

"""
    QTerm <: QField

Abstract type representing noncommutative expressions.
"""
abstract type QTerm <: QField end

################################
# Interface for SymbolicUtils
################################

TermInterface.head(::QField) = :call
SymbolicUtils.iscall(::QSym) = false
SymbolicUtils.iscall(::QTerm) = true
SymbolicUtils.iscall(::Type{T}) where {T<:QTerm} = true
TermInterface.metadata(x::QSym) = x.metadata

# Symbolic type promotion
for f in SymbolicUtils.basic_diadic # [+, -, *, /, //, \, ^]
    @eval SymbolicUtils.promote_symtype(::$(typeof(f)), Ts::Type{<:QField}...) = promote_type(
        Ts...
    )
    @eval SymbolicUtils.promote_symtype(::$(typeof(f)), T::Type{<:QField}, Ts...) = T
    @eval SymbolicUtils.promote_symtype(
        ::$(typeof(f)), T::Type{<:QField}, S::Type{<:Number}
    ) = T
    @eval SymbolicUtils.promote_symtype(
        ::$(typeof(f)), T::Type{<:Number}, S::Type{<:QField}
    ) = S
    @eval function SymbolicUtils.promote_symtype(
        ::$(typeof(f)), T::Type{<:QField}, S::Type{<:QField}
    )
        return promote_type(T, S)
    end
end

SymbolicUtils.symtype(x::T) where {T<:QField} = T

Base.one(::T) where {T<:QField} = one(T)
Base.one(::Type{<:QField}) = 1
Base.isone(::QField) = false
Base.zero(::T) where {T<:QField} = zero(T)
Base.zero(::Type{<:QField}) = 0
Base.iszero(::QField) = false

#########################
# Field enum properties
#########################

name(ϕ::QSym) = ϕ.name

"""
    Regularisation `Plus` `Zero` `Minus`

Regularisation enum for the Keldysh quantum field. The regularisation is used to perform tadpole regularisation during the Wick contraction.
"""
@enum Regularisation begin
    Plus = 1
    Zero = 0
    Minus = -1
end
subtraction(x::NTuple{2,Regularisation}) = -(Int.(x)...)
function subtraction(x::Vector{Regularisation})
    @assert length(x) == 2
    return subtraction(Tuple(x))
end

"""
    KeldyshContour `Quantum` `Classical`

Keldysh contour enum for the Keldysh quantum field. The Keldysh contour is used to distinguish the field on quantum and classical contour.
"""
@enum KeldyshContour begin
    Quantum = 0
    Classical = 1
end
is_quantum(x::QSym) = iszero(Int(contour(x)))
is_classical(x::QSym) = isone(Int(contour(x)))
"""
    Position `In` `Out` `Bulk`

Position enum for the Keldysh quantum field. The position is used to determine the coordinate of the field.
"""
@enum Position begin
    In = 1
    Out = -1
    Bulk = 0
end

#########################
# Destroy and Create
#########################

"""
    Destroy <: QSym

Bosonic field representing the quantum field annihilation operator.
"""
struct Destroy{contour,regularisation,M} <: QSym
    name::Symbol
    position::Position
    metadata::M  # M should stay parametric such that symbolics can work with it
    function Destroy(
        name::Symbol,
        contour::KeldyshContour,
        reg::Regularisation=Zero,
        pos::Position=Bulk;
        metadata::M=NO_METADATA,
    ) where {M}
        return new{contour,reg,M}(name, pos, metadata)
    end
end

"""
    Create <: QSym

Bosonic field representing the quantum field creation operator.
"""
struct Create{contour,regularisation,M} <: QSym
    name::Symbol
    position::Position
    metadata::M # M should stay parametric such that symbolics can work with it
    function Create(
        name::Symbol,
        contour::KeldyshContour,
        reg::Regularisation=Zero,
        pos::Position=Bulk;
        metadata::M=NO_METADATA,
    ) where {M}
        return new{contour,reg,M}(name, pos, metadata)
    end
end

for T in (:Create, :Destroy)
    @eval Base.isequal(a::$T, b::$T) =
        isequal(name(a), name(b)) &&
        isequal(position(a), position(b)) &&
        isequal(contour(a), contour(b)) &&
        isequal(regularisation(a), regularisation(b))
end

for f in [:Destroy, :Create]
    @eval function (ff::$f)(pos::Position)
        return $(f)(name(ff), contour(ff), regularisation(ff), pos; ff.metadata)
    end
    @eval function (ff::$f)(reg::Regularisation)
        return $(f)(name(ff), contour(ff), reg, position(ff); ff.metadata)
    end

    @eval regularisation(ϕ::$(f){C,R}) where {C,R} = R
    @eval contour(ϕ::$(f){C}) where {C} = C
    @eval position(ϕ::$(f)) = ϕ.position
    @eval isbulk(ϕ::$(f)) = iszero(Int(position(ϕ)))

    @eval set_reg_to_zero(ϕ::$(f)) = $(f)(
        name(ϕ), contour(ϕ), Zero, position(ϕ); ϕ.metadata
    )
end

"""
    adjoint(op::Destroy)

Adjoint of the operator [`Destroy`](@ref) annihilation field constructing the corresponding creation field [`Create`](@ref).
"""
function Base.adjoint(op::Destroy)
    return Create(name(op), contour(op), regularisation(op), position(op); op.metadata)
end

"""
    adjoint(op::Create)

Adjoint of the [`Create`](@ref) creation field constructing the corresponding annihilation field [`Destroy`](@ref).
"""
function Base.adjoint(op::Create)
    return Destroy(name(op), contour(op), regularisation(op), position(op); op.metadata)
end

# reverse normal ordered
function Base.:*(a::Create, b::Destroy)
    pos_a = acts_on(a)
    pos_b = acts_on(b)
    if pos_a < pos_b
        return QMul(1, [a, b])
    else
        return QMul(1, [b, a])
    end
end

function ismergeable(a::Create, b::Destroy)
    pos_a = acts_on(a)
    pos_b = acts_on(b)
    return pos_a == pos_b
end

"""
    is_creation(x::QSym)

Returns if the field `x` is a creation operator.
"""
is_creation(x::Create) = true
is_creation(x::Destroy) = false

"""
    is_annihilation(x::QSym)

Returns if the field `x` is an annihilation operator.
"""
is_annihilation(x::Destroy) = true
is_annihilation(x::Create) = false

"""
    @qfields

Convenience macro for the construction of fields.

Examples
========
```
julia> using KeldyshContraction: Classical, Quantum

julia> @qnumbers ψ::Destroy(Classical)
(ψ,)
```
"""
macro qfields(qs...)
    ex = Expr(:block)
    qnames = []
    for q in qs
        @assert q isa Expr && q.head == :(::)
        q_ = q.args[1]
        @assert q_ isa Symbol
        push!(qnames, q_)
        f = q.args[2]
        @assert f isa Expr && f.head == :call
        op = _make_operator(q_, f.args...)
        ex_ = Expr(:(=), esc(q_), op)
        push!(ex.args, ex_)
    end
    push!(ex.args, Expr(:tuple, map(esc, qnames)...))
    return ex
end

function _make_operator(name, T, k, args...)
    name_ = Expr(:quote, name)
    # d = source_metadata(:qnumbers, name)
    return Expr(
        :call,
        T,
        name_,
        esc(k),
        args...,
        # Expr(:kw, :metadata, Expr(:quote, d))
    )
end
