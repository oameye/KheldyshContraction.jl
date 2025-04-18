using KeldyshContraction, Test
using KeldyshContraction: Classical, Quantum, Plus, Minus, In, Out
import KeldyshContraction as KC

@qfields ϕ::Destroy(Classical) ψ::Destroy(Quantum)


@test sprint(show, ϕ) == "ϕ"
@test sprint(show, ϕ') == "̄ϕ"
@test sprint(show, ϕ(Plus)') == "̄ϕ⁺"
@test sprint(show, ϕ(Minus)') == "̄ϕ⁻"

@test sprint(show,propagator(ϕ, ϕ'(In))) == "Gᴷ(y,x₂)"
@test sprint(show,propagator(ϕ(Out), ϕ')) == "Gᴷ(x₁,y)"
@test sprint(show,propagator(ϕ(Out), ψ')) == "Gᴿ(x₁,y)"
@test sprint(show,propagator(ψ(Out), ϕ')) == "Gᴬ(x₁,y)"
