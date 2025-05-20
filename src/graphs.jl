
function graph(vs::Vector{Contraction})
    ps = integer_positions.(vs)
    graph = Graphs.SimpleGraphFromIterator(Graphs.Edge.(ps))
end
