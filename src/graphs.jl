
# function graph(vs::Vector{Contraction})
#     ps = integer_positions.(vs)
#     in_or_out = findfirst(p -> 1 ∈ p || 2 ∈ p, ps)
#     if isnothing(in_or_out) # in case it a vacuum diagram
#         ps′ = map(p -> p .- 2, ps)
#         graph = Graphs.SimpleGraphFromIterator(Graphs.Edge.(ps′))
#     else
#         graph = Graphs.SimpleGraphFromIterator(Graphs.Edge.(ps))
#     end
#     return graph
# end

# function is_connected(vs::Vector{Contraction})
#     g = graph(vs)
#     connected = Graphs.is_connected(g)
#     if connected
#         return true
#     else
#         @info "Contraction is not connected:" integer_positions.(vs)
#         return false
#     end
# end # TODO: circumvent the graph library

function is_connected(vs::Vector{Contraction})
    ps = integer_positions.(vs)
    in_or_out = findfirst(p -> 1 ∈ p || 2 ∈ p, ps) # in case it a vacuum diagram
    edges = isnothing(in_or_out) ? map(p -> p .- 2, ps) : ps
    return is_connected(edges)
end

function is_connected(edges::Vector{Tuple{Int,Int}})
    # Find all unique vertices
    all_vertices = vertices(edges)
    if isempty(all_vertices)
        return true  # Empty graph is considered connected
    end

    # Find connected components using BFS
    components = connected_components(all_vertices, edges)

    is_single_component = length(components) == 1

    if !is_single_component
        @info "Contraction is not connected. Found $(length(components)) components:"
        for (i, comp) in enumerate(components)
            @info "Component $i: $comp"
        end
    end

    return is_single_component
end

function vertices(ps)
    vertices = Set{Int}()
    for edge in ps
        push!(vertices, edge[1])
        push!(vertices, edge[2])
    end
    return vertices
end

function connected_components(vertices, edges)
    # Find connected components using BFS
    components = Vector{Set{Int}}()
    remaining = Set(vertices)

    while !isempty(remaining)
        component = Set{Int}()
        queue = [first(remaining)]
        push!(component, first(queue))
        delete!(remaining, first(queue))

        while !isempty(queue)
            current = popfirst!(queue)

            # Find neighbors
            for edge in edges
                neighbor = nothing
                if edge[1] == current
                    neighbor = edge[2]
                elseif edge[2] == current
                    neighbor = edge[1]
                end

                if !isnothing(neighbor) && neighbor ∈ remaining
                    push!(queue, neighbor)
                    push!(component, neighbor)
                    delete!(remaining, neighbor)
                end
            end
        end

        push!(components, component)
    end
    return components
end
