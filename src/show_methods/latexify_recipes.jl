function _postwalk_func(x)
    if x==:𝟙
        return "\\mathbb{1}"
    elseif x==:im
        return :i
    elseif MacroTools.@capture(x, dagger(arg_))
        # s = "$(arg)^\\dagger"
        s = "\\bar{$(arg)}"
        return s
    elseif MacroTools.@capture(x, power(arg_, reg_))
        s = reg > 0 ? "$(arg)^+" : "$(arg)^{-}"
        return s
    else
        return x
    end
end

@latexrecipe function f(op::QField)
    # Options
    cdot --> false

    ex = _to_expression(op)
    ex = MacroTools.postwalk(_postwalk_func, ex)
    ex = isa(ex, String) ? latexstring(ex) : ex
    return ex
end

_to_expression(x::Number) = x
function _to_expression(x::Complex) # For brackets when using latexify
    iszero(x) && return x
    if iszero(real(x))
        return :($(imag(x))*im)
    elseif iszero(imag(x))
        return real(x)
    else
        return :($(real(x)) + $(imag(x))*im)
    end
end
_to_expression(op::QSym) = name(op)
function _to_expression(op::Create)
    reg = Int(regularisation(op))
    if iszero(reg)
        return :(dagger($(name(op))))
    elseif reg == 1
        return :(power(dagger($(name(op))), 1))
    else
        return :(power(dagger($(name(op))), -1))
    end
end
function _to_expression(op::Destroy)
    reg = Int(regularisation(op))
    if iszero(reg)
        return :($(name(op)))
    elseif reg == 1
        return :(power($(name(op)), 1))
    else
        return :(power($(name(op)), -1))
    end
end

function _to_expression(t::QMul)
    args = if SymbolicUtils._isone(t.arg_c)
        t.args_nc
    else
        arguments(t)
    end
    return :(*($(_to_expression.(args)...)))
end
_to_expression(t::QAdd) = :(+($(_to_expression.(arguments(t))...)))
