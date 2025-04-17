"""
    Destroy <: QSym

Bosonic field representing the quantum field annilihation operator.
"""
struct Destroy{contour,regularisation,M} <: QSym
    name::Symbol
    position::Position
    metadata::M  # M should stay parametric such that symbolics can work with it
    function Destroy(
        name::Symbol,
        contour::KheldyshContour,
        reg::Regularisation=Zero,
        pos::Position=Bulk;
        metadata::M=NO_METADATA,
    ) where {M}
        return new{contour,reg,M}(name, pos, metadata)
    end
end

"""
    Create <: QSym

Bosonic field representing the quantum field creation operator.
"""
struct Create{contour,regularisation,M} <: QSym
    name::Symbol
    position::Position
    metadata::M # M should stay parametric such that symbolics can work with it
    function Create(
        name::Symbol,
        contour::KheldyshContour,
        reg::Regularisation=Zero,
        pos::Position=Bulk;
        metadata::M=NO_METADATA,
    ) where {M}
        return new{contour,reg,M}(name, pos, metadata)
    end
end

for T in (:Create, :Destroy)
    @eval Base.isequal(a::$T, b::$T) =
        isequal(name(a), name(b)) &&
        isequal(position(a), position(b)) &&
        isequal(contour(a), contour(b)) &&
        isequal(regularisation(a), regularisation(b))
end

for f in [:Destroy, :Create]
    @eval function (ff::$f)(pos::Position)
        return $(f)(name(ff), contour(ff), regularisation(ff), pos; ff.metadata)
    end
    @eval function (ff::$f)(reg::Regularisation)
        return $(f)(name(ff), contour(ff), reg, position(ff); ff.metadata)
    end

    @eval regularisation(ϕ::$(f){C,R}) where {C,R} = R
    @eval contour(ϕ::$(f){C}) where {C} = C
    @eval position(ϕ::$(f)) = ϕ.position
    @eval isbulk(ϕ::$(f)) = iszero(Int(position(ϕ)))

    @eval set_reg_to_zero(ϕ::$(f)) =
        $(f)(name(ϕ), contour(ϕ), Zero, position(ϕ); ϕ.metadata)
end

function Base.adjoint(op::Destroy)
    return Create(name(op), contour(op), regularisation(op), position(op); op.metadata)
end
function Base.adjoint(op::Create)
    return Destroy(name(op), contour(op), regularisation(op), position(op); op.metadata)
end

# Commutation relation in simplification
function Base.:*(a::Create, b::Destroy)
    pos_a = acts_on(a)
    pos_b = acts_on(b)
    if pos_a < pos_b
        return QMul(1, [a, b])
    else
        return QMul(1, [b, a])
    end
end

function ismergeable(a::Create, b::Destroy)
    pos_a = acts_on(a)
    pos_b = acts_on(b)
    return pos_a == pos_b
end

"""
    @qfields

Convenience macro for the construction of fields.

Examples
========
```
julia> using LossyTransport: Classical, Quantum

julia> @qnumbers ψ::Destroy(Classical)
(ψ,)
```
"""
macro qfields(qs...)
    ex = Expr(:block)
    qnames = []
    for q in qs
        @assert q isa Expr && q.head == :(::)
        q_ = q.args[1]
        @assert q_ isa Symbol
        push!(qnames, q_)
        f = q.args[2]
        @assert f isa Expr && f.head == :call
        op = _make_operator(q_, f.args...)
        ex_ = Expr(:(=), esc(q_), op)
        push!(ex.args, ex_)
    end
    push!(ex.args, Expr(:tuple, map(esc, qnames)...))
    return ex
end

function _make_operator(name, T, k, args...)
    name_ = Expr(:quote, name)
    # d = source_metadata(:qnumbers, name)
    return Expr(
        :call,
        T,
        name_,
        esc(k),
        args...,
        # Expr(:kw, :metadata, Expr(:quote, d))
    )
end
