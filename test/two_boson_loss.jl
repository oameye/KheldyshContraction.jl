using KeldyshContraction, Test
using KeldyshContraction: In, Out, Classical, Quantum, Plus, Minus
using KeldyshContraction:
    is_physical, is_conserved, make_propagators, propagator, construct_self_energy

@qfields ϕᶜ::Destroy(Classical) ϕᴾ::Destroy(Quantum)

L_int =
    im*(
        0.5 * ϕᶜ' * ϕᴾ' * (ϕᶜ(Minus) * ϕᶜ(Minus) + ϕᴾ(Minus) * ϕᴾ(Minus)) -
        0.5 * ϕᶜ(Plus) * ϕᴾ(Plus) * (ϕᶜ' * ϕᶜ' + ϕᴾ' * ϕᴾ') +
        ϕᶜ' * ϕᴾ' * (ϕᶜ(Plus) * ϕᴾ(Plus) + ϕᶜ(Minus) * ϕᴾ(Minus))
    )

@testset "vacuum bubble" begin
    @test !isequal(wick_contraction(L_int; regularise=false), 0.0)
    @test isequal(wick_contraction(L_int; regularise=true), 0.0)
end

@testset "wick contractions" begin
    @testset "classical-classical Green's function" begin
        expr = ϕᶜ(Out) * ϕᶜ'(In) * L_int

        @test is_conserved(expr)
        @test is_physical(expr)

        wick_contractions = wick_contraction(expr.arguments[1].args_nc)
        @test length(wick_contractions) == 4

        propagators = make_propagators(wick_contractions)
        regularized_wick = KeldyshContraction._regularise(propagators)
        @test length(regularized_wick) == 2
        @test length(unique(regularized_wick)) == 1
        # @test isequal(wick_contraction(expr.arguments[1]), *(regularized_wick[1]...))

        a = wick_contraction(expr)
    end
    @testset "quantum-quantum Green's function" begin
        expr = ϕᴾ(Out) * ϕᴾ'(In) * L_int

        @test is_conserved(expr)
        @test is_physical(expr)

        # ∨ should this be zero?
        @test !isequal(wick_contraction(expr; regularise=false), 0.0)
        @test isequal(wick_contraction(expr; regularise=true), 0.0)
    end
end

@testset "self-energy" begin
    using KeldyshContraction: Advanced, Retarded, Keldysh
    using KeldyshContraction: Propagator, make_propagator
    L = InteractionLagrangian(L_int)
    GF = wick_contraction(L)
    Σ = SelfEnergy(GF)
    @testset "correctness check" begin
        advanced_test = isequal(
            Σ.advanced, -1*make_propagator(ϕᶜ, ϕᶜ') + make_propagator(ϕᶜ, ϕᴾ')
        )
        retarded_test = isequal(
            Σ.retarded, make_propagator(ϕᶜ, ϕᶜ') + make_propagator(ϕᴾ, ϕᶜ')
        )
        keldysh_test = isequal(
            Σ.keldysh,
            2 * make_propagator(ϕᶜ, ϕᶜ') - make_propagator(ϕᶜ, ϕᴾ') +
            make_propagator(ϕᴾ, ϕᶜ'),
        )
        @test advanced_test
        @test retarded_test
        @test keldysh_test
        # ^ pretty sure Gerbino thesis is wrong and switshes retarded and advanced
        # and we compute the correct
        # In his paper it is correct https://arxiv.org/pdf/2406.20028 :)
    end

    @testset "Keldysh GF is enough" begin
        expr_K = ϕᶜ(Out) * ϕᶜ'(In) * L_int
        G_K1 = wick_contraction(expr_K)

        @test isequal(construct_self_energy(G_K1)[Advanced], Σ.advanced)
        @test isequal(construct_self_energy(G_K1)[Retarded], Σ.retarded)
    end
end
