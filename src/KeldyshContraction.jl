"""
$(DocStringExtensions.README)
"""
module KeldyshContraction

using DocStringExtensions

using TermInterface: TermInterface, metadata
using SymbolicUtils: SymbolicUtils, arguments, operation, @syms
using Combinatorics: Combinatorics
using OrderedCollections: OrderedCollections

using Latexify
using MacroTools: MacroTools
using LaTeXStrings

const NO_METADATA = SymbolicUtils.NO_METADATA

# Fields
include("keldysh_algebra.jl")
include("QTerm.jl")
include("field_math.jl")
include("hashing.jl")
include("InteractionLagrangian.jl")

# Propagators
include("propagator.jl")
include("symbolic_utils.jl")
include("wick_contractions.jl")
include("self_energy.jl")

# show methods
include("latexify_recipes.jl")
include("printing.jl")

export @qfields,
    Destroy,
    Create,
    wick_contraction,
    Quantum,
    Classical,
    DressedPropagator,
    SelfEnergy,
    InteractionLagrangian,
    @syms,
    arguments

end
