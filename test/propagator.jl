using KeldyshContraction, Test
using KeldyshContraction: In, Out, Classical, Quantum, Plus, Minus
using KeldyshContraction: propagator, position, contour

@qfields ϕᶜ::Destroy(Classical) ϕᴾ::Destroy(Quantum)

@testset "propagator checks" begin
    @test_throws AssertionError propagator(ϕᶜ, ϕᶜ) # annihilation creation
    # @test_throws AssertionError Propagator(ϕᶜ, ϕᶜ') # same coordinate
    @test_throws AssertionError propagator(ϕᶜ(In), ϕᶜ'(Out)) # In-Out
    @test_throws AssertionError propagator(ϕᶜ(Out), ϕᶜ'(In)) # In-Out
    @test_throws AssertionError propagator(ϕᶜ(Out), ϕᶜ'(Out)) # same coordinate
    @test_throws AssertionError propagator(ϕᴾ, ϕᴾ(In)') # quantum-quantum
    @test_throws AssertionError propagator(ϕᶜ(In), ϕᴾ') # Out is In
    @test_throws AssertionError propagator(ϕᶜ, ϕᶜ'(Out)) # In is Out
end

@testset "properties" begin
    p = propagator(ϕᴾ, ϕᶜ'(In))
    @test KeldyshContraction.acts_on(p) == 1
    @test KeldyshContraction.contours(p) == [Quantum, Classical]
    @test !KeldyshContraction.isbulk(p)
    @test KeldyshContraction.regularisations(p) == fill(KeldyshContraction.Zero, 2)
    @test KeldyshContraction.propagator_type(p) == KeldyshContraction.Advanced
end

# @testset "undo_average" begin
#     p = propagator(ϕᶜ, ϕᶜ'(In))
#     @test isequal(KeldyshContraction.undo_average(p), ϕᶜ*ϕᶜ'(In))
# end

@testset "math" begin
    p1 = propagator(ϕᶜ, ϕᶜ'(In))
    p2 = propagator(ϕᶜ, ϕᶜ'(In))
    @test isequal(p1 + p2, 2*p1)
    @test isequal(p1*p2, p1^2)
end

@testset "regularisation" begin
    p = propagator(ϕᶜ(Minus), ϕᶜ'(In))
    @test KeldyshContraction.regular(p) == true
    KeldyshContraction.set_reg_to_zero!(p)
    @test KeldyshContraction.regularisations(p) == fill(KeldyshContraction.Zero, 2)
end
