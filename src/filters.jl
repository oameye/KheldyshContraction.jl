#################################
#       Consistency checks
#################################

is_qq_contraction(v::Contraction) = iszero(sum(Int.(contour.(v))))
# has_qq_contraction(vv::Vector{Vector{<:QField}}) = any(is_qq_contraction.(vv))

function is_physical_propagator(a::Contraction)
    len = length(a) == 2 # propagator has length 2
    positions = position.(a)
    # ∨ Can't make a propagator with In and Out coordinate
    in_out = In() ∈ positions ? !(Out() ∈ positions) : true
    physical = all(is_physical.(a))
    return len && in_out && physical
end

function contraction_filter(v)
    # istwo = all(length.(v) .== 2) # only two-point contractions
    # if !istwo
    #     return false
    if !is_conserved(v) # contractions with creation/annihilation
        return false
    elseif !is_physical_propagator(v) # propagators are physical
        return false
    else # there should be no quantum-quantum contractions
        return !is_qq_contraction(v)
    end
end

"""
Filter the zero loops from the list of contractions

Gᴿ(1,2) Gᴿ(2,1) = 0
Gᴬ(1,2) Gᴬ(2,1) = 0
Gᴿ(1,2) Gᴬ(1,2) = 0
"""
function has_zero_loop(vs::Vector{Contraction})
    ps = positions.(vs)
    sorted_ps = sort_tuple.(ps)
    loops = find_equal_pairs(sorted_ps)
    for loop in loops
        T1 = propagator_type(vs[loop[1]]...)
        T2 = propagator_type(vs[loop[2]]...)
        if all(is_retarded, (T1, T2)) && is_reversed(ps[loop[1]], ps[loop[2]])
            @info "Has zero loop"
            return true
        elseif all(is_advanced, (T1, T2)) && is_reversed(ps[loop[1]], ps[loop[2]])
            @info "Has zero loop"
            return true
        elseif isequal(ps[loop[1]], ps[loop[2]]) && retarded_and_advanced_pair(T1, T2)
            @info "Has zero loop"
            return true
        end
    end
    return false
end

function is_reversed(p1, p2)
    return isequal(p1[1], p2[2]) && isequal(p1[2], p2[1])
end
function retarded_and_advanced_pair(T1, T2)
    (is_retarded(T1) && is_advanced(T2)) || (is_advanced(T1) && is_retarded(T2))
end
function find_equal_pairs(vec)
    n = length(vec)
    pairs = Tuple{Int,Int}[]

    for i in 1:n
        for j in (i + 1):n
            if isequal(vec[i], vec[j])
                push!(pairs, (i, j))
            end
        end
    end

    return pairs
end

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
function regular(qs::Contraction)
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
