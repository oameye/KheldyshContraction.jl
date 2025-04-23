using BenchmarkTools
using KeldyshContraction
using KeldyshContraction: Classical, Quantum, Plus, Minus

const SUITE = BenchmarkGroup()

include("first_order_two_body_loss.jl")

benchmark_two_body_loss!(SUITE)

BenchmarkTools.tune!(SUITE)
results = BenchmarkTools.run(SUITE; verbose=true)
display(median(results))

BenchmarkTools.save("benchmarks_output.json", median(results))
