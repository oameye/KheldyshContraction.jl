using KeldyshContraction, Test
using KeldyshContraction: In, Out, Classical, Quantum, Plus, Minus
using KeldyshContraction: is_physical, is_conserved, construct_self_energy!

@qfields ϕᶜ::Destroy(Classical) ϕᴾ::Destroy(Quantum)

L_int =
    im * (
        0.5 * ϕᶜ' * ϕᴾ' * (ϕᶜ(Minus) * ϕᶜ(Minus) + ϕᴾ(Minus) * ϕᴾ(Minus)) -
        0.5 * ϕᶜ(Plus) * ϕᴾ(Plus) * (ϕᶜ' * ϕᶜ' + ϕᴾ' * ϕᴾ') +
        ϕᶜ' * ϕᴾ' * (ϕᶜ(Plus) * ϕᴾ(Plus) + ϕᶜ(Minus) * ϕᴾ(Minus))
    )

@testset "vacuum bubble" begin
    @test !iszero(wick_contraction(L_int; regularise=false))
    @test iszero(wick_contraction(L_int; regularise=true))
end

@testset "wick contractions" begin
    @testset "classical-classical Green's function" begin
        expr = ϕᶜ(Out()) * ϕᶜ'(In()) * L_int

        @test is_conserved(expr)
        @test is_physical(expr)

        wick_contractions = wick_contraction(expr.arguments[1].args_nc; regularise=false)
        @test length(wick_contractions) == 4

        # propagators = make_propagators(wick_contractions)
        # regularized_wick = KeldyshContraction._regularise(propagators)
        # @test length(regularized_wick) == 2
        # @test length(unique(regularized_wick)) == 1
        # @test isequal(wick_contraction(expr.arguments[1]), *(regularized_wick[1]...))

        # using KeldyshContraction:
        #     make_propagator, set_reg_to_zero!, get_propagator, make_real
        # using SymbolicUtils: arguments, SymbolicUtils
        # @test isequal(
        #     make_propagator(ϕᶜ(Out()), ϕᴾ') *
        #     make_propagator(ϕᶜ, ϕᶜ') *
        #     make_propagator(ϕᶜ, ϕᶜ(In())'),
        #     prod(set_reg_to_zero!.(arguments(wick_contraction(expr.arguments[1])))),
        # ) # TODO this should be true but is not

        # ∨ I check these by hand
        # i (ϕᶜ*ϕᶜ⁻*ϕᶜ⁻*̄ϕᶜ*̄ϕᴾ*̄ϕᶜ)/2
        # @test repr(wick_contraction(expr.arguments[1])) == "Gᴷ(y₁,x₂)*Gᴿ(x₁,y₁)*Gᴷ(y₁,y₁)"

        # i (ϕᶜ*ϕᴾ⁻*ϕᴾ⁻*̄ϕᶜ*̄ϕᴾ*̄ϕᶜ)/2
        # @test repr(wick_contraction(expr.arguments[2])) == "Gᴬ(y₁,y₁)*Gᴬ(y₁,x₂)*Gᴿ(x₁,y₁)"

        # - i( ϕᶜ*ϕᶜ⁺*ϕᴾ⁺*̄ϕᶜ*̄ϕᶜ*̄ϕᶜ) /2
        # @test repr(wick_contraction(expr.arguments[3])) == "-Gᴷ(y₁,y₁)*Gᴷ(x₁,y₁)*Gᴬ(y₁,x₂)"

        # - i(ϕᶜ*ϕᶜ⁺*ϕᴾ⁺*̄ϕᴾ*̄ϕᴾ*̄ϕ)/2
        # @test repr(wick_contraction(expr.arguments[4])) == "-Gᴿ(y₁,y₁)*Gᴿ(x₁,y₁)*Gᴬ(y₁,x₂)"

        # ϕᶜ*ϕᶜ⁺*ϕᴾ⁺*̄ϕᶜ*̄ϕᴾ*̄ϕᶜ
        # @test repr(SymbolicUtils.expand(wick_contraction(expr.arguments[5]))) ==
        # "Gᴷ(x₁,y₁)*Gᴬ(y₁,x₂)*Gᴿ(y₁,y₁) + Gᴬ(y₁,x₂)*Gᴿ(x₁,y₁)*Gᴷ(y₁,y₁)"

        # ϕᶜ*ϕᶜ⁻*ϕᴾ⁻*̄ϕᶜ*̄ϕᴾ*̄ϕᶜ
        # @test repr(SymbolicUtils.expand(wick_contraction(expr.arguments[6]))) ==
        # "Gᴬ(y₁,y₁)*Gᴷ(y₁,x₂)*Gᴿ(x₁,y₁) + Gᴬ(y₁,x₂)*Gᴿ(x₁,y₁)*Gᴷ(y₁,y₁)"

        # TODO the string comparison will fail due to different seed so that the terms shuffle.
        # result = make_real(SymbolicUtils.expand(sum(wick_contraction.(expr.arguments))))

        # L = InteractionLagrangian(L_int)
        # GF = wick_contraction(L; simplify=false)
        # @test isequal(GF.keldysh, result)
        # @test_broken construct_self_energy(arguments(GF.keldysh)[1])
    end

    @testset "quantum-quantum Green's function" begin
        expr = ϕᴾ(Out()) * ϕᴾ'(In()) * L_int

        @test is_conserved(expr)
        @test is_physical(expr)

        # ∨ should this be zero?
        @test !iszero(wick_contraction(expr; regularise=false))
        @test iszero(wick_contraction(expr; regularise=true))
    end
end

@testset "self-energy" begin
    using KeldyshContraction: Advanced, Retarded, Keldysh
    using KeldyshContraction: Edge, matrix
    L = InteractionLagrangian(L_int)
    GF = DressedPropagator(L)
    matrix(GF)
    Σ = SelfEnergy(GF)
    matrix(Σ)

    @testset "correctness check" begin
        @testset "first order" begin
            advanced_test = isequal(
                Σ.advanced, -1 * make_propagator(ϕᶜ, ϕᶜ') + make_propagator(ϕᶜ, ϕᴾ')
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
            # ^ pretty sure Gerbino et al https://arxiv.org/pdf/2406.20028
            # is wrong and switshes retarded and advanced
            # and we compute the correct with a overall minus sign

            @test isequal(KeldyshContraction._conj(Σ.advanced), Σ.retarded)
            @test isequal(KeldyshContraction._conj(Σ.keldysh), -1 * Σ.keldysh)

            # @test iszero(matrix(SelfEnergy(L; simplify=false)) .- matrix(Σ))
        end
    end

    @testset "Keldysh GF is enough" begin
        expr_K = ϕᶜ(Out()) * ϕᶜ'(In()) * L_int
        G_K1 = wick_contraction(expr_K)

        @test isequal(construct_self_energy(G_K1)[Advanced], Σ.advanced)
        @test isequal(construct_self_energy(G_K1)[Retarded], Σ.retarded)
    end
end
