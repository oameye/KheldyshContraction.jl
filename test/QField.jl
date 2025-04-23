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

# @testset "hash" begin # how to test hashes?
#     @test hash(ϕ * ϕ, hash(4)) == 0x85ebad55106e875a
#     @test hash(ϕ + ϕ, hash(4)) == 0x8fc9006919ba7ef2
# end

@testset "isequal" begin
    # Test the equality of two Keldysh fields
    @test ϕ == ϕ
    @test isequal(ϕ * ϕ, ϕ * ϕ)
    @test isequal(ϕ * ψ, ϕ * ψ)
    @test isequal(ϕ + ψ, ϕ + ψ)

    @test isequal(ψ + ϕ, ϕ + ψ) broken = true
    @test isequal(ψ * ϕ, ϕ * ψ) broken = true
    @test isequal(1 + ϕ, ϕ + 1)
    ϕ2 = ϕ + ϕ
    @test isequal(ϕ2 + 1, ϕ + ϕ + 1)
    @test isequal(ϕ2 + ϕ, ϕ + ϕ + ϕ)
end
@testset "simplification" begin
    using SymbolicUtils
    @test isequal(ϕ + ϕ, 2 * ϕ) broken = true
    @test isequal(ϕ + ϕ + ϕ, 3 * ϕ) broken = true

    @test isequal((ϕ + ϕ) * (ϕ + ϕ), 4 * ϕ^2) broken = true
    @test isequal((ϕ + ϕ) * (ϕ + ϕ), ϕ^2 + ϕ^2 + ϕ^2 + ϕ^2)
    SymbolicUtils.simplify((ϕ + ϕ) * (ψ + ϕ) + 3* (ϕ + ϕ) * (ψ + ϕ))
    SymbolicUtils.expand((ϕ + ϕ) * (ψ + ϕ) + 3* (ϕ + ϕ) * (ψ + ϕ))
end

@testset "adjoint" begin
    using KeldyshContraction: is_creation, is_annihilation, is_conserved

    @qfields ϕ::Destroy(Classical) ψ::Destroy(Quantum)
    ϕ′ = Create(KC.name(ϕ), Classical, KC.regularisation(ϕ), KC.position(ϕ); ϕ.metadata)
    ψ′ = Create(KC.name(ψ), Quantum, KC.regularisation(ψ), KC.position(ψ); ψ.metadata)

    @test is_creation(ϕ′)
    @test !is_creation(ϕ)
    @test is_annihilation(ϕ)
    @test !is_conserved(ϕ)

    # Test the adjoint of Keldysh fields
    @test isequal(ϕ', ϕ′)
    @test adjoint(ψ) == ψ′
    @test adjoint(ψ′) == ψ
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

@testset "quantum-classical" begin
    using KeldyshContraction: is_quantum, is_classical

    @test is_quantum(ψ)
    @test is_classical(ϕ)
    @test !is_quantum(ϕ)
    @test !is_classical(ψ)
end

@testset "some lagrangians" begin
    eleactic2boson = -0.5 * (ϕ' * ψ' * (ϕ^2 + ψ^2) + (ϕ'^2 + ψ'^2) * ϕ * ψ)

    loss2boson =
        0.5 * ϕ' * ψ' * (ϕ(Minus)^2 + ψ(Minus)^2) -
        0.5 * ϕ(Plus) * ψ(Plus) * (ϕ'^2 + ψ'^2) + ϕ' * ψ' * (ϕ(Plus)^2 + ϕ(Minus)^2)
end
