# function _conj(v::T) where {T<:SymbolicUtils.Symbolic}
#     if SymbolicUtils.iscall(v)
#         f = SymbolicUtils.operation(v)
#         args = map(_conj, SymbolicUtils.arguments(v))
#         return SymbolicUtils.maketerm(T, f, args, TermInterface.metadata(v))
#     else
#         return conj(v)
#     end
# end
# _conj(q::Average) = conj(q)
# _conj(x::Number) = Base.conj(x)
# _adjoint(s::SymbolicUtils.Symbolic{<:Number}) = _conj(s)

# function make_real(v::T) where {T<:SymbolicUtils.Symbolic}
#     if SymbolicUtils.iscall(v)
#         f = SymbolicUtils.operation(v)
#         args = map(make_real, SymbolicUtils.arguments(v))
#         return SymbolicUtils.maketerm(T, f, args, TermInterface.metadata(v))
#     else
#         return SymbolicUtils._isreal(v) ? real(v) : v
#     end
# end
# make_real(x::Average) = x

# Base.isreal(::SymbolicUtils.BasicSymbolic{Real}) = true
# Base.isreal(::SymbolicUtils.BasicSymbolic{Number}) = false

# let SymbolicUtils = SymbolicUtils, Rewriters = SymbolicUtils.Rewriters
#     # using SymbolicUtils: @rule
#     r1 = SymbolicUtils.@rule conj(*(~x, ~y)) => conj(~x) * conj(~y)
#     r1′ = SymbolicUtils.@rule conj(*(~~x, ~~y)) => conj(~~x) * conj(~~y)
#     r2 = SymbolicUtils.@rule conj(+(~x, ~y)) => conj(~x) + conj(~y)
#     r2′ = SymbolicUtils.@rule conj(+(~~x, ~~y)) => conj(~~x) + conj(~~y)
#     rule = Rewriters.PassThrough(
#         Rewriters.Fixpoint(Rewriters.Postwalk(Rewriters.Chain([r2, r1, r2′, r1′])))
#     )

#     global _conj

#     _conj(x) = SymbolicUtils.simplify(conj(x); rewriter=rule, expand=true)

# end
# TODO check if you can rewrite sin(~x) to sin(x) with above
# https://github.com/JuliaSymbolics/Symbolics.jl/issues/826
# https://github.com/JuliaSymbolics/SymbolicUtils.jl/pull/158
