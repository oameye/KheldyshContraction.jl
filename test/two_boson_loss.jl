using KeldyshContraction, Test
using KeldyshContraction: In, Out, Classical, Quantum, Plus, Minus
using KeldyshContraction: is_physical, is_conserved, make_propagators, propagator
# h = BosonicField(:cavity)

@qfields ϕᶜ::Destroy(Classical) ϕᴾ::Destroy(Quantum)

L_int =
    0.5 * ϕᶜ' * ϕᴾ' * (ϕᶜ(Minus) * ϕᶜ(Minus) + ϕᴾ(Minus) * ϕᴾ(Minus)) -
    0.5 * ϕᶜ(Minus) * ϕᴾ(Minus) * (ϕᶜ' * ϕᶜ' + ϕᴾ' * ϕᴾ') +
    ϕᶜ' * ϕᴾ' * (ϕᶜ(Plus) * ϕᴾ(Plus) + ϕᶜ(Minus) * ϕᴾ(Minus))

expr = ϕᶜ(Out) * ϕᶜ'(In) * L_int

@test is_conserved(expr)
@test is_physical(expr)

@testset "wick contractions" begin
    wick_contractions = wick_contraction(expr.arguments[1].args_nc)
    @test length(wick_contractions) == 4

    propagators = make_propagators(wick_contractions)
    regularized_wick = KeldyshContraction.regularise(propagators)
    @test length(regularized_wick) == 2
    @test length(unique(regularized_wick)) == 1
    @test isequal(wick_contraction(expr.arguments[1]), *(regularized_wick[1]...))

    a = wick_contraction(expr)
end
