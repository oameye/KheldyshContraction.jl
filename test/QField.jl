using KeldyshContraction, Test
using KeldyshContraction: In, Out, Classical, Quantum, Plus, Minus
import KeldyshContraction as KC

@qfields ϕ::Destroy(Classical) ψ::Destroy(Quantum)

@testset "SymbolicUtils interface" begin
    using TermInterface, SymbolicUtils

    @test TermInterface.head(ϕ) == :call
    @test SymbolicUtils.iscall(ϕ) == false
    @test SymbolicUtils.iscall(ϕ * ϕ) == true
    @test SymbolicUtils.operation(ϕ + ϕ) == +
    @test SymbolicUtils.operation(ϕ * ϕ) == *
    @test SymbolicUtils.arguments(2 * ϕ * ϕ) == [2, ϕ, ϕ]
    @test isnothing(SymbolicUtils.metadata(2 * ϕ * ϕ))
    @test isequal(SymbolicUtils.maketerm(KC.QMul, *, [ϕ, ϕ], nothing), ϕ * ϕ)

    @testset "SymbolicUtils promotion" begin
        # Test the promotion of Keldysh fields
        typeof(ϕ + 1)
        @test SymbolicUtils.promote_symtype(+, ϕ, 1) isa KC.QField broken = true
        @test SymbolicUtils.promote_symtype(*, ϕ, 1) isa KC.QField broken = true
    end
end

@testset "ones and zeros" begin
    @test isone(ϕ) == false
    @test iszero(ϕ) == false
    @test one(ϕ) == 1
    @test zero(ϕ) == 0
end

@testset "isequal" begin
    # Test the equality of two Keldysh fields
    @test ϕ == ϕ
    @test isequal(ϕ * ϕ, ϕ * ϕ)
    @test isequal(ϕ * ψ, ϕ * ψ)
    @test isequal(ϕ + ψ, ϕ + ψ)

    @test isequal(ψ + ϕ, ϕ + ψ) broken = true
    @test isequal(ψ * ϕ, ϕ * ψ) broken = true
    @test isequal(1 + ϕ, ϕ + 1)
end
@testset "simplification" begin
    @test isequal(ϕ + ϕ, 2 * ϕ) broken = true
    @test isequal(ϕ + ϕ + ϕ, 3 * ϕ) broken = true

    @test isequal((ϕ + ϕ) * (ϕ + ϕ), 4 * ϕ^2) broken = true
    @test isequal((ϕ + ϕ) * (ϕ + ϕ), ϕ^2 + ϕ^2 + ϕ^2 + ϕ^2)
end

@testset "adjoint" begin
    @qfields ϕ::Destroy(Classical) ψ::Destroy(Quantum)
    ϕ′ = Create(KC.name(ϕ), Classical, KC.regularisation(ϕ), KC.position(ϕ); ϕ.metadata)
    ψ′ = Create(KC.name(ψ), Quantum, KC.regularisation(ψ), KC.position(ψ); ψ.metadata)

    # Test the adjoint of Keldysh fields
    @test isequal(ϕ', ϕ′)
    @test adjoint(ψ) == ψ′
    @test isequal(adjoint(ϕ * ψ), ψ′ * ϕ′) # fields switch under adjoint
    @test isequal(adjoint(ϕ + ψ), ϕ′ + ψ′)
end

@testset "acts_on" begin
    using KeldyshContraction: acts_on
    # Test the acts_on function
    @test acts_on(ϕ) == 0
    @test acts_on(ψ(In)) == 1
    @test acts_on(ψ(Out)) == -1
    @test acts_on(ϕ + ψ) == [0]
    @test acts_on(ϕ * ψ) == [0]

    @test acts_on(ϕ + ψ(In)) == [0, 1]
    @test acts_on(ϕ * ψ(In)) == [0, 1]
end

@testset "more math" begin
    # Test the math operations
    @test isequal(ϕ / 2, 0.5 * ϕ)
    @test isequal(ϕ//2, 0.5 * ϕ) skip = true

    @test isequal((ϕ^2), ϕ * ϕ)

    @test isequal(-(ϕ, 1), ϕ - 1)
    @test isequal(-(1, ϕ), 1 - ϕ)

    @test isequal(ϕ + 0, ϕ)
    @test isequal(0 + ϕ, ϕ)
end
