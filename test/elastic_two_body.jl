using KeldyshContraction, SymbolicUtils

@qfields c::Destroy(Classical) q::Destroy(Quantum)
elasctic2boson = 0.5 * (c^2 + q^2) * c' * q' + 0.5 * c * q * ((c')^2 + (q')^2)
L_int = InteractionLagrangian(elasctic2boson)

@testset "second order" begin
    GF = wick_contraction(L_int; order=2)

    terms = arguments(expand(GF.keldysh))
    @test length(terms) == 24
end
