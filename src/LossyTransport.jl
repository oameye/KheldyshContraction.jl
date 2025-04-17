module LossyTransport

using TermInterface: TermInterface, metadata
using SymbolicUtils: SymbolicUtils, arguments, operation
using Combinatorics: partitions

using Latexify
using MacroTools: MacroTools
using LaTeXStrings

const NO_METADATA = SymbolicUtils.NO_METADATA

# Fields
include("abstract_types.jl")
include("QTerm.jl")
include("field_math.jl")
include("keldysh.jl")
include("hashing.jl")

# Propagators
include("propagator.jl")
include("wick_contractions.jl")

# show methods
include("latexify_recipes.jl")
include("printing.jl")

export @qfields, Destroy, Create, wick_contraction, regularise

end
