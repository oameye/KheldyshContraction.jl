########################
#   Field Types
########################

"""
    QField

Abstract type representing any expression involving Fields.
"""
abstract type QField end
const CSym = SymbolicUtils.Symbolic{<:Number}
const SNuN = Union{CSym,Number}
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
TermInterface.metadata(x::QSym) = nothing

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

#########################
#       Position
#########################

"""
$(TYPEDEF)

Abstract Position type for the Keldysh quantum field.
The position is used to determine the coordinate of the field during the wick contraction.

AbstractPosition has subtypes:
- [`In`](@ref)
- [`Out`](@ref)
- [`Bulk`](@ref).
"""
abstract type AbstractPosition end

"""
    $(TYPEDEF)

The `In` singleton to mark a field the incoming field.

See also: [`Out`](@ref), [`Bulk`](@ref).
"""
struct In <: AbstractPosition end

"""
    $(TYPEDEF)

The `Out` singleton to mark a field the outgoing field.

See also: [`In`](@ref), [`Bulk`](@ref).
"""
struct Out <: AbstractPosition end

"""
    $(TYPEDEF)

The `Bulk` struct to mark a field relies in the bulk of a feyman diagram.
This means the field will contribute to the self-energy ([`SelfEnergy`](@ref).

See also: [`In`](@ref), [`Out`](@ref).
"""
struct Bulk <: AbstractPosition
    """
    The index of the bulk coordinate.
    This is used to distinguish between different bulk coordinates.
    """
    index::Int
    Bulk() = new(1)
    function Bulk(i::Int)
        @assert i > 0 "Bulk index must be positive"
        return new(i)
    end
end
Base.isless(x::Bulk, y::Bulk) = x.index < y.index
Base.isless(::Bulk, ::In) = true
Base.isless(::In, ::Bulk) = false
Base.isless(::Out, ::Bulk) = true
Base.isless(::Bulk, ::Out) = false
Base.isless(::Out, ::In) = true
Base.isless(::In, ::Out) = false

isbulk(x::AbstractPosition) = x isa Bulk
#########################
# Destroy and Create
#########################

"""
    Destroy <: QSym

Bosonic field representing the quantum field annihilation operator.
"""
struct Destroy{contour,position,regularisation} <: QSym
    name::Symbol
    function Destroy(
        name::Symbol,
        contour::KeldyshContour,
        reg::Regularisation=Zero,
        pos::AbstractPosition=Bulk(),
    )
        return new{contour,pos,reg}(name)
    end
end

"""
    Create <: QSym

Bosonic field representing the quantum field creation operator.
"""
struct Create{contour,position,regularisation} <: QSym
    name::Symbol
    function Create(
        name::Symbol,
        contour::KeldyshContour,
        reg::Regularisation=Zero,
        pos::AbstractPosition=Bulk();
    )
        return new{contour,pos,reg}(name)
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
    @eval function (ff::$f)(pos::AbstractPosition)
        return $(f)(name(ff), contour(ff), regularisation(ff), pos)
    end
    @eval function (ff::$f)(reg::Regularisation)
        return $(f)(name(ff), contour(ff), reg, position(ff))
    end

    @eval regularisation(ϕ::$(f){C,P,R}) where {C,P,R} = R
    @eval contour(ϕ::$(f){C}) where {C} = C
    @eval position(ϕ::$(f){C,P}) where {C,P} = P
    @eval isbulk(ϕ::$(f)) = position(ϕ) isa Bulk

    @eval set_reg_to_zero(ϕ::$(f)) = $(f)(name(ϕ), contour(ϕ), Zero, position(ϕ))
end
ladder(::Destroy) = 0
ladder(::Create) = 1

"""
    adjoint(op::Destroy)

Adjoint of the operator [`Destroy`](@ref) annihilation field constructing the corresponding creation field [`Create`](@ref).
"""
function Base.adjoint(op::Destroy)
    return Create(name(op), contour(op), regularisation(op), position(op))
end

"""
    adjoint(op::Create)

Adjoint of the [`Create`](@ref) creation field constructing the corresponding annihilation field [`Destroy`](@ref).
"""
function Base.adjoint(op::Create)
    return Destroy(name(op), contour(op), regularisation(op), position(op))
end

# reverse normal ordered
"Defines the reverse normal order for the creation and annihilation operators."
function Base.:*(a::Create, b::Destroy)
    pos_a = position(a)
    pos_b = position(b)
    if pos_a < pos_b
        return QMul(1, [a, b])
    else
        return QMul(1, [b, a])
    end
end

function ismergeable(a::Create, b::Destroy)
    pos_a = position(a)
    pos_b = position(b)
    return isequal(pos_a, pos_b)
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
    defs = map(qs) do q
        nf = _name_field(q)
        name, field_expr = nf.name, nf.field_expr

        # Extract field type (Create or Destroy) and args
        field_type = field_expr.args[1]
        field_args = field_expr.args[2:end]

        # Build the field construction expression
        field_construction = Expr(
            :call,
            esc(field_type),
            Expr(:quote, name),  # Pass the name as a quoted symbol
            map(esc, field_args)..., # Escape all other args
        )

        # Define the field variable
        :($(esc(name)) = $(field_construction))
    end

    # Return both the definitions and the tuple of names
    return Expr(:block, defs..., :(tuple($(map(q -> esc(_name_field(q).name), qs)...))))
end
# Helper function to extract name and field constructor from expression
function _name_field(expr)
    @assert expr isa Expr && expr.head == :(::) "Expected expression of form name::Field(args...)"
    name = expr.args[1]
    @assert name isa Symbol "Left side of :: must be a symbol"

    field_expr = expr.args[2]
    @assert field_expr isa Expr && field_expr.head == :call "Right side of :: must be a field constructor call"

    return (name=name, field_expr=field_expr)
end
