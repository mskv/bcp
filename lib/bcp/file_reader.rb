require "bcp/graph"

module BCP
  class FileReader
    class << self
      def read(file_path:)
        node_count, edge_count, edge_connections = parse_file(file_path)
        BCP::Graph.new(
          node_count: node_count, edge_count: edge_count, edge_connections: edge_connections
        )
      end

      private

      def parse_file(file_path)
        node_count = 0
        edge_count = 0
        edge_connections = []

        File.open(file_path, "r") do |file|
          while (line = file.gets)
            data = line.split
            case line[0]
              when "c"
                next

              when "p"
                node_count, edge_count = data.drop(2).map(&:to_i)

              when "e"
                edge_start, edge_end, edge_weight = data.drop(1).map(&:to_i)
                if edge_start == edge_end
                  edge_count -= 1
                else
                  edge_connections.push({ start: edge_start, end: edge_end, weight: edge_weight })
                end

              when "n"
                next

              else
                fail "No handler for line #{line}"
            end
          end
        end

        [node_count, edge_count, edge_connections]
      end
    end
  end
end
