using LossyTransport, Test
using LossyTransport: In, Out, Classical, Quantum, Plus, Minus
using LossyTransport: propagator, position, contour


@qfields ϕᶜ::Destroy(Classical) ϕᴾ::Destroy(Quantum)


@testset "propagator checks" begin
    @test_throws AssertionError propagator(ϕᶜ, ϕᶜ) # annilihation creation
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
    @test LossyTransport.acts_on(p) == 1
    @test LossyTransport.contours(p) == [Quantum, Classical]
    @test !LossyTransport.isbulk(p)
    @test LossyTransport.regularisations(p) == fill(LossyTransport.Zero, 2)
    @test LossyTransport.propagator_type(p) == LossyTransport.Advanced
end

# @testset "undo_average" begin
#     p = propagator(ϕᶜ, ϕᶜ'(In))
#     @test isequal(LossyTransport.undo_average(p), ϕᶜ*ϕᶜ'(In))
# end

@testset "math" begin
    p1 = propagator(ϕᶜ, ϕᶜ'(In))
    p2 = propagator(ϕᶜ, ϕᶜ'(In))
    @test isequal(p1 + p2, 2*p1)
    @test isequal(p1*p2, p1^2)
end

@testset "regularisation" begin
    p = propagator(ϕᶜ(Minus), ϕᶜ'(In))
    @test LossyTransport.regular(p) == true
    LossyTransport.set_reg_to_zero!(p)
    @test LossyTransport.regularisations(p) == fill(LossyTransport.Zero, 2)
end
