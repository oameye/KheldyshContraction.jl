using KeldyshContraction, Test
using KeldyshContraction: Classical, Quantum, Plus, Minus, In, Out, propagator

@qfields ϕ::Destroy(Classical) ψ::Destroy(Quantum)

input = [
    ϕ,
    ϕ',
    ϕ(Plus)',
    ϕ(Minus)',
    propagator(ϕ, ϕ'(In)),
    propagator(ϕ(Out), ϕ'),
    propagator(ϕ(Out), ψ'),
    propagator(ψ(Out), ϕ'),
]

output = ["ϕ", "̄ϕ", "̄ϕ⁺", "̄ϕ⁻", "Gᴷ(y,x₂)", "Gᴷ(x₁,y)", "Gᴿ(x₁,y)", "Gᴬ(x₁,y)"]
for (i, o) in zip(input, output)
    @test sprint(show, i) == o
    @test repr(i) == o
end

output_latex = ["\$\\phi\$", "\$\\bar{ϕ}\$", "\$\\bar{ϕ}^+\$", "\$\\bar{ϕ}^{-}\$"]

for (i, o) in zip(input[1:4], output_latex)
    @test sprint(show, MIME"text/latex"(), i) == o
    @test repr(MIME"text/latex"(), i) == o
end

DP = DressedPropagator(propagator(ϕ, ϕ'), propagator(ϕ, ϕ'), propagator(ϕ, ϕ'))
@test repr(MIME"text/plain"(), DP) == "Self Energy:\n Gᴷ(y,y)   Gᴷ(y,y)\n Gᴷ(y,y)  0"
