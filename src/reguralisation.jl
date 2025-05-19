
######################
#     regularise
######################

"""
    regular(p::Average)

Checks if the propagator `p` is regular.
A regular propagator is one that is:
- not in the bulk
- or `p` is not of [`PropagatorType`](@ref) `Retarded` while also having a negative [`Regularisation`](@ref)
- or `p` is not of [`PropagatorType`](@ref) `Advanced` while also having a positive [`Regularisation`](@ref)
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
function regular(qs::Tuple{<:QSym,<:QSym})
    _isbulk = isbulk(qs)
    _reg = regularisations(qs)
    T = propagator_type(qs...)
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
