require "bcp/genome"

module BCP
  class Mutator
    def initialize(config:)
      @config = config
    end

    def call(genome:)
      BCP::Genome.new(
        colouring: mutate_colouring(genome),
        score: nil,
      )
    end

    private

    attr_reader :config

    def mutate_colouring(genome)
      genome.colouring.map do |colour|
        chance = config.random_generator.rand
        if chance < config.mutation_chance
          config.random_generator.rand(genome.colouring.count)
        else
          colour
        end
      end
    end
  end
end
