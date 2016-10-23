require "bcp/genome"

module BCP
  class CrossoverPerformer
    def initialize(config:)
      @config = config
    end

    def call(first_genome:, second_genome:)
      crossover_breakpoint = @config.crossover_breakpoint.call(first_genome.colouring.count)

      first_colouring = combine_arrays(
        first_genome.colouring, second_genome.colouring, crossover_breakpoint
      )
      second_colouring = combine_arrays(
        second_genome.colouring, first_genome.colouring, crossover_breakpoint
      )

      [
        BCP::Genome.new(colouring: first_colouring),
        BCP::Genome.new(colouring: second_colouring),
      ]
    end

    private

    attr_reader :config

    def combine_arrays(first, second, crossover_breakpoint)
      first.take(crossover_breakpoint).concat(second.drop(crossover_breakpoint))
    end
  end
end
