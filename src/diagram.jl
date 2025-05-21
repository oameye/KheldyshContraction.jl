struct Diagram{E}
    contractions::SVector{E,Edge}
    function Diagram(contractions::Vector{Contraction})
        @assert length(contractions) > 0 "Contraction vector must not be empty"
        E = length(contractions)
        sort!(contractions; by=sort_contraction)
        edges = StaticArrays.sacollect(
            SVector{length(contractions),Edge}, Edge(c) for c in contractions
        )
        return new{E}(edges)
    end
end
Base.isequal(d1::Diagram, d2::Diagram) = isequal(d1.contractions, d2.contractions)
Base.hash(d::Diagram, h::UInt) = hash(d.contractions, h)

struct Diagrams
    diagrams::Dict{Diagram, ComplexF64} # TODO try SwissDict or RobinDict from DataStructures.jl.
end
Diagrams() = Diagrams(Dict{Diagram,Number}())
function Diagrams(diagrams::Vector{Diagram}, prefactor::Number)
    dict = Dict{Diagram,Number}(d => prefactor for d in diagrams)
    Diagrams(dict)
end
function Diagrams(contractions::Vector{Vector{Contraction}}, prefactor::Number)
    imag_factor = im^(first(length(contractions))) # Contraction becomes propagator
    dict = Dict{Diagram,Number}(Diagram(c) => imag_factor*prefactor for c in contractions)
    Diagrams(dict)
end

# Add a single diagram, summing prefactors if it already exists
function Base.push!(collection::Diagrams, diagram::Diagram, prefactor::Number)
    if haskey(collection.diagrams, diagram)
        collection.diagrams[diagram] += prefactor
    else
        collection.diagrams[diagram] = prefactor
    end
    return collection
end

# Add multiple diagrams (with optional prefactor)
# function Base.push!(collection::Diagrams, diagrams::Diagram...)
#     for diagram in diagrams
#         push!(collection, diagram)
#     end
#     return collection
# end

# Convert to vector of diagrams (ignoring prefactors)
function Base.collect(collection::Diagrams)
    return collect(keys(collection.diagrams))
end
function multuply!(collection::Diagrams, prefactor::Number)
    foreach(collection) do (diagram, coeff)
        collection.diagrams[diagram] *= prefactor
    end
    collection
end

# Make the collection iterable (iterate over pairs)
Base.iterate(collection::Diagrams) = iterate(collection.diagrams)
Base.iterate(collection::Diagrams, state) = iterate(collection.diagrams, state)
Base.length(collection::Diagrams) = length(collection.diagrams)
Base.eltype(::Type{Diagrams}) = Pair{Diagram,Number}

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

function bulk_multiplicity(edges::Vector{Tuple{Int,Int}})
    ff = edge -> !(1 ∈ edge) && !(2 ∈ edge) && !isequal(edge[1], edge[2])
    filter!(ff, edges)
    map!(edge -> edge .- 2, edges, edges)

    vert = vertices(edges)
    m = max_edges(length(vert))
    mult = SmallCollections.MutableSmallVector{m,Int}(0 for i in 1:m)
    for edge in edges
        idx = edge_to_index(edge[1], edge[2], length(vert))
        mult[idx] += 1
    end
    return mult
end
bulk_multiplicity(vs::Vector{Contraction}) = bulk_multiplicity(integer_positions.(vs))
bulk_multiplicity(vs::Vector) = bulk_multiplicity(integer_positions(vs))

max_edges(n::Int)::Int = n * (n - 1) ÷ 2

"""
maps edge (i,j) to a unique integer in range 1:max_edges(n).
It assumes that i ≠ j
"""
function edge_to_index(i::Int, j::Int, n::Int)
    # Ensure i < j
    i, j = minmax(i, j)

    # Calculate unique index
    # This maps edge (i,j) to a unique integer in range 1:max_edges(n)
    return (i-1)*(n-i÷2) + (j-i)
end
