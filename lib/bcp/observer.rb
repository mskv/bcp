module BCP
  class Observer
    attr_reader :observations, :best_genome

    def initialize
      @observations = []
      @best_genome = { population_number: nil, genome: nil }
    end

    def observe(population_number:, population:)
      avg_score, avg_missed_colours, avg_max_colour =
        population.reduce([0, 0, 0]) do |acc, genome|
          if !@best_genome[:genome] || genome.score > @best_genome[:genome].score
            @best_genome = { population_number: population_number, genome: genome }
          end

          avg_score, avg_missed_colours, avg_max_colour = acc
          [
            avg_score + genome.score / population.count,
            avg_missed_colours + genome.missed_colours.to_f / population.count,
            avg_max_colour + genome.colouring.max.to_f / population.count
          ]
        end

      @observations.push(
        avg_score: avg_score,
        avg_missed_colours: avg_missed_colours,
        avg_max_colour: avg_max_colour
      )
    end
  end
end
