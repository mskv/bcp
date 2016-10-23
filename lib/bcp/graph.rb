module BCP
  class Graph
    attr_reader :node_count, :edge_count

    def initialize(node_count:, edge_count:, edge_connections:)
      @node_count = node_count
      @edge_count = edge_count
      @edge_connections = edge_connections

      @adjacency_matrix = build_adjacency_matrix(node_count, edge_connections)
    end

    def edge_weight(first_node, second_node)
      adjacency_matrix[first_node][second_node]
    end

    private

    attr_reader :edge_connections, :adjacency_matrix

    def build_adjacency_matrix(node_count, edge_connections)
      empty_matrix = Array.new(node_count) { Array.new(node_count, nil) }
      edge_connections.reduce(empty_matrix) do |acc, connection|
        acc[connection[:start]][connection[:end]] = connection[:weight]
        acc[connection[:end]][connection[:start]] = connection[:weight]
        acc
      end
    end
  end
end
