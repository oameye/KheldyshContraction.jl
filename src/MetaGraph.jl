
function MetaGraphsNext.MetaGraph(props::Vector{Average})
    _contours = propagator_type.(props)
    positions_int = integer_positions.(props)
    number_of_vertices = length(props) - 1

    graph = Graphs.Multigraph(Graphs.Edge.(positions_int))
    vertices_description = map(
        =>, Base.OneTo(number_of_vertices), Base.OneTo(number_of_vertices)
    )
    edges_description = map(=>, positions_int, _contours)
    return MetaGraphsNext.MetaGraph(
        graph, vertices_description, edges_description, :order_2
    )
end
