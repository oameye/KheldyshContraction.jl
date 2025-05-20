
function graph(vs::Vector{Contraction})
    ps = integer_positions.(vs)
    in_or_out = findfirst(p -> 1 ∈ p || 2 ∈ p, ps)
    if isnothing(in_or_out) # in case it a vacuum diagram
        ps′ = map(p -> p .- 2, ps)
        graph = Graphs.SimpleGraphFromIterator(Graphs.Edge.(ps′))
    else
        graph = Graphs.SimpleGraphFromIterator(Graphs.Edge.(ps))
    end
    return graph
end
