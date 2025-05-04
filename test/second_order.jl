using KeldyshContraction, Test
using KeldyshContraction: In, Out, Classical, Quantum, Plus, Minus
using KeldyshContraction: Bulk, position

@testset "zero loop filter" begin
    using KeldyshContraction: has_zero_loop, QField

    @qfields ϕᶜ::Destroy(Classical) ϕᴾ::Destroy(Quantum)

    # Gᴿ(1,2) Gᴿ(2,1) = 0
    vs = Vector{QField}[[ϕᶜ(Bulk(1)), ϕᴾ'(Bulk(2))], [ϕᶜ(Bulk(2)), ϕᴾ'(Bulk(1))]]
    @test has_zero_loop(vs)

    # Gᴬ(1,2) Gᴬ(2,1) = 0
    vs = Vector{QField}[[ϕᴾ(Bulk(1)), ϕᶜ'(Bulk(2))], [ϕᴾ(Bulk(2)), ϕᶜ'(Bulk(1))]]
    @test has_zero_loop(vs)

    # Gᴿ(1,2) Gᴬ(1,2) = 0
    vs = Vector{QField}[[ϕᶜ(Bulk(1)), ϕᴾ'(Bulk(2))], [ϕᴾ(Bulk(1)), ϕᶜ'(Bulk(2))]]
    @test has_zero_loop(vs)

    vs = Vector{QField}[[ϕᶜ(Bulk(1)), ϕᴾ'(Bulk(2))], [ϕᶜ(Bulk(1)), ϕᴾ'(Bulk(2))]]
    @test !has_zero_loop(vs)
end

@testset "two_boson_loss" begin
    @qfields ϕᶜ::Destroy(Classical) ϕᴾ::Destroy(Quantum)

    L_int =
        im * (
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

        wick_contraction(L; order=2, simplify=false)

        @test_throws "not implemented" wick_contraction(L; order=3)
    end
end

@testset "two_body_scattering" begin
    @qfields c::Destroy(Classical) q::Destroy(Quantum)
    elasctic2boson = 0.5 * (c^2 + q^2) * c' * q' + 0.5 * c * q * ((c')^2 + (q')^2)
    L_int = InteractionLagrangian(elasctic2boson)

    GF = wick_contraction(L_int; order=2)

    using SymbolicUtils
    import KeldyshContraction as KC
    terms = arguments(expand(GF.keldysh))
    terms = map(KC.canonicalize, terms)
    @test all(map(KC.is_canonical, terms))
end
