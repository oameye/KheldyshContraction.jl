
function is_canonical(props::Vector)
    _is_canonical = true
    for prop in props
        if !is_canonical(prop)
            _is_canonical = false
            break
        end
    end
    return _is_canonical
end
function is_canonical(prop::Average)
    p1, p2 = positions(prop)
    is_canonical(p1, p2)
end
function is_canonical(p1, p2)
    # if In() == p2 && index(p1) < 2 # assumes two bulk coordinates
        _is_canonical = false
    if Out() == p1 && index(p2) > 1
        _is_canonical = false
    else
        _is_canonical = true
    end
    return _is_canonical
end
function swap_bulk_position!(props::Vector)
    for prop in props
        _fields = fields(prop)
        for (i, ψ) in pairs(_fields)
            if isbulk(ψ)
                idx = index(position(ψ))
                prop.arguments[i] = ψ(Bulk(mod1(idx + 1, 2)))
            end
        end
    end
    return props
end

function canonicalize!(props::Vector)
    canonical = is_canonical(props)
    if !canonical
        swap_bulk_position!(props)
    end
    return props
end
function canonicalize(term::T) where {T<:SymbolicUtils.Symbolic}
    props = get_propagators(term)
    if is_canonical(props)
        return term
    else
        canonicalize!(props)
    end
    return get_prefactor(term)*prod(props)
end
function is_canonical(term::T) where {T<:SymbolicUtils.Symbolic}
    props = get_propagators(term)
    return is_canonical(props)
end

function get_prefactor(term::T) where {T<:SymbolicUtils.Symbolic}
    props = get_propagators(term)
    SymbolicUtils.substitute(term, Dict(zip(props,ones(length(props)))))
end
