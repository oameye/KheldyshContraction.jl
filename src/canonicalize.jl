function canonicalize(vs::Vector{Contraction})
    # TODO: assumes lower then third order
    canonical = is_canonical(vs)
    if !canonical
        vs = map(vs) do c
            map(c) do ψ
                if isbulk(ψ)
                    idx = index(position(ψ))
                    ψ(Bulk(mod1(idx + 1, 2)))
                else
                    ψ
                end
            end
        end
    end
    return vs
end
function is_canonical(vs::Vector{Contraction})
    # TODO: assumes lower then third order
    idx_out = findfirst(c -> Out() ∈ position.(c), vs)
    if isnothing(idx_out)
        return true
    else
        return Bulk() ∈ position.(vs[idx_out])
    end
end
