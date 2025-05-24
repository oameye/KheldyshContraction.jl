using KeldyshContraction, Test

@qfields c::Destroy(Classical) q::Destroy(Quantum)
elasctic2boson = 0.5 * (c^2 + q^2) * c' * q' + 0.5 * c * q * ((c')^2 + (q')^2)
L_int = InteractionLagrangian(elasctic2boson)

# using KeldyshContraction: Minus, Plus
# elasctic2boson_reguralize = 0.5 * (c(Minus)^2 + q(Minus)^2) * c' * q' + 0.5 * c(Plus) * q(Plus) * ((c')^2 + (q')^2)
# L_int = InteractionLagrangian(elasctic2boson_reguralize)

@testset "first order" begin
    @testset "Bubble diagrams" begin
        using KeldyshContraction: filter_nonzero!
        expr = wick_contraction(elasctic2boson; simplify=true)
        filter_nonzero!(expr)
        @test iszero(expr)
    end

    @testset "wick contraction" begin
        using KeldyshContraction: _wick_contraction, regular, In, Out, Diagram, Diagrams

        expr = c(Out()) * q'(In()) * elasctic2boson

        @test KeldyshContraction.is_conserved(expr)
        @test KeldyshContraction.is_physical(expr)

        # ∨ I check these by hand
        # 0.5*(c*c*c*̄q*̄c*̄q
        truth = Diagrams(
            Dict(
                Diagram([(c(Out()), c'), (c, q'), (c, q(In())')]) => 0.0-1.0*im,
                Diagram([(c(Out()), q'), (c, c'), (c, q(In())')]) => 0.0-1.0*im,
            ),
        )
        @test isequal(wick_contraction(expr.arguments[1]), truth)
        # The keldysh in and keldysh out will disappear later
    end

    @testset "green's function" begin
        # using KeldyshContraction: _conj
        L = InteractionLagrangian(elasctic2boson)
        GF = DressedPropagator(L)

        @test_broken iszero(_conj(GF.advanced) - GF.retarded)
        @test_broken isequal(KeldyshContraction._conj(GF.keldysh), -1 * GF.keldysh)
        # TODO this is not equal to do G^R and G^A being at different coordinates
        # switch in and out coordinate when adjoint(::DressedPropagator)
    end

    @testset "self-energy" begin
        # using KeldyshContraction: _conj
        L = InteractionLagrangian(elasctic2boson)
        GF = DressedPropagator(L)
        Σ = SelfEnergy(GF)

        @test iszero(Σ.keldysh)
        @test isequal(adjoint(Σ.advanced), Σ.retarded)
        @test isequal(adjoint(Σ.keldysh), -1 * Σ.keldysh)
    end
end

@testset "second order" begin
    GF = DressedPropagator(L_int; order=2)

    terms = collect(keys(GF.keldysh.diagrams))
    @test length(terms) == 20

    Σ = SelfEnergy(GF; order=2)

    @test_broken isequal(adjoint(Σ.advanced), Σ.retarded)
    @test_broken isequal(adjoint(Σ.keldysh), -1 * Σ.keldysh)
end
