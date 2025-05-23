struct Diagram{E,T}
    contractions::T
end
function Diagram(contractions::Vector{<:Contraction})
    @assert length(contractions) > 0 "Contraction vector must not be empty"
    E = length(contractions)
    sort!(contractions; by=sort_contraction)
    edges = StaticArrays.sacollect(
        SVector{length(contractions),Edge}, Edge(c) for c in contractions
    )
    return Diagram{E,typeof(edges)}(edges)
end
function Diagram(contractions::Vector{<:Edge})
    @assert length(contractions) > 0 "Contraction vector must not be empty"
    E = length(contractions)
    # sort!(contractions; by=sort_contraction)
    # TODO: sort to be sure?
    edges = StaticArrays.sacollect(
        SVector{length(contractions),Edge}, c for c in contractions
    )
    return Diagram{E,typeof(edges)}(edges)
end
Base.isequal(d1::Diagram, d2::Diagram) = isequal(d1.contractions, d2.contractions)
Base.hash(d::Diagram, h::UInt) = hash(d.contractions, h)

struct Diagrams{E,T}
    diagrams::Dict{Diagram{E,T},ComplexF64} # TODO try SwissDict or RobinDict from DataStructures.jl.
end
function Diagrams(E::Int)
    Diagrams{E,SVector{E,Edge}}(Dict{Diagram{E,SVector{E,Edge}},ComplexF64}())
end
function Diagrams(diagrams::Vector{Diagram{E,T}}, prefactor::ComplexF64) where {E,T}
    dict = Dict{Diagram{E,T},ComplexF64}(d => prefactor for d in diagrams)
    Diagrams{E,T}(dict)
end
function Diagrams(contractions::Vector{Vector{Contraction}}, prefactor::ComplexF64)
    @assert length(contractions) > 0 "Contraction vector must not be empty"
    c = first(contractions)
    E = length(c)
    T = SVector{E,Edge}
    imag_factor = im^E # Contraction becomes propagator
    dict = Dict{Diagram{E,T},ComplexF64}(
        Diagram(c) => imag_factor*prefactor for c in contractions
    )
    Diagrams{E,T}(dict)
end
Base.isequal(d1::Diagrams, d2::Diagrams) = isequal(d1.diagrams, d2.diagrams)
Base.iszero(d::Diagrams) = isempty(d.diagrams)

number_of_propagators(a::QMul) = length(a) ÷ 2

# Add a single diagram, summing prefactors if it already exists
function Base.push!(collection::Diagrams, diagram::Diagram, prefactor::Number)
    if haskey(collection.diagrams, diagram)
        collection.diagrams[diagram] += prefactor
    else
        collection.diagrams[diagram] = prefactor
    end
    return collection
end

function filter_nonzero!(collection::Diagrams)
    filter!((kv) -> !iszero(kv[2]), collection.diagrams)
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
function multiply!(collection::Diagrams, prefactor::Number)
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

function bulk_multiplicity(edges::SVector{N,Tuple{Int,Int}}) where {N}
    ff = edge -> !(1 ∈ edge) && !(2 ∈ edge) && !isequal(edge[1], edge[2])
    edges = filter(ff, edges)
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
function bulk_multiplicity(vs::SVector{N,KeldyshContraction.Edge}) where {N}
    bulk_multiplicity(map(integer_positions, vs))
end
# bulk_multiplicity(vs::Vector) = bulk_multiplicity(integer_positions(vs))

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
