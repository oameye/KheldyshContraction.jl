# Generic hash fallback for interface -- this will be slow and should be overridden
# function Base.hash(op::T, h::UInt) where {T<:QSym}
#     n = fieldcount(T)
#     if n == 3
#         # These three fields need to be defined for any QSym
#         return hash(T, hash(name(op), hash(acts_on(op), h)))
#     else
#         # If there are more we'll need to iterate through
#         h_ = copy(h)
#         for k in n:-1:4
#             if fieldname(typeof(op), k) !== :metadata
#                 h_ = hash(getfield(op, k), h_)
#             end
#         end
#         return hash(T, hash(name(op), hash(acts_on(op), h_)))
#     end
# end

# These has function are defined such that comparison functions work, e.g., `unique`.

Base.hash(q::QMul, h::UInt) = hash(QMul, hash(q.arg_c, SymbolicUtils.hashvec(q.args_nc, h)))

Base.hash(q::QAdd, h::UInt) = hash(QAdd, SymbolicUtils.hashvec(arguments(q), h))

function Base.hash(h::Union{KeldyshContour,Regularisation,Position}, i::UInt)
    return hash(Int(h), i)
end

for f in [:Destroy, :Create]
    @eval function Base.hash(op::T, h::UInt) where {T<:($(f))}
        return hash(
            $(f),
            hash(
                name(op), hash(contour(op), hash(acts_on(op), hash(regularisation(op), h)))
            ),
        )
    end
end
