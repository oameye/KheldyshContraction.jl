using KeldyshContraction, Test
using KeldyshContraction: In, Out, Classical, Quantum, Plus, Minus
using KeldyshContraction: is_physical, is_conserved, construct_self_energy!

@qfields ϕᶜ::Destroy(Classical) ϕᴾ::Destroy(Quantum)

L_int =
    im * (
        0.5 * ϕᶜ' * ϕᴾ' * (ϕᶜ(Minus) * ϕᶜ(Minus) + ϕᴾ(Minus) * ϕᴾ(Minus)) -
        0.5 * ϕᶜ(Plus) * ϕᴾ(Plus) * (ϕᶜ' * ϕᶜ' + ϕᴾ' * ϕᴾ') +
        ϕᶜ' * ϕᴾ' * (ϕᶜ(Plus) * ϕᴾ(Plus) + ϕᶜ(Minus) * ϕᴾ(Minus))
    )

@testset "vacuum bubble" begin
    @test !iszero(wick_contraction(L_int; regularise=false))
    @test iszero(wick_contraction(L_int; regularise=true))
end

@testset "wick contractions first order" begin
    @testset "keldysh Green's function" begin
        using KeldyshContraction: _wick_contraction, regular, In, Out
        expr = ϕᶜ(Out()) * ϕᶜ'(In()) * L_int

        @test is_conserved(expr)
        @test is_physical(expr)

        wick_contractions = wick_contraction(expr.arguments[1].args_nc; regularise=false)
        @test length(wick_contractions) == 4
        regularized_wick = filter(wick_contractions) do cs
            all(regular(c) for c in cs)
        end
        @test length(regularized_wick) == 2
        @test length(unique(Diagram.(regularized_wick))) == 1

        @test isequal(
            Diagram([Edge(ϕᶜ(Out()), ϕᴾ'), Edge(ϕᶜ, ϕᶜ'), Edge(ϕᶜ, ϕᶜ(In())')]),
            first(keys(wick_contraction(expr.arguments[1]).diagrams)),
        )
        # ∨ I check these by hand
        # i (ϕᶜ*ϕᶜ⁻*ϕᶜ⁻*̄ϕᶜ*̄ϕᴾ*̄ϕᶜ)/2

        truth = Diagrams(
            Dict(Diagram([(ϕᶜ(Out()), ϕᴾ'), (ϕᶜ, ϕᶜ'), (ϕᶜ, ϕᶜ'(In()))]) => complex(1.0))
        )
        @test isequal(wick_contraction(expr.arguments[1]), truth)

        # i (ϕᶜ*ϕᴾ⁻*ϕᴾ⁻*̄ϕᶜ*̄ϕᴾ*̄ϕᶜ)/2
        truth = Diagrams(
            Dict(Diagram([(ϕᶜ(Out()), ϕᴾ'), (ϕᴾ, ϕᶜ'), (ϕᴾ, ϕᶜ'(In()))]) => complex(1.0))
        )
        @test isequal(wick_contraction(expr.arguments[2]), truth)

        # - i( ϕᶜ*ϕᶜ⁺*ϕᴾ⁺*̄ϕᶜ*̄ϕᶜ*̄ϕᶜ) /2
        @test repr(wick_contraction(expr.arguments[3])) ==
            "-1.0*Gᴷ(x₁,y₁)*Gᴷ(y₁,y₁)*Gᴬ(y₁,x₂)"

        # - i(ϕᶜ*ϕᶜ⁺*ϕᴾ⁺*̄ϕᴾ*̄ϕᴾ*̄ϕ)/2
        @test repr(wick_contraction(expr.arguments[4])) ==
            "-1.0*Gᴿ(x₁,y₁)*Gᴿ(y₁,y₁)*Gᴬ(y₁,x₂)"
        # ϕᶜ*ϕᶜ⁺*ϕᴾ⁺*̄ϕᶜ*̄ϕᴾ*̄ϕᶜ
        truth = Diagrams(
            Dict(
                Diagram([(ϕᶜ(Out()), ϕᶜ'), (ϕᶜ, ϕᴾ'), (ϕᴾ, ϕᶜ'(In()))]) => complex(1.0),
                Diagram([(ϕᶜ(Out()), ϕᴾ'), (ϕᶜ, ϕᶜ'), (ϕᴾ, ϕᶜ'(In()))]) => complex(1.0),
            ),
        )
        @test isequal(wick_contraction(expr.arguments[5]), truth)

        # ϕᶜ*ϕᶜ⁻*ϕᴾ⁻*̄ϕᶜ*̄ϕᴾ*̄ϕᶜ
        truth = Diagrams(
            Dict(
                Diagram([(ϕᶜ(Out()), ϕᴾ'), (ϕᴾ, ϕᶜ'), (ϕᶜ, ϕᶜ'(In()))]) => complex(1.0),
                Diagram([(ϕᶜ(Out()), ϕᴾ'), (ϕᶜ, ϕᶜ'), (ϕᴾ, ϕᶜ'(In()))]) => complex(1.0),
            ),
        )
        @test isequal(wick_contraction(expr.arguments[6]), truth)

        result = wick_contraction.(expr.arguments)

        diagrams_result = result[1]
        for idx in 2:length(result)
            for (diagram, prefactor) in result[idx]
                push!(diagrams_result, diagram, prefactor)
            end
        end # TODO: implement merge!
        diagrams_result

        L = InteractionLagrangian(L_int)
        GF = DressedPropagator(L; simplify=false)
        @test isequal(GF.keldysh, diagrams_result)
    end

    @testset "quantum-quantum Green's function" begin
        expr = ϕᴾ(Out()) * ϕᴾ'(In()) * L_int

        @test is_conserved(expr)
        @test is_physical(expr)

        # ∨ should this be zero?
        @test !iszero(wick_contraction(expr; regularise=false))
        @test iszero(wick_contraction(expr; regularise=true))
    end

    @testset "R/A Green's function first order" begin
        L = InteractionLagrangian(L_int)
        GF = DressedPropagator(L; simplify=false)

        truth_retarded = Diagrams(
            Dict(
                Diagram([(ϕᶜ(Out()), ϕᴾ'), (ϕᴾ, ϕᶜ'), (ϕᶜ, ϕᴾ'(In()))]) => complex(1.0),
                Diagram([(ϕᶜ(Out()), ϕᴾ'), (ϕᶜ, ϕᶜ'), (ϕᶜ, ϕᴾ'(In()))]) => complex(1.0),
            ),
        )
        truth_advanced = Diagrams(
            Dict(
                Diagram([(ϕᴾ(Out()), ϕᶜ'), (ϕᶜ, ϕᴾ'), (ϕᴾ, ϕᶜ'(In()))]) => complex(1.0),
                Diagram([(ϕᴾ(Out()), ϕᶜ'), (ϕᶜ, ϕᶜ'), (ϕᴾ, ϕᶜ'(In()))]) => complex(-1.0),
            ),
        )
        @test isequal(GF.retarded, truth_retarded)
        @test isequal(GF.advanced, truth_advanced)
    end

    @testset "simplification" begin
        L = InteractionLagrangian(L_int)
        GF_not_simplified = DressedPropagator(L; simplify=false)
        GF_simplified = DressedPropagator(L; simplify=true)
        collect(keys(GF_simplified.keldysh.diagrams))
        collect(values(GF_simplified.keldysh.diagrams))
        collect(keys(GF_not_simplified.keldysh.diagrams))
        collect(values(GF_not_simplified.keldysh.diagrams))
    end
end

@testset "self-energy first order" begin
    using KeldyshContraction: Advanced, Retarded, Keldysh
    using KeldyshContraction: Edge, matrix, Diagrams, Diagram
    L = InteractionLagrangian(L_int)

    @testset "correctness check" begin
        @testset "first order" begin
            GF = DressedPropagator(L; simplify=false)
            Σ = SelfEnergy(GF)

            kp = Diagram([(ϕᶜ, ϕᶜ')])
            rp = Diagram([(ϕᶜ, ϕᴾ')])
            ap = Diagram([(ϕᴾ, ϕᶜ')])
            advanced_truth = Diagrams(Dict(kp => complex(-1.0), rp => complex(1.0)))
            retarded_truth = Diagrams(Dict(kp => complex(1.0), ap => complex(1.0)))
            keldysh_truth = Diagrams(
                Dict(kp => complex(2.0), rp => complex(-1.0), ap => complex(1.0))
            )

            @test isequal(Σ.advanced, advanced_truth)
            @test isequal(Σ.retarded, retarded_truth)
            @test isequal(Σ.keldysh, keldysh_truth)
            # ^ pretty sure Gerbino et al https://arxiv.org/pdf/2406.20028
            # is wrong and switshes retarded and advanced
            # and we compute the correct with a overall minus sign

            @test isequal(adjoint(Σ.advanced), Σ.retarded)
            @test isequal(adjoint(Σ.keldysh), -1 * Σ.keldysh)

            @testset "simplified" begin
                GF = DressedPropagator(L; simplify=true)
                Σ = SelfEnergy(GF)
                keldysh_truth = Diagrams(Dict(kp => complex(2.0), rp => complex(-2.0)))
                advanced_truth = Diagrams(Dict(kp => complex(-1.0), rp => complex(1.0)))
                retarded_truth = Diagrams(Dict(kp => complex(1.0), rp => complex(-1.0)))

                @test isequal(Σ.advanced, advanced_truth)
                @test isequal(Σ.retarded, retarded_truth)
                @test isequal(Σ.keldysh, keldysh_truth)
            end
        end
    end

    @testset "Keldysh GF is enough" begin
        using OrderedCollections
        using KeldyshContraction: construct_self_energy!, PropagatorType, Diagrams

        L = InteractionLagrangian(L_int)
        GF = DressedPropagator(L; simplify=false)
        Σ = SelfEnergy(GF)

        expr_K = ϕᶜ(Out()) * ϕᶜ'(In()) * L_int
        G_K1 = wick_contraction(expr_K)

        self_energy = OrderedCollections.LittleDict{PropagatorType,Diagrams}((
            Advanced => Diagrams(1), Retarded => Diagrams(1), Keldysh => Diagrams(1)
        ))
        construct_self_energy!(self_energy, G_K1)
        @test isequal(self_energy[Advanced], Σ.advanced)
        @test isequal(self_energy[Retarded], Σ.retarded)
    end
end
