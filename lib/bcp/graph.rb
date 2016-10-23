module BCP
  class Graph
    attr_reader :node_count, :edge_count

    def initialize(node_count:, edge_count:, edge_connections:)
      @node_count = node_count
      @edge_count = edge_count

      @adjacency_matrix = build_adjacency_matrix(node_count, edge_connections)
    end

    private

    attr_reader :adjacency_matrix

    def build_adjacency_matrix(node_count, edge_connections)
      empty_matrix = Array.new(node_count) { Array.new(node_count, 0) }
      edge_connections.reduce(empty_matrix) do |acc, connection|
        acc[connection[:start]][connection[:end]] = connection[:weight]
        acc[connection[:end]][connection[:start]] = connection[:weight]
        acc
      end
    end
  end
end
