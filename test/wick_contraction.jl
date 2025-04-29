using KeldyshContraction, Test
using KeldyshContraction: In, Out, Classical, Quantum, Plus, Minus
using KeldyshContraction: wick_contraction

@qfields ϕᶜ::Destroy(Classical) ϕᴾ::Destroy(Quantum)

L_int = ϕᶜ' * ϕᴾ' * ϕᶜ(Minus) * ϕᶜ(Minus)
expr = ϕᶜ(Out()) * ϕᶜ'(In()) * L_int

wick_contraction(expr.args_nc)
