
#################################
#       Contraction
#################################
"""
    wick_contraction(L::InteractionLagrangian; order=1)


All the same coordinate advanced propagators are converted to retarded propagators.
"""
function DressedPropagator(L::InteractionLagrangian; order=1)
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
        keldysh = multuply!(
            wick_contraction(ψ(Out()) * ψ'(In()) * L1.lagrangian * L2.lagrangian), prefactor
        )

        retarded = multuply!(
            wick_contraction(ψ(Out()) * ϕ'(In()) * L1.lagrangian * L2.lagrangian), prefactor
        )
        advanced = multuply!(
            wick_contraction(ϕ(Out()) * ψ'(In()) * L1.lagrangian * L2.lagrangian), prefactor
        )
    else
        error("higher order then two not implemented")
    end
    filter_nonzero!(keldysh)
    filter_nonzero!(retarded)
    filter_nonzero!(advanced)
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
    diagrams = Diagrams()
    foreach(SymbolicUtils.arguments(a)) do arg
        wick_contraction!(diagrams, arg; regularise)
    end
    return diagrams
end
function wick_contraction(a::QMul; regularise=true)
    @assert is_conserved(a)
    @assert is_physical(a)

    contractions = wick_contraction(a.args_nc; regularise)
    imag_factor = im^(first(length(contractions))) # Contraction becomes propagator
    dict = Dict{Diagram,ComplexF64}(
        make_diagram_pair(c, a.arg_c, imag_factor) for c in contractions
    )
    return Diagrams(dict)
end
function wick_contraction!(diagrams::Diagrams, a::QMul; regularise=true)
    @assert is_conserved(a)
    @assert is_physical(a)

    contractions = wick_contraction(a.args_nc; regularise)
    imag_factor = im^(first(length(contractions))) # Contraction becomes propagator
    foreach(contractions) do c
        c′, prefactor = advanced_to_retarded(c, a.arg_c)
        push!(diagrams, Diagram(c′), imag_factor * prefactor)
    end
    return nothing
end
function make_diagram_pair(c, arg_c, imag_factor)
    c′, prefactor = advanced_to_retarded(c, arg_c)
    return diagram(c) => imag_factor * prefactor
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

        # TODO ∨ You can probably cache this
        if fail || !is_connected(contraction) || has_zero_loop(contraction)
            continue
        else
            push!(wick_contractions, canonicalize(contraction))
        end
        check_to_many_bulk(contraction, args_nc) # TODO: remove in future
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
        if regularise
            if !regular(potential_contraction)
                fail = true
                break
            else
                potential_contraction = set_reg_to_zero.(potential_contraction)
            end
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
function check_to_many_bulk(contraction, args_nc)
    pos = Int.(map(position, Iterators.flatten(contraction)))
    for i in unique(pos)
        if count(x -> x == i, pos) > 4
            @show args_nc
            error("Contraction is not unique")
        end
    end
end

function make_propagators(contraction::Vector{Vector{Contraction}})::Vector{Vector{SNuN}}
    propagators = map(contraction) do factor
        to_prop = x -> propagator(x...)
        _propagators = to_prop.(factor)
        sort!(_propagators; by=position)
    end
    return propagators
end # TODO: remove in future

make_mul(v::Vector{SNuN}) = isempty(v) ? 0 : prod(v) # TODO: remove in future
make_term(vp::Vector{Vector{SNuN}}) = isempty(vp) ? 0 : sum(make_mul, vp) # TODO: remove in future
