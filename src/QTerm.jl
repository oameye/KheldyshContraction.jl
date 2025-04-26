########################
#    Multiplication
########################

"""
$(TYPEDEF)

Represent a multiplication involving quantum fields  of [`QSym`](@ref) types.

$(FIELDS)
"""
struct QMul{M,T} <: QTerm
    "The commutative prefactor."
    arg_c::T
    "A vector containing all [`QSym`](@ref) types."
    args_nc::Vector{QField}
    "The metadata associated with the term. Should default to `nothing`."
    metadata::M
    function QMul{M,T}(arg_c, args_nc, metadata) where {M,T}
        if SymbolicUtils._isone(arg_c) && length(args_nc) == 1
            return args_nc[1]
        elseif (0 in args_nc) || isequal(arg_c, 0)
            return 0
        else
            return new(arg_c, args_nc, metadata)
        end
    end
end
function QMul(arg_c::T, args_nc; metadata::M=NO_METADATA) where {M,T}
    return QMul{M,T}(arg_c, args_nc, metadata)
end

SymbolicUtils.operation(::QMul) = (*)
SymbolicUtils.arguments(a::QMul) = vcat(a.arg_c, a.args_nc)

function SymbolicUtils.maketerm(::Type{<:QMul}, ::typeof(*), args, metadata)
    args_c = filter(x -> !(x isa QField), args)
    args_nc = filter(x -> x isa QField, args)
    arg_c = isempty(args_c) ? 1 : *(args_c...)
    isempty(args_nc) && return arg_c
    return QMul(arg_c, args_nc; metadata)
end

SymbolicUtils.metadata(a::QMul) = a.metadata

function Base.adjoint(q::QMul)
    args_nc = map(adjoint, q.args_nc)
    reverse!(args_nc) # TODO fields switch under adjoint right?
    sort!(args_nc; by=position)
    return QMul(conj(q.arg_c), args_nc; q.metadata)
end

function Base.isequal(a::QMul, b::QMul)
    isequal(a.arg_c, b.arg_c) || return false
    length(a.args_nc) == length(b.args_nc) || return false
    for (arg_a, arg_b) in zip(a.args_nc, b.args_nc)
        isequal(arg_a, arg_b) || return false
    end
    return true
end

"""
    isbulk(q::QTerm)

Checks if a term is in the bulk. A term is bulk if it has no `In` or `Out` position fields ([`AbstractPosition`](@ref)).
"""
isbulk(q::QMul) = all(isbulk.(q.args_nc))
allfields(q::QMul) = q.args_nc

########################
#       Addition
########################

"""
    QAdd <: QTerm

Represent an addition involving [`QField`](@ref) and other types.
"""
struct QAdd <: QTerm
    arguments::Vector{QSymbol}
end
SymbolicUtils.operation(::QAdd) = (+)
SymbolicUtils.arguments(a::QAdd) = a.arguments
SymbolicUtils.maketerm(::Type{<:QAdd}, ::typeof(+), args, metadata) = QAdd(args)

function Base.isequal(a::QAdd, b::QAdd)
    length(arguments(a)) == length(arguments(b)) || return false
    for (arg_a, arg_b) in zip(arguments(a), arguments(b))
        isequal(arg_a, arg_b) || return false
    end
    return true
end

Base.adjoint(q::QAdd) = QAdd(map(adjoint, arguments(q)))
isbulk(q::QAdd) = all(isbulk.(arguments(q)))
allfields(q::QAdd) = reduce(vcat, allfields.(SymbolicUtils.arguments(q)))

###########################
#  Interaction Lagrangian
###########################

"""
$(TYPEDEF)

Represents an interaction Lagrangian

# Fields
$(FIELDS)

# Constructor
$(TYPEDSIGNATURES)

Constructs an InteractionLagrangian from a given [`QTerm`](@ref) expression.

# Requirements
The constructor enforces several constraints on the input expression and throws `AssertionError` if any of them are not met:
- Must be a bulk term ([`KeldyshContraction.isbulk`](@ref))
- Must be conserved ([`KeldyshContraction.is_conserved`](@ref))
- Must be physical ([`KeldyshContraction.is_physical`](@ref))
- Can only contain up to two different fields
- Fields must have opposite contours

"""
struct InteractionLagrangian{T}
    "The Lagrangian expression as a [`QTerm`](@ref)"
    lagrangian::T
    "The quantum field destruction operator"
    qfield::Destroy{Quantum,Bulk(0),Zero,Nothing}
    "The classical field destruction operator"
    cfield::Destroy{Classical,Bulk(0),Zero,Nothing}
    function InteractionLagrangian(expr::QTerm)
        @assert isbulk(expr) "An interaction Lagrangian only accepts bulk terms"
        @assert is_conserved(expr) "An interaction Lagrangian only accepts conserved terms"
        @assert is_physical(expr) "An interaction Lagrangian only accepts physical terms"
        fields = filter(is_annihilation, unique(set_reg_to_zero.(allfields(expr))))
        @assert length(fields) <= 2 "An interaction Lagrangian only accepts up to two different fields"
        contours = Int.(contour.(fields))
        @assert unique(contours) == contours "An interaction Lagrangian only accepts fields with opposite contours"
        q_idx = findfirst(iszero, contours)
        c_idx = findfirst(isone, contours)
        return new{typeof(expr)}(expr, fields[q_idx], fields[c_idx])
    end # TODO what if only quantum or only classical
end

"""
    is_conserved(a::QTerm)

Checks if an expression [`KeldyshContraction.QTerm`])(@ref) is conserved. A conserved expression is one that has equal numbers of creation and annihilation operators.

See also: [`is_physical`](@ref)
"""
function is_conserved(args_nc_::Vector{<:QField})
    n_destroy = isa.(args_nc_, Destroy)
    if length(args_nc_) == 0 || iszero(sum(n_destroy))
        return false
    else
        length(args_nc_) == 1
        return length(args_nc_) ÷ sum(n_destroy) == 2
    end
end
is_conserved(a::QMul) = is_conserved(a.args_nc)
is_conserved(a::QAdd) = all(is_conserved.(arguments(a)))
is_conserved(a::QSym) = false

"""
    is_physical(a::QTerm)

Checks if an expression [`KeldyshContraction.QTerm`])(@ref) is physical. A physical expression is one that if it has an `In` position field it also has an `Out` position field and vice versa ([`Position`])(@ref). Furthermore, `In` position field can only creation fields ([`Create`](@ref)) and `Out` position field can only have annihilation fields ([`Destroy`](@ref)).

See also: [`is_conserved`](@ref)
"""
function is_physical(args_nc_::Vector{<:QField})
    positions = position.(args_nc_)
    # checks if a mul has both in-out in a lagrangian
    in_out = In() ∈ positions ? Out() ∈ positions : true
    out_in = Out() ∈ positions ? In() ∈ positions : true
    physical = all(map(is_physical, args_nc_)) # individual field are physical
    return physical && in_out && out_in
end
is_physical(a::QMul) = is_physical(a.args_nc)
is_physical(a::QAdd) = all(is_physical.(arguments(a)))
is_physical(a::Destroy) = !isa(position(a), In)
is_physical(a::Create) = !isa(position(a), Out)
# # Propagators
# include("propagator.jl")
# include("symbolic_utils.jl")
# include("wick_contractions.jl")
# include("self_energy.jl")

# # show methods
# include("latexify_recipes.jl")
# include("printing.jl")
