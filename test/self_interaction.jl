using KeldyshContraction, Test

@qfields c::Destroy(Classical) q::Destroy(Quantum)

eleactic2boson = 0.5 * (c^2 + q^2) * c' * q' + 0.5 * c * q * ((c')^2 + (q')^2)

@testset "Bubble diagrams" begin
    using KeldyshContraction: advanced_to_retarded
    expr = wick_contraction(eleactic2boson)
    @test advanced_to_retarded(expr) == 0
end

@testset "green's function" begin
    using KeldyshContraction: _conj
    L = InteractionLagrangian(eleactic2boson)
    GF = wick_contraction(L)

    @test iszero(_conj(GF.advanced) - GF.retarded)
    @test_broken isequal(KeldyshContraction._conj(GF.keldysh), -1 * GF.keldysh)
    # TODO this is not equal to do G^R and G^A being at different coordinates
end

@testset "self-energy" begin
    using KeldyshContraction: _conj
    L = InteractionLagrangian(eleactic2boson)
    GF = wick_contraction(L)
    Σ = SelfEnergy(GF)

    @test isequal(arguments(_conj(Σ.advanced)), arguments(_conj(Σ.retarded)))
    @test isequal(KeldyshContraction._conj(Σ.keldysh), -1 * Σ.keldysh)
end
