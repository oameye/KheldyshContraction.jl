#################################
#       Consistency checks
#################################

is_qq_contraction(v::Vector{T}) where {T<:QField} = iszero(sum(Int.(contour.(v))))
has_qq_contraction(vv::Vector{Vector{QField}}) = any(is_qq_contraction.(vv))

function is_conserved(a::QMul)
    args_nc_ = a.args_nc
    n_destroy = isa.(args_nc_, Destroy)
    if length(args_nc_) == 0 || iszero(sum(n_destroy))
        return false
    else
        length(args_nc_) == 1
        return length(args_nc_) ÷ sum(n_destroy) == 2
    end
end
is_conserved(a::Vector{QField}) = is_conserved(QMul(1, a))
is_conserved(a::QAdd) = all(is_conserved.(arguments(a)))
is_conserved(a::QSym) = false

function is_physical(a::QMul)
    args_nc_ = a.args_nc
    positions = acts_on.(args_nc_)
    in_out = iszero(sum(positions)) # checks if a mul has both in-out in a lagrangian
    physical = all(map(is_physical, args_nc_)) # individual field are physical
    return physical && in_out
end
is_physical(a::Vector{QField}) = is_physical(QMul(1, a))
is_physical(a::QAdd) = all(is_physical.(arguments(a)))
is_physical(a::Destroy) = Int(position(a)) <= 0
is_physical(a::Create) = Int(position(a)) >= 0

function is_physical_propagator(a::Vector{QField})
    len = length(a) == 2 # propagator has length 2
    positions = acts_on.(a)
    # ∨ Can't make a propagator with In and Out coordinate
    in_out = abs(-(positions...)) < 2
    physical = all(is_physical.(a))
    return len && in_out && physical
end

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
regular(v::Vector{Average}) = all(regular.(v))
regularise(vp::Vector{Vector{Average}}) = filter(regular, vp)

function set_reg_to_zero!(p::Average)
    p.arguments .= set_reg_to_zero.(arguments(p))
    p
end
function set_reg_to_zero!(vp::Union{Vector{Average},Vector{Vector{Average}}})
    for p in vp
        set_reg_to_zero!(p)
    end
    return vp
end

#################################
#       Contraction
#################################

function wick_contraction(a::QMul)
    @assert is_conserved(a)
    @assert is_physical(a)

    contraction = wick_contraction(a.args_nc)
    propagators = make_propagators(contraction)
    regular_propagators = regularise(propagators)
    set_reg_to_zero!(regular_propagators)
    return a.arg_c * make_term(regular_propagators)
end
function wick_contraction(a::QAdd)
    return SymbolicUtils.expand(sum(wick_contraction.(SymbolicUtils.arguments(a))))
end

function wick_contraction(args_nc::Vector{QField})::Vector{Vector{Vector{QField}}}
    _partitions = collect(partitions(args_nc, length(args_nc) ÷ 2))
    equal_partitions = filter(v -> length(unique(length.(v))) == 1, _partitions)

    wick_contractions = filter(equal_partitions) do v
        conserved = all(is_conserved.(v))
        physical = all(is_physical_propagator.(v))
        no_qq = !has_qq_contraction(v)
        conserved && physical && no_qq
    end
    return wick_contractions
end

function make_propagators(
    contraction::Vector{Vector{Vector{QField}}}
)::Vector{Vector{Average}}
    propagators = map(contraction) do factor
        to_prop = x -> propagator(x...)
        _propagators = to_prop.(factor)
        sort!(_propagators; by=acts_on)
    end
    return propagators
end

make_mul(v::Vector{Average}) = isempty(v) ? 0 : prod(v)
make_term(vp::Vector{Vector{Average}}) = isempty(vp) ? 0 : sum(make_mul, vp)
