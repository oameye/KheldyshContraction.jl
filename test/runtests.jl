using LossyTransport, Test

@testset "Concretely typed" begin
    using LossyTransport
    using CheckConcreteStructs

    # all_concrete(LossyTransport.ProductSpace)
    # all_concrete(LossyTransport.BosonicField)
    all_concrete(LossyTransport.QMul)
    all_concrete(LossyTransport.QAdd)
    all_concrete(LossyTransport.Destroy)
    all_concrete(LossyTransport.Create)
end

@testset "Code linting" begin
    using JET
    JET.test_package(LossyTransport; target_defined_modules=true)
end

@testset "ExplicitImports" begin
    using ExplicitImports
    @test check_no_stale_explicit_imports(LossyTransport) == nothing
    @test check_all_explicit_imports_via_owners(LossyTransport) == nothing
end

@testset "propagator" begin
    include("propagator.jl")
end

@testset "two_boson_loss" begin
    include("two_boson_loss.jl")
end
