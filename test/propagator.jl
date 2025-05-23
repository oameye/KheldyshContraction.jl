using KeldyshContraction, Test
using KeldyshContraction: In, Out, Classical, Quantum, Plus, Minus
using KeldyshContraction: Edge, position, contour

@qfields ϕᶜ::Destroy(Classical) ϕᴾ::Destroy(Quantum)

@testset "propagator checks" begin
    @test_throws MethodError Edge((ϕᶜ, ϕᶜ)) # annihilation creation
    # @test_throws AssertionError Propagator(ϕᶜ, ϕᶜ') # same coordinate
    @test_throws AssertionError Edge((ϕᶜ(In()), ϕᶜ'(Out()))) # In-Out
    @test_throws AssertionError Edge((ϕᶜ(Out()), ϕᶜ'(In()))) # In-Out
    @test_throws AssertionError Edge((ϕᶜ(Out()), ϕᶜ'(Out()))) # same coordinate
    @test_throws AssertionError Edge((ϕᴾ, ϕᴾ(In())')) # quantum-quantum
    @test_throws AssertionError Edge((ϕᶜ(In()), ϕᴾ')) # Out is In
    @test_throws AssertionError Edge((ϕᶜ, ϕᶜ'(Out()))) # In is Out
end

@testset "properties" begin
    p = Edge(ϕᴾ, ϕᶜ'(In()))
    @test KeldyshContraction.position(p) isa In
    @test_broken KeldyshContraction.contours(p) == [Quantum, Classical]
    @test !KeldyshContraction.isbulk(p)
    @test_broken KeldyshContraction.regularisations(p) == fill(KeldyshContraction.Zero, 2)
    @test KeldyshContraction.propagator_type(p) == KeldyshContraction.Advanced
end

@testset "diagram construction" begin
    using KeldyshContraction: Diagram, Contraction
    contractions = Contraction[(ϕᴾ, ϕᶜ'(In())), (ϕᶜ, ϕᶜ'), (ϕᶜ(Out()), ϕᴾ')]

    Diagram(contractions)
end

@testset "sort" begin
    p1 = (ϕᴾ, ϕᶜ'(In()))
    p2 = (ϕᴾ, ϕᶜ')
    @test isequal(sort!([p1, p2]; by=KeldyshContraction.sort_contraction), [p2, p1])
end

@testset "adjoint" begin
    p1 = Edge(ϕᴾ, ϕᶜ'(In()))
    p2 = Edge(ϕᶜ, ϕᴾ'(In()))
    @test_broken isequal(p1', p2) # (G^R)† = G^A

    p = Edge(ϕᶜ, ϕᶜ'(In()))
    @test_broken isequal(p', -1 * p) # (G^K)† = -G^K
end

@testset "regularisation" begin
    p = Edge(ϕᴾ(Plus), ϕᶜ')
    @test_broken KeldyshContraction.regular(p) == false

    p = Edge(ϕᶜ(Minus), ϕᶜ'(In()))
    @test_broken KeldyshContraction.regular(p) == true
end

@testset "propagator type" begin
    using KeldyshContraction: is_keldysh, is_retarded, is_advanced
    using KeldyshContraction: Advanced, Retarded, Keldysh

    @test is_keldysh(Keldysh)
    @test is_retarded(Retarded)
    @test is_advanced(Advanced)
    @test is_keldysh(Edge(ϕᶜ, ϕᶜ'))
    @test is_retarded(Edge(ϕᶜ, ϕᴾ'))
    @test is_advanced(Edge(ϕᴾ, ϕᶜ'))
end

@testset "position" begin
    using KeldyshContraction: position, same_position, Bulk, In, Out
    p = (ϕᴾ, ϕᶜ')
    @test same_position(p)
    p = (ϕᴾ(Out()), ϕᶜ')
    @test !same_position(p)
    p = (ϕᴾ(Bulk(3)), ϕᶜ(Bulk(3))')
    @test same_position(p)
end
