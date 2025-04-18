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
