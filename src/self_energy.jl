const PositionPropagatorType = OrderedCollections.LittleDict{
    Int64,
    PropagatorType,
    Tuple{Int64,Int64,Int64},
    Tuple{PropagatorType,PropagatorType,PropagatorType},
}
function self_energy_type(dict::PositionPropagatorType)
    right = is_retarded(dict[-1]) ? Quantum : Classical
    left = is_advanced(dict[1]) ? Quantum : Classical
    if Int.([right, left]) == [0, 0]
        return Keldysh
    elseif Int.([right, left]) == [1, 0]
        return Retarded
    elseif Int.([right, left]) == [0, 1]
        return Advanced
    else
        @show dict
        error("Classical-Classical for self-energy should be zero.")
    end
end

function construct_self_energy(expr::SymbolicUtils.Symbolic)
    self_energy = Dict{PropagatorType,SNuN}((
        Advanced => 0, Retarded => 0, Keldysh => 0
    ))

    terms = SymbolicUtils.arguments(expr)

    for term in terms
        args = SymbolicUtils.arguments(term)
        idxs_c = findall(x -> !(x isa Average), args)
        idxs_p = setdiff(eachindex(args), idxs_c)
        args_p = args[idxs_p]

        positions = KeldyshContraction.acts_on.(args_p)
        bulk_propagator = args_p[findfirst(iszero, positions)]
        dict = OrderedCollections.freeze(
            OrderedCollections.OrderedDict(zip(positions, propagator_type.(args_p)))
        )

        to_add = isempty(idxs_c) ? bulk_propagator : *(args[idxs_c]...) * bulk_propagator
        self_energy[self_energy_type(dict)] += to_add
    end
    return self_energy
end
