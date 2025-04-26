using KeldyshContraction, Test
using KeldyshContraction: In, Out, Classical, Quantum, Plus, Minus
using KeldyshContraction: Bulk, position

@qfields ϕᶜ::Destroy(Classical) ϕᴾ::Destroy(Quantum)

L_int =
    im*(
        0.5 * ϕᶜ' * ϕᴾ' * (ϕᶜ(Minus) * ϕᶜ(Minus) + ϕᴾ(Minus) * ϕᴾ(Minus)) -
        0.5 * ϕᶜ(Plus) * ϕᴾ(Plus) * (ϕᶜ' * ϕᶜ' + ϕᴾ' * ϕᴾ') +
        ϕᶜ' * ϕᴾ' * (ϕᶜ(Plus) * ϕᴾ(Plus) + ϕᶜ(Minus) * ϕᴾ(Minus))
    )
L = InteractionLagrangian(L_int)

@testset "set_position" begin
    @test position(L) == Bulk(1)
    @test position(L(2)) == Bulk(2)
end

@testset "ladder sorted" begin
    L1 = L
    L2 = L(2)
    expr = L1.lagrangian * L2.lagrangian
    for arg in expr.arguments
        sorted = sort(arg.args_nc; by=KeldyshContraction.ladder)
        @test isequal(arg.args_nc, sorted)
    end
end

@testset "contraction" begin
    L1 = L
    L2 = L(2)
    expr = ϕᶜ(Out()) * ϕᶜ'(In()) * L1.lagrangian * L2.lagrangian

    @test wick_contraction(expr.arguments[1]) == 0.0

    wick_contraction(L; order=2)

    @test_throws "not implemented" wick_contraction(L; order=3)
end
