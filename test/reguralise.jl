using KeldyshContraction, Test
using KeldyshContraction: In, Out, Classical, Quantum, Plus, Minus
using KeldyshContraction:
    isbulk,
    regularisations,
    propagator_type,
    regular

@qfields ϕᶜ::Destroy(Classical) ϕᴾ::Destroy(Quantum)

@test !regular((ϕᴾ(Plus), ϕᶜ'))
@test regular((ϕᴾ(Minus), ϕᶜ'))
@test !regular((ϕᶜ(Minus), ϕᴾ'))
@test regular((ϕᶜ(Plus), ϕᴾ'))
@test regular((ϕᶜ, ϕᴾ'))
