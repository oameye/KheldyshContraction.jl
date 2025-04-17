# *,+,/,- math of the QField and QSym types

function Base.:*(a::QSym, b::QSym)
    args = [a, b]
    sort!(args; by=acts_on)
    return QMul(1, args)
end

function Base.:*(a::QSym, b::SNuN)
    SymbolicUtils._iszero(b) && return b
    SymbolicUtils._isone(b) && return a
    return QMul(b, [a])
end
Base.:*(b::SNuN, a::QField) = a * b

function Base.:*(a::QMul, b::SNuN)
    SymbolicUtils._iszero(b) && return b
    SymbolicUtils._isone(b) && return a
    arg_c = a.arg_c * b
    return QMul(arg_c, a.args_nc)
end

function Base.:*(a::QSym, b::QMul)
    args_nc = vcat(a, b.args_nc)
    sort!(args_nc; by=acts_on)
    return merge_commutators(b.arg_c, args_nc)
end
function Base.:*(a::QMul, b::QSym)
    args_nc = vcat(a.args_nc, b)
    sort!(args_nc; by=acts_on)
    return merge_commutators(a.arg_c, args_nc)
end

function Base.:*(a::QMul, b::QMul)
    args_nc = vcat(a.args_nc, b.args_nc)
    sort!(args_nc; by=acts_on)
    arg_c = a.arg_c * b.arg_c
    return merge_commutators(arg_c, args_nc)
end

Base.:/(a::QField, b::SNuN) = (1 / b) * a

function merge_commutators(arg_c, args_nc)
    #Added extra checks for 0 here
    if isequal(arg_c, 0) || 0 in args_nc
        return 0
    end
    i = 1
    was_merged = false
    while i < length(args_nc)
        if _ismergeable(args_nc[i], args_nc[i + 1])
            args_nc[i] = *(args_nc[i], args_nc[i + 1])
            iszero(args_nc[i]) && return 0
            deleteat!(args_nc, i + 1)
            was_merged = true
        end
        i += 1
    end
    if was_merged
        return *(arg_c, args_nc...)
    else
        return QMul(arg_c, args_nc)
    end
end

function _ismergeable(a, b)
    return isequal(acts_on(a), acts_on(b)) && ismergeable(a, b)
end
ismergeable(a, b) = false

## Powers
function Base.:^(a::QField, n::Integer)
    iszero(n) && return 1
    isone(n) && return a
    return *((a for i in 1:n)...)
end

## Addition

Base.:-(a::QField) = -1 * a
Base.:-(a, b::QField) = a + (-b)
Base.:-(a::QField, b) = a + (-b)
Base.:-(a::QField, b::QField) = a + (-b)

function Base.:+(a::QField, b::SNuN)
    SymbolicUtils._iszero(b) && return a
    return QAdd([a, b])
end
Base.:+(a::SNuN, b::QField) = +(b, a)
function Base.:+(a::QAdd, b::SNuN)
    SymbolicUtils._iszero(b) && return a
    args = vcat(arguments(a), b)
    return QAdd(args)
end

function Base.:+(a::QField, b::QField)
    args = [a, b]
    return QAdd(args)
end

function Base.:+(a::QAdd, b::QField)
    args = vcat(arguments(a), b)
    return QAdd(args)
end
function Base.:+(b::QField, a::QAdd)
    args = vcat(arguments(a), b)
    return QAdd(args)
end
function Base.:+(a::QAdd, b::QAdd)
    args = vcat(arguments(a), arguments(b))
    return QAdd(args)
end

function Base.:*(a::QAdd, b)
    args = QSymbol[a_ * b for a_ in arguments(a)]
    flatten_adds!(args)
    isempty(args) && return 0
    q = QAdd(args)
    return q
end
function Base.:*(a::QField, b::QAdd)
    args = QSymbol[a * b_ for b_ in arguments(b)]
    flatten_adds!(args)
    isempty(args) && return 0
    q = QAdd(args)
    return q
end

function Base.:*(a::QAdd, b::QAdd)
    args = []
    for a_ in arguments(a), b_ in arguments(b)
        push!(args, a_ * b_)
    end
    flatten_adds!(args)
    isempty(args) && return 0
    q = QAdd(args)
    return q
end

function flatten_adds!(args)
    i = 1
    while i <= length(args)
        x = args[i]
        if x isa QAdd
            append!(args, arguments(x))
            deleteat!(args, i)
        elseif SymbolicUtils._iszero(x) || isequal(x, 0)
            deleteat!(args, i)
        else
            i += 1
        end
    end
    return args
end
