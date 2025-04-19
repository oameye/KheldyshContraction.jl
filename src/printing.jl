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
    #  <:SymbolicUtils.Symbolic{<:Number},
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

function Base.show(io::IO, mime::MIME"text/plain", Σ::Union{SelfEnergy,DressedPropagator})
    print(io, "Self Energy:")
    X = SNuN[0 Σ.advanced; Σ.retarded Σ.keldysh]
    # compute new IOContext
    if !haskey(io, :compact) && length(axes(X, 2)) > 1
        io = IOContext(io, :compact => true)
    end
    if get(io, :limit, false)::Bool && eltype(X) === Method
        # override usual show method for Vector{Method}: don't abbreviate long lists
        io = IOContext(io, :limit => false)
    end

    if get(io, :limit, false)::Bool && displaysize(io)[1] - 4 <= 0
        return print(io, " …")
    else
        println(io)
    end

    # 3) update typeinfo
    #
    # it must come after printing the summary, which can exploit :typeinfo itself
    # (e.g. views)
    # we assume this function is always called from top-level, i.e. that it's not nested
    # within another "show" method; hence we always print the summary, without
    # checking for current :typeinfo (this could be changed in the future)
    io = Base.IOContext(io, :typeinfo => eltype(X))

    # 4) show actual content
    recur_io = Base.IOContext(io, :SHOWN_SET => X)
    Base.print_array(recur_io, X)
end
