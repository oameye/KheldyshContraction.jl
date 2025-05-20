
#################################
#       Contraction
#################################
"""
    wick_contraction(L::InteractionLagrangian; order=1)


All the same coordinate advanced propagators are converted to retarded propagators.
"""
function wick_contraction(L::InteractionLagrangian; order=1, simplify=true)
    ϕ = L.qfield
    ψ = L.cfield
    if order == 1
        keldysh = wick_contraction(ψ(Out()) * ψ'(In()) * L.lagrangian)
        retarded = wick_contraction(ψ(Out()) * ϕ'(In()) * L.lagrangian)
        advanced = wick_contraction(ϕ(Out()) * ψ'(In()) * L.lagrangian)
    elseif order == 2
        L1 = L
        L2 = L(2)
        prefactor = make_real(im^2) / 2
        keldysh =
            prefactor *
            wick_contraction(ψ(Out()) * ψ'(In()) * L1.lagrangian * L2.lagrangian)
        retarded =
            prefactor *
            wick_contraction(ψ(Out()) * ϕ'(In()) * L1.lagrangian * L2.lagrangian)
        advanced =
            prefactor *
            wick_contraction(ϕ(Out()) * ψ'(In()) * L1.lagrangian * L2.lagrangian)
    else
        error("higher order then two not implemented")
    end
    if simplify
        keldysh, retarded, advanced = advanced_to_retarded.((keldysh, retarded, advanced))
    end
    return DressedPropagator(keldysh, retarded, advanced)
end
"""
    wick_contraction(expr::QTerm)

Compute all possible Wick contractions of quantum fields in the expression `expr`.

Wick contractions decompose products of quantum field operators into sums of products
of propagators (two-point correlation functions). The rules of the contraction are:
  - Conservation (equal numbers of creation/annihilation operators)
  - Physicality (proper time ordering)
  - No quantum-quantum contractions
  - If the fields have a [`Regularisation`](@ref) applied, the contractions are
    regularised. The [`Regularisation`](@ref) property is set to zero after the reguralisation.

The function handles two types of inputs:
- `QAdd`: Distributes the contraction over sums
- `QMul`: Contracts products of fields into propagators

The function returns a new expression of propagators of type `SymbolicUtils.Symbol`.

"""
function wick_contraction(a::QAdd; regularise=true)
    wick_contractions = wick_contraction.(SymbolicUtils.arguments(a); regularise)
    wick_contractions = sum(wick_contractions)
    return make_real(SymbolicUtils.expand(wick_contractions))
end
function wick_contraction(a::QMul; regularise=true)
    @assert is_conserved(a)
    @assert is_physical(a)

    contraction = wick_contraction(a.args_nc; regularise)
    propagators = make_propagators(contraction)
    if regularise
        # propagators = _regularise(propagators)
        set_reg_to_zero!(propagators)
    end
    return a.arg_c * make_term(propagators)
end

"""
We split up the fields into two groups, `destroys` and `creates`. We can can combute all
possible pairs by permutating the create vector. To avoid pairing up the In() and Out()
fields, we have made sure that the destroy and create vectors are ordered with the in and
out fields first. Computing the permutatins in lexicographic order, we can skip the first
(n-1)! permutations.
"""
function wick_contraction(
    args_nc::Vector{<:QField}; regularise=true
)::Vector{Vector{Contraction}}
    destroys, creates, n_destroy = prepare_args(args_nc)

    number_of_combinations = factorial(n_destroy)
    to_skip = factorial(n_destroy - 1) # due in-out contraction constraint

    wick_contractions = Vector{Contraction}[]
    iter = 1:n_destroy

    for i in (to_skip + 1):number_of_combinations
        perm = Combinatorics.nthperm(iter, i)
        contraction, fail = _wick_contract(destroys, creates, perm; regularise)

        if fail || has_zero_loop(contraction)
            continue
        else
            push!(wick_contractions, contraction)
        end
    end
    return wick_contractions
end
function _wick_contract(destroys, creates, perm; regularise=true)
    contraction = Contraction[]
    fail = false
    for (k, l) in pairs(perm)
        potential_contraction = (destroys[k], creates[l])
        if !contraction_filter(potential_contraction)
            fail = true
            break
        end
        if regularise && !regular(potential_contraction)
            fail = true
            break
        end
        push!(contraction, potential_contraction)
    end
    return contraction, fail
end
function prepare_args(args::Vector{<:QField})
    _length = length(args)
    @assert _length % 2 == 0 "Number of fields must be even"

    n_destroy = _length ÷ 2

    # make sure that the fields are ordered position && ladder
    check_sorted(args) # TODO should remove in future

    destroys = args[1:n_destroy]
    creates = reverse(args[(n_destroy + 1):end])
    return destroys, creates, n_destroy
end
function check_sorted(args)
    args′ = sort(args; by=position)
    args′′ = sort(args′; by=ladder)
    @assert isequal(args, args′′) "Arguments are not sorted"
end

function make_propagators(contraction::Vector{Vector{Contraction}})::Vector{Vector{SNuN}}
    propagators = map(contraction) do factor
        to_prop = x -> propagator(x...)
        _propagators = to_prop.(factor)
        sort!(_propagators; by=position)
    end
    return propagators
end

make_mul(v::Vector{SNuN}) = isempty(v) ? 0 : prod(v)
make_term(vp::Vector{Vector{SNuN}}) = isempty(vp) ? 0 : sum(make_mul, vp)
