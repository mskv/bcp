require "bcp/genome"

module BCP
  class GenomeAssessor
    def initialize(config:)
      @config = config
    end

    def call(graph:, genome:)
      score = genome.colouring
        .each_with_index.reduce(@config.initial_genome_score) do |score, (first_colour, first_node)|
          genome.colouring.drop(first_node + 1)
            .each_with_index.reduce(score) do |score, (second_colour, second_node_relative)|
              second_node = first_node + 1 + second_node_relative
              edge_weight = graph.edge_weight(first_node, second_node)
              next score unless edge_weight

              colour_distance = (first_colour - second_colour).abs

              if first_colour == second_colour
                score += config.punishment_for_same_colour
              end

              if colour_distance >= edge_weight
                score += config.prize_for_correct_colour_distance
              else
                score += config.punishment_for_incorrect_colour_distance.call(
                  colour_distance, edge_weight
                )
              end

              score
            end
        end
      score += config.prize_for_colour_count.call(genome.colouring.max, graph.node_count)
      BCP::Genome.new(colouring: genome.colouring, score: score)
    end

    private

    attr_reader :config
  end
end
