using KeldyshContraction, Test
using KeldyshContraction: Bulk, In, Out

# @testset "construction" begin
#     @qfields c::Destroy(Classical) q::Destroy(Quantum)

#     vs = KeldyshContraction.Contraction[(c(Out()), q'), (c, q'), (c, q(In())')]

#     g = KeldyshContraction.graph(vs)
#     @test Graphs.nv(g) == 3
#     @test Graphs.ne(g) == 3
# end

@testset "is_connected" begin
    # ps = [(3, 3), (3, 3)]
    # g = Graphs.SimpleGraphFromIterator(Graphs.Edge.(ps))
    # length(connected_components(g))
    # Graphs.is_connected(g)

    @qfields c::Destroy(Classical) q::Destroy(Quantum)

    vs = KeldyshContraction.Contraction[(c(Out()), q'), (c, q'), (c, q(In())')]
    @test KeldyshContraction.is_connected(vs)

    vs2 = KeldyshContraction.Contraction[(c, q')]
    @test KeldyshContraction.is_connected(vs2)

    vs3 = KeldyshContraction.Contraction[(c, q'), (c(Out()), q'(In()))]
    @test !KeldyshContraction.is_connected(vs3)
end

@testset "bulk multiplicity" begin
    @qfields c::Destroy(Classical) q::Destroy(Quantum)

    vs = [(1,3), (3,3), (3,2)]
    @test KeldyshContraction.bulk_multiplicity(vs) == Int[]

    vs2 = [(1,3), (3,3), (3,4), (4,4), (4,2)]
    @test KeldyshContraction.bulk_multiplicity(vs2) == Int[1]

    vs3 = [(1,3), (3,4), (4,3), (4,4), (3,2)]
    @test KeldyshContraction.bulk_multiplicity(vs3) == Int[2]

    vs4 = [(1,3), (3,4), (4,3), (4,4), (3,5), (5,5), (5,2)]
    @test KeldyshContraction.bulk_multiplicity(vs4) == Int[0,1,2]
end

@testset "vertices" begin
    # Empty edge list
    edges1 = Tuple{Int,Int}[]
    @test KeldyshContraction.vertices(edges1) == Set{Int}()

    # Single edge
    edges2 = [(1, 2)]
    @test KeldyshContraction.vertices(edges2) == Set([1, 2])

    # Multiple edges
    edges3 = [(1, 2), (2, 3), (3, 4)]
    @test KeldyshContraction.vertices(edges3) == Set([1, 2, 3, 4])

    # Self-loops
    edges4 = [(1, 1), (2, 2)]
    @test KeldyshContraction.vertices(edges4) == Set([1, 2])

    # Duplicate vertices
    edges5 = [(1, 2), (2, 3), (1, 3)]
    @test KeldyshContraction.vertices(edges5) == Set([1, 2, 3])
end

@testset "connected components" begin
    # Empty graph
    edges1 = Tuple{Int,Int}[]
    vertices1 = Set{Int}()
    @test KeldyshContraction.connected_components(vertices1, edges1) == Vector{Set{Int}}()

    # Single node
    vertices2 = Set([1])
    edges2 = Tuple{Int,Int}[]
    comps2 = KeldyshContraction.connected_components(vertices2, edges2)
    @test length(comps2) == 1
    @test comps2[1] == Set([1])

    # Single connected component
    edges3 = [(1, 2), (2, 3), (3, 4)]
    vertices3 = KeldyshContraction.vertices(edges3)
    comps3 = KeldyshContraction.connected_components(vertices3, edges3)
    @test length(comps3) == 1
    @test comps3[1] == Set([1, 2, 3, 4])

    # Multiple connected components
    edges4 = [(1, 2), (3, 4), (5, 6)]
    vertices4 = KeldyshContraction.vertices(edges4)
    comps4 = KeldyshContraction.connected_components(vertices4, edges4)
    @test length(comps4) == 3
    @test Set([1, 2]) ∈ comps4
    @test Set([3, 4]) ∈ comps4
    @test Set([5, 6]) ∈ comps4

    # Complex graph with cycles
    edges5 = [(1, 2), (2, 3), (3, 1), (4, 5), (5, 6), (6, 4)]
    vertices5 = KeldyshContraction.vertices(edges5)
    comps5 = KeldyshContraction.connected_components(vertices5, edges5)
    @test length(comps5) == 2
    @test Set([1, 2, 3]) ∈ comps5
    @test Set([4, 5, 6]) ∈ comps5

    # Isolated vertices
    edges6 = [(1, 2), (2, 3)]
    vertices6 = Set([1, 2, 3, 4, 5])  # Note: 4 and 5 are isolated
    comps6 = KeldyshContraction.connected_components(vertices6, edges6)
    @test length(comps6) == 3
    @test Set([1, 2, 3]) ∈ comps6
    @test Set([4]) ∈ comps6
    @test Set([5]) ∈ comps6
end
