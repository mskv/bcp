require "bcp/genome"

module BCP
  class GenomeInitializer
    def initialize(config:)
      @config = config
    end

    def call(graph:)
      random_colouring = Array.new(graph.node_count) do |n|
        @config.random_generator.rand(graph.node_count)
      end
      BCP::Genome.new(colouring: random_colouring)
    end

    private

    attr_reader :config
  end
end
