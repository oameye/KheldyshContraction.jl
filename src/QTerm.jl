########################
#    Multiplication
########################

"""
    QMul <: QTerm

Represent a multiplication involving [`QSym`](@ref) types.

Fields:
======

* arg_c: The commutative prefactor.
* args_nc: A vector containing all [`QSym`](@ref) types.
"""
struct QMul{M,T} <: QTerm
    arg_c::T
    args_nc::Vector{QField}
    metadata::M
    function QMul{M,T}(arg_c, args_nc, metadata) where {M,T}
        if SymbolicUtils._isone(arg_c) && length(args_nc) == 1
            return args_nc[1]
        elseif (0 in args_nc) || isequal(arg_c, 0)
            return 0
        else
            return new(arg_c, args_nc, metadata)
        end
    end
end
function QMul(arg_c::T, args_nc; metadata::M=NO_METADATA) where {M,T}
    return QMul{M,T}(arg_c, args_nc, metadata)
end

SymbolicUtils.operation(::QMul) = (*)
SymbolicUtils.arguments(a::QMul) = vcat(a.arg_c, a.args_nc)

function SymbolicUtils.maketerm(::Type{<:QMul}, ::typeof(*), args, metadata)
    args_c = filter(x -> !(x isa QField), args)
    args_nc = filter(x -> x isa QField, args)
    arg_c = *(args_c...)
    isempty(args_nc) && return arg_c
    return QMul(arg_c, args_nc; metadata)
end

SymbolicUtils.metadata(a::QMul) = a.metadata

function Base.adjoint(q::QMul)
    args_nc = map(adjoint, q.args_nc)
    reverse!(args_nc)
    sort!(args_nc; by=acts_on)
    return QMul(conj(q.arg_c), args_nc; q.metadata)
end

function Base.isequal(a::QMul, b::QMul)
    isequal(a.arg_c, b.arg_c) || return false
    length(a.args_nc) == length(b.args_nc) || return false
    for (arg_a, arg_b) in zip(a.args_nc, b.args_nc)
        isequal(arg_a, arg_b) || return false
    end
    return true
end

########################
#       Addition
########################

"""
    QAdd <: QTerm

Represent an addition involving [`QField`](@ref) and other types.
"""
struct QAdd <: QTerm
    arguments::Vector{QSymbol}
end
SymbolicUtils.operation(::QAdd) = (+)
SymbolicUtils.arguments(a::QAdd) = a.arguments
SymbolicUtils.maketerm(::Type{<:QAdd}, ::typeof(+), args, metadata) = QAdd(args)

function Base.isequal(a::QAdd, b::QAdd)
    length(arguments(a)) == length(arguments(b)) || return false
    for (arg_a, arg_b) in zip(arguments(a), arguments(b))
        isequal(arg_a, arg_b) || return false
    end
    return true
end

Base.adjoint(q::QAdd) = QAdd(map(adjoint, arguments(q)))

########################
#       acts_on
########################

"""
    acts_on(op)

Shows on which position `op` acts. For [`QSym`](@ref) types, this
returns an Integer, whereas for a `Term` it returns a `Vector{Int}`
whose entries specify all subspaces on which the expression acts.
"""
acts_on(op::QSym) = Int(position(op))
function acts_on(q::QMul)
    pos = Int[]
    for arg in q.args_nc
        pos_ = acts_on(arg)
        pos_ ∈ pos || push!(pos, pos_)
    end
    return pos
end
function acts_on(q::QAdd)
    pos = Int[]
    for arg in arguments(q)
        append!(pos, acts_on(arg))
    end
    unique!(pos) # TODO should this unque be here?
    sort!(pos)
    return pos
end
acts_on(x) = Int[]
# ^ used for sorting the arguments of a QMul and QAdd
