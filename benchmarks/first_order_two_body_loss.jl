function benchmark_two_body_loss!(SUITE)
    @qfields ϕ::Destroy(Classical) ψ::Destroy(Quantum)

    loss2boson =
        0.5 * ϕ' * ψ' * (ϕ(Minus) * ϕ(Minus) + ψ(Minus) * ψ(Minus)) -
        0.5 * ϕ(Plus) * ψ(Plus) * (ϕ' * ϕ' + ψ' * ψ') +
        ϕ' * ψ' * (ϕ(Plus) * ψ(Plus) + ϕ(Minus) * ψ(Minus))
    L_int = InteractionLagrangian(loss2boson)

    GF = wick_contraction(L_int)
    Σ = SelfEnergy(GF)

    SUITE["two body loss"]["Green's function"] = @benchmarkable wick_contraction($L_int) seconds =
        10
    SUITE["two body loss"]["self energy"] = @benchmarkable SelfEnergy($GF) seconds = 10

    order = 2
    SUITE["two body loss"]["Green's function second_order"] = @benchmarkable wick_contraction(
        $L_int; order=($order)
    ) seconds = 50
    return nothing
end
