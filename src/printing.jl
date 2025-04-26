Base.show(io::IO, x::QSym) = write(io, name(x))
function Base.show(io::IO, x::Create{C,P,R}) where {C,P,R}
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
function Base.show(io::IO, x::Destroy{C,P,R}) where {C,P,R}
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
        x.arg_c isa Complex ? write(io, "(") : write(io, "")
        show(io, x.arg_c)
        x.arg_c isa Complex ? write(io, ")") : write(io, "")
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

function Base.show(io::IO, L::InteractionLagrangian)
    write(io, "Interaction Lagrangian with fields ")
    show(io, L.cfield)
    write(io, " and ")
    show(io, L.qfield)
    write(io, ":\n")
    return show(io, L.lagrangian)
end

const T_LATEX = Union{<:QField,<:SymbolicUtils.Symbolic{<:Propagator}}
Base.show(io::IO, ::MIME"text/latex", x::T_LATEX) = write(io, latexify(x))
function Base.show(io::IO, ::MIME"text/latex", L::InteractionLagrangian)
    # write(io, "Interaction Lagrangian with fields ")
    # write(io, latexify(L.cfield))
    # write(io, " and ")
    # write(io, latexify(L.qfield))
    # println(io, ": \\newline")
    return write(io, latexify(L.lagrangian))
end
# function Base.show(io::IO, ::MIME"text/latex", L::DressedPropagator)
#     return write(io,latexify([L.retarded,L.advanced, L.keldysh]))
# end
function Base.show(io::IO, x::Average)
    prop_type = Dict(Retarded => "ᴿ", Advanced => "ᴬ", Keldysh => "ᴷ")

    reg_string = Dict(Plus => "⁺", Zero => "", Minus => "⁻")

    (out, in) = positions(x)
    (r2, r1) = regularisations(x)
    s = string(
        "G",
        prop_type[propagator_type(x)],
        "(",
        pos_string(out),
        reg_string[r2],
        ",",
        pos_string(in),
        reg_string[r1],
        ")",
    )
    return write(io, s)
end

const underscore_dict = Dict(
    1 => "₁", 2 => "₂", 3 => "₃", 4 => "₄", 5 => "₅", 6 => "₆", 7 => "₇", 8 => "₈", 9 => "₉"
)

function pos_string(p)
    if p isa In
        return "x₂"
    elseif p isa Out
        return "x₁"
    else
        return "y"*underscore_dict[p.index]
    end
end

function Base.show(io::IO, mime::MIME"text/plain", Σ::Union{SelfEnergy,DressedPropagator})
    Σ isa SelfEnergy ? print(io, "Self Energy:\n") : print(io, "Dressed Propagator:\n")
    write(io, "keldysh:  ")
    show(io, Σ.keldysh)
    write(io, "\nretarded: ")
    show(io, Σ.retarded)
    write(io, "\nadvanced: ")
    return show(io, Σ.advanced)
end
