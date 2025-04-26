#################################
#       Consistency checks
#################################

is_qq_contraction(v::Vector{T}) where {T<:QField} = iszero(sum(Int.(contour.(v))))
has_qq_contraction(vv::Vector{Vector{QField}}) = any(is_qq_contraction.(vv))

function is_physical_propagator(a::Vector{QField})
    len = length(a) == 2 # propagator has length 2
    positions = position.(a)
    # ∨ Can't make a propagator with In and Out coordinate
    in_out = In() ∈ positions ? !(Out() ∈ positions) : true
    physical = all(is_physical.(a))
    return len && in_out && physical
end

######################
#     regularise
######################

"""
    regular(p::Average)

Checks if the propagator `p` is regular.
A regular propagator is one that is:
- not in the bulk
- or `p` is not of [`KeldyshContraction.PropagatorType`](@ref) `Retarded` while also having a negative [`KeldyshContraction.Regularisation`](@ref)
- or `p` is not of [`KeldyshContraction.PropagatorType`](@ref) `Advanced` while also having a positive [`KeldyshContraction.Regularisation`](@ref)
"""
function regular(p::Average)
    _isbulk = isbulk(p)
    _reg = regularisations(p)
    T = propagator_type(p)
    if !_isbulk || subtraction(_reg) == 0
        return true
    elseif subtraction(_reg) < 0 && T == Retarded
        return false
    elseif subtraction(_reg) > 0 && T == Advanced
        return false
    else
        return true
    end
end
regular(p) = true
regular(x::CSym) = regular(get_propagator(x))

regular(v::Vector{SNuN}) = all(regular.(v))
regular(v::Vector{Average}) = all(regular.(v))

_regularise(vp::Vector{Vector{SNuN}}) = filter(regular, vp)

function set_reg_to_zero!(p::Average)
    p.arguments .= set_reg_to_zero.(arguments(p))
    return p
end
function set_reg_to_zero!(vp::Union{Vector{SNuN},Vector{Vector{SNuN}}})
    for p in vp
        set_reg_to_zero!(p)
    end
    return vp
end
function set_reg_to_zero!(p::CSym)
    p_idx = get_propagator_idx(p)
    return set_reg_to_zero!(p.arguments[p_idx])
end
set_reg_to_zero!(p::Number) = nothing

#################################
#       Contraction
#################################

function wick_contraction(L::InteractionLagrangian; order=1)
    ϕ = L.qfield
    ψ = L.cfield
    if order == 1
        keldysh = wick_contraction(ψ(Out()) * ψ'(In()) * L.lagrangian)
        retarded = wick_contraction(ψ(Out()) * ϕ'(In()) * L.lagrangian)
        advanced = wick_contraction(ϕ(Out()) * ψ'(In()) * L.lagrangian)
    elseif order == 2
        L1 = L
        L2 = L(2)
        prefactor = make_real(im^2)/2
        keldysh =
            prefactor*wick_contraction(ψ(Out()) * ψ'(In()) * L1.lagrangian * L2.lagrangian)
        retarded =
            prefactor*wick_contraction(ψ(Out()) * ϕ'(In()) * L1.lagrangian * L2.lagrangian)
        advanced =
            prefactor*wick_contraction(ϕ(Out()) * ψ'(In()) * L1.lagrangian * L2.lagrangian)
    else
        error("higher order then two not implemented")
    end
    return DressedPropagator(keldysh, retarded, advanced)
end
"""
    wick_contraction(expr::QTerm)

Compute all possible Wick contractions of quantum fields in the expression `expr`.

Wick contractions decompose products of quantum field operators into sums of products
of propagators (two-point correlation functions). The rules of the contraction are:
  - Conservation (equal numbers of creation/annihilation operators)
  - Physicality (proper time ordering)
  - No quantum-quantum contractions
  - If the fields have a [`KeldyshContraction.Regularisation`](@ref) applied, the contractions are
    regularised. The [`KeldyshContraction.Regularisation`](@ref) property is set to zero after the reguralisation.

The function handles two types of inputs:
- `QAdd`: Distributes the contraction over sums
- `QMul`: Contracts products of fields into propagators

The function returns a new expression of propagators of type `SymbolicUtils.Symbol`.

"""
function wick_contraction(a::QAdd; regularise=true)
    wick_contractions = wick_contraction.(SymbolicUtils.arguments(a); regularise)
    wick_contractions = sum(wick_contractions)
    return make_real(SymbolicUtils.expand(wick_contractions))
end
function wick_contraction(a::QMul; regularise=true)
    @assert is_conserved(a)
    @assert is_physical(a)

    contraction = wick_contraction(a.args_nc)
    propagators = make_propagators(contraction)
    if regularise
        propagators = _regularise(propagators)
        set_reg_to_zero!(propagators)
    end
    return a.arg_c * make_term(propagators)
end

function wick_contraction(args_nc::Vector{QField})::Vector{Vector{Vector{QField}}}
    _partitions = Combinatorics.partitions(args_nc, length(args_nc) ÷ 2)
    wick_contractions = Vector{Vector{QField}}[]
    for v in _partitions
        if contraction_filter(v)
            push!(wick_contractions, v)
        end
    end
    return wick_contractions
end

function contraction_filter(v)
    istwo = all(length.(v) .== 2) # only two-point contractions
    if !istwo
        return false
    elseif !all(is_conserved.(v)) # contractions with creation/annihilation
        return false
    elseif !all(is_physical_propagator.(v)) # propagators are physical
        return false
    else # there should be no quantum-quantum contractions
        return !has_qq_contraction(v)
    end
end

function make_propagators(contraction::Vector{Vector{Vector{QField}}})::Vector{Vector{SNuN}}
    propagators = map(contraction) do factor
        to_prop = x -> propagator(x...)
        _propagators = to_prop.(factor)
        sort!(_propagators; by=position)
    end
    return propagators
end

make_mul(v::Vector{SNuN}) = isempty(v) ? 0 : prod(v)
make_term(vp::Vector{Vector{SNuN}}) = isempty(vp) ? 0 : sum(make_mul, vp)
