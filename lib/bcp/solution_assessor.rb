module BCP
  class SolutionAssessor
    def initialize(config:)
      @config = config
      @counter = 0
    end

    def continue?(population:)
      config.observer.observe(population_number: counter, population: population)

      bump_counter

      counter < 500
    end

    private

    def bump_counter
      @counter += 1
    end

    attr_reader :config, :counter
  end
end
