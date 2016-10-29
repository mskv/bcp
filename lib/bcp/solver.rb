module BCP
  class Solver
    def initialize(
      config:, genome_initializer:, genome_assessor:, solution_assessor:,
      crossover_picker:, crossover_performer:, mutator:
    )
      @config = config
      @genome_initializer = genome_initializer
      @genome_assessor = genome_assessor
      @solution_assessor = solution_assessor
      @crossover_picker = crossover_picker
      @crossover_performer = crossover_performer
      @mutator = mutator
    end

    def solve(graph:)
      population = Array.new(@config.population_size) { genome_initializer.call(graph: graph) }
      assessed_population =
        population.map { |genome| genome_assessor.call(graph: graph, genome: genome) }

      while solution_assessor.continue?(population: assessed_population)
        population = crossover_picker.call(genomes: assessed_population)
          .map { |pair| crossover_performer.call(first_genome: pair[0], second_genome: pair[1]) }
          .flatten
          .map { |genome| mutator.call(genome: genome) }
        assessed_population =
          population.map { |genome| genome_assessor.call(graph: graph, genome: genome) }
      end

      assessed_population
    end

    private

    attr_reader :config, :genome_initializer, :genome_assessor, :solution_assessor,
                :crossover_picker, :crossover_performer, :mutator
  end
end
