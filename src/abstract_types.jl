########################
#   Field Types
########################

"""
    QField

Abstract type representing any expression involving Fields.
"""
abstract type QField end
const SNuN = Union{SymbolicUtils.Symbolic{Number},Number}
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

## Interface for SymbolicUtils

# ∨ should this be defined?
# Base.isless(a::QSym, b::QSym) = name(a) < name(b)

TermInterface.head(::QField) = :call
SymbolicUtils.iscall(::QSym) = false
SymbolicUtils.iscall(::QTerm) = true
SymbolicUtils.iscall(::Type{T}) where {T<:QTerm} = true
TermInterface.metadata(x::QSym) = x.metadata

# Symbolic type promotion
SymbolicUtils.promote_symtype(f, Ts::Type{<:QField}...) = promote_type(Ts...)
SymbolicUtils.promote_symtype(f, T::Type{<:QField}, Ts...) = T
SymbolicUtils.promote_symtype(f, T::Type{<:QField}, S::Type{<:Number}) = T
SymbolicUtils.promote_symtype(f, T::Type{<:Number}, S::Type{<:QField}) = S
function SymbolicUtils.promote_symtype(f, T::Type{<:QField}, S::Type{<:QField})
    promote_type(T, S)
end

SymbolicUtils.symtype(x::T) where {T<:QField} = T

Base.one(::T) where {T<:QField} = one(T)
Base.one(::Type{<:QField}) = 1
Base.isone(::QField) = false
Base.zero(::T) where {T<:QField} = zero(T)
Base.zero(::Type{<:QField}) = 0
Base.iszero(::QField) = false

########################
#   Field properties
########################

name(ϕ::QSym) = ϕ.name

@enum Regularisation begin
    Plus = 1
    Zero = 0
    Minus = -1
end
subtraction(x::NTuple{2,Regularisation}) = -(Int.(x)...)
function subtraction(x::Vector{Regularisation})
    @assert length(x) == 2
    subtraction(Tuple(x))
end

@enum KeldyshContour begin
    Quantum = 0
    Classical = 1
end

@enum Position begin
    In = 1
    Out = -1
    Bulk = 0
end
