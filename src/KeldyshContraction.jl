"""
$(DocStringExtensions.README)
"""
module KeldyshContraction

using DocStringExtensions

using TermInterface: TermInterface
using SymbolicUtils: SymbolicUtils, @syms, arguments
using Combinatorics: Combinatorics
using OrderedCollections: OrderedCollections

using Latexify
using MacroTools: MacroTools
using LaTeXStrings

# Fields
include("keldysh_algebra/keldysh_algebra.jl")
include("keldysh_algebra/QTerm.jl")
include("keldysh_algebra/field_math.jl")
include("keldysh_algebra/hashing.jl")
include("InteractionLagrangian.jl")

# Propagators
include("propagator.jl")
include("dressed_propagator.jl")
include("symbolic_utils.jl")
include("reguralisation.jl")
include("filters.jl")
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
