# *,+,/,- math of the QField and QSym types

function Base.:*(a::QSym, b::QSym)
    args = QSym[a, b]
    sort!(args; by=position)
    sort!(args; by=ladder)
    return QMul(1.0, args)
end

function Base.:*(a::QSym, b::SNuN)
    # SymbolicUtils._iszero(b) && return b
    # SymbolicUtils._isone(b) && return a
    return QMul(b, QSym[a])
end
Base.:*(b::SNuN, a::QField) = a * b

function Base.:*(a::QMul, b::SNuN)
    # SymbolicUtils._iszero(b) && return b
    # SymbolicUtils._isone(b) && return a
    arg_c = a.arg_c * b
    return QMul(arg_c, a.args_nc)
end

function Base.:*(a::QSym, b::QMul)
    args_nc = vcat(a, b.args_nc)
    sort!(args_nc; by=position)
    sort!(args_nc; by=ladder)
    return QMul(b.arg_c, args_nc)
end
Base.:*(a::QMul, b::QSym) = b * a

function Base.:*(a::QMul, b::QMul)
    args_nc = vcat(a.args_nc, b.args_nc)
    sort!(args_nc; by=position)
    sort!(args_nc; by=ladder)
    arg_c = a.arg_c * b.arg_c
    return QMul(arg_c, args_nc)
end

Base.:/(a::QField, b::SNuN) = (1 / b) * a

## Powers
function Base.:^(a::QField, n::Integer)
    # Type-stable implementation using Val
    iszero(n) && return QMul(0.0, QSym[])
    result = QMul(1.0, QSym[a])
    for _ in 2:n
        result *= a
    end
    return result
end

## Addition

Base.:-(a::QField) = -1 * a
Base.:-(a::SNuN, b::QField) = a + (-b)
Base.:-(a::QField, b::SNuN) = a + (-b)
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

function Base.:*(a::QAdd, b::SNuN)
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
function Base.:*(b::QAdd, a::QField)
    args = QSymbol[b_ * a for b_ in arguments(b)]
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
