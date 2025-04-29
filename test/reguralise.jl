using KeldyshContraction, Test
using KeldyshContraction: In, Out, Classical, Quantum, Plus, Minus
using KeldyshContraction:
    isbulk,
    regularisations,
    make_propagators,
    propagator_type,
    regular,
    _regularise,
    get_propagator

@qfields ϕᶜ::Destroy(Classical) ϕᴾ::Destroy(Quantum)

@test !regular(make_propagator(ϕᴾ(Plus), ϕᶜ'))
@test regular(make_propagator(ϕᴾ(Minus), ϕᶜ'))
@test !regular(make_propagator(ϕᶜ(Minus), ϕᴾ'))
@test regular(make_propagator(ϕᶜ(Plus), ϕᴾ'))
@test regular(make_propagator(ϕᶜ, ϕᴾ'))

L_int =
    im * (
        0.5 * ϕᶜ' * ϕᴾ' * (ϕᶜ(Minus) * ϕᶜ(Minus) + ϕᴾ(Minus) * ϕᴾ(Minus)) -
        0.5 * ϕᶜ(Plus) * ϕᴾ(Plus) * (ϕᶜ' * ϕᶜ' + ϕᴾ' * ϕᴾ') +
        ϕᶜ' * ϕᴾ' * (ϕᶜ(Plus) * ϕᴾ(Plus) + ϕᶜ(Minus) * ϕᴾ(Minus))
    )

expr = ϕᶜ(Out()) * ϕᶜ'(In()) * L_int
wick_contractions = wick_contraction(expr.arguments[3].args_nc)
propagators = make_propagators(wick_contractions)
regularized_wick = KeldyshContraction._regularise(propagators)
p = get_propagator(regularized_wick[1][3])
@test regular(p)
