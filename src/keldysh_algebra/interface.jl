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
