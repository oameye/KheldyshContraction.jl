using KeldyshContraction, Test
using KeldyshContraction: Classical, Quantum, Plus, Minus, In, Out, make_propagator, Bulk

@qfields ϕ::Destroy(Classical) ψ::Destroy(Quantum)

@qfields ϕᶜ::Destroy(Classical) ϕᴾ::Destroy(Quantum)

@testset "Symbols" begin
    input = [
        ϕ,
        ϕ',
        ϕ(Plus)',
        ϕ(Minus)',
        make_propagator(ϕ, ϕ'(In())),
        make_propagator(ϕ(Out()), ϕ'),
        make_propagator(ϕ(Out()), ψ'),
        make_propagator(ψ(Out()), ϕ'),
        make_propagator(ψ(Bulk(2)), ϕ'),
    ]
    output = [
        "ϕ",
        "̄ϕ",
        "̄ϕ⁺",
        "̄ϕ⁻",
        "Gᴷ(y₁,x₂)",
        "Gᴷ(x₁,y₁)",
        "Gᴿ(x₁,y₁)",
        "Gᴬ(x₁,y₁)",
        "Gᴬ(y₂,y₁)",
    ]
    for (i, o) in zip(input, output)
        @test sprint(show, i) == o
        @test repr(i) == o
    end

    output_latex = [
        "\$\\phi\$",
        "\$\\bar{ϕ}\$",
        "\$\\bar{ϕ}^+\$",
        "\$\\bar{ϕ}^{-}\$",
        "\$G^K\\left( y_1, x_2 \\right)\$",
        "\$G^K\\left( x_1, y_1 \\right)\$",
        "\$G^R\\left( x_1, y_1 \\right)\$",
        "\$G^A\\left( x_1, y_1 \\right)\$",
    ]

    for (i, o) in zip(input, output_latex)
        @test sprint(show, MIME"text/latex"(), i) == o
        @test repr(MIME"text/latex"(), i) == o
    end
end

@testset "Term" begin
    @qfields ϕᶜ::Destroy(Classical) ϕᴾ::Destroy(Quantum)

    L_int = im*(0.5 * ϕᶜ' * ϕᴾ' * (ϕᶜ * ϕᶜ))
    @test repr(L_int) == "(0.0 + 0.5im)*(ϕᶜ*ϕᶜ*̄ϕᶜ*̄ϕᴾ)"
end

@testset "Structs" begin
    L = InteractionLagrangian(ϕ * ψ * ϕ' * ψ')
    @test repr(MIME"text/plain"(), L) ==
        "Interaction Lagrangian with fields ϕ and ψ:\n(ϕ*ψ*̄ϕ*̄ψ)"

    @test repr(MIME"text/latex"(), L) == "\$\\phi \\psi \\bar{\\phi} \\bar{\\psi}\$"

    DP = DressedPropagator(
        make_propagator(ϕ, ϕ'), make_propagator(ϕ, ϕ'), make_propagator(ϕ, ϕ')
    )
    @test repr(MIME"text/plain"(), DP) ==
        "Dressed Propagator:\nkeldysh:  Gᴷ(y₁,y₁)\nretarded: Gᴷ(y₁,y₁)\nadvanced: Gᴷ(y₁,y₁)"
end
