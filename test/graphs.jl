using KeldyshContraction, Test, Graphs
using KeldyshContraction: Bulk, In, Out

@testset "construction" begin
    @qfields c::Destroy(Classical) q::Destroy(Quantum)

    vs = KeldyshContraction.Contraction[(c(Out()), q'), (c, q'), (c, q(In())')]

    g = KeldyshContraction.graph(vs)
    @test Graphs.nv(g) == 3
    @test Graphs.ne(g) == 3
end

@testset "is_connected" begin
    @qfields c::Destroy(Classical) q::Destroy(Quantum)

    vs = KeldyshContraction.Contraction[(c(Out()), q'), (c, q'), (c, q(In())')]
    @test KeldyshContraction.is_connected(vs)

    vs2 = KeldyshContraction.Contraction[(c(Out()), q'), (c, q')]
    @test !KeldyshContraction.is_connected(vs2)
end
