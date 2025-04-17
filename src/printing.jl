Base.show(io::IO, x::QSym) = write(io, name(x))
function Base.show(io::IO, x::Create{C,R}) where {C,R}
    reg = Int(R)
    if iszero(reg)
        s = string("̄", name(x))
    elseif reg == 1
        s = string("̄", name(x), "⁺")
    else
        s = string("̄", name(x), "⁻")
    end
    return write(io, s)
end
function Base.show(io::IO, x::Destroy{C,R}) where {C,R}
    reg = Int(R)
    if iszero(reg)
        s = string(name(x))
    elseif reg == 1
        s = string(name(x), "⁺")
    else
        s = string(name(x), "⁻")
    end
    return write(io, s)
end

show_brackets = Ref(true)
function Base.show(io::IO, x::QTerm)
    show_brackets[] && write(io, "(")
    show(io, arguments(x)[1])
    f = operation(x)
    for i in 2:length(arguments(x))
        show(io, f)
        show(io, arguments(x)[i])
    end
    return show_brackets[] && write(io, ")")
end

function Base.show(io::IO, x::QMul)
    if !SymbolicUtils._isone(x.arg_c)
        show(io, x.arg_c)
        show(io, *)
    end
    show_brackets[] && write(io, "(")
    show(io, x.args_nc[1])
    for i in 2:length(x.args_nc)
        show(io, *)
        show(io, x.args_nc[i])
    end
    return show_brackets[] && write(io, ")")
end

const T_LATEX = Union{
    <:QField,
    # <:AbstractMeanfieldEquations,
    #  <:SymbolicUtils.Symbolic{<:CNumber},
}

Base.show(io::IO, ::MIME"text/latex", x::T_LATEX) = write(io, latexify(x))

function Base.show(io::IO, x::Average)
    prop_type = Dict(Retarded => "ᴿ", Advanced => "ᴬ", Keldysh => "ᴷ")
    pos_string = Dict(In => "x₂", Out => "x₁", Bulk => "y")
    reg_string = Dict(Plus => "⁺", Zero => "", Minus => "⁻")

    (out, in) = positions(x)
    (r2, r1) = regularisations(x)
    s = string(
        "G",
        prop_type[propagator_type(x)],
        "(",
        pos_string[out],
        reg_string[r2],
        ",",
        pos_string[in],
        reg_string[r1],
        ")",
    )
    return write(io, s)
end
