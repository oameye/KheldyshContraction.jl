using Combinatorics, BenchmarkTools

function f(n)
    number_of_combinations = factorial(n)
    to_skip = factorial(n - 1) # due in-out contraction constaint
    iter = 1:n
    contraction = Vector{Int}[]
    for i in (to_skip + 1):number_of_combinations
        perm = Combinatorics.nthperm(iter, i)
        push!(contraction, perm)
    end
end

function g(n)
    number_of_combinations = factorial(n)
    to_skip = factorial(n - 1) # due in-out contraction constaint
    iter = 1:n
    contraction = collect(permutations(iter))[(to_skip + 1):number_of_combinations]
end

n = 9
@btime f($n)
@btime g($n)
# ^ f is faster than g
