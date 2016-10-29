module BCP
  class Genome
    attr_reader :colouring, :score, :missed_colours

    def initialize(colouring:, score: nil, missed_colours: nil)
      @colouring = colouring
      @score = score
      @missed_colours = missed_colours
    end
  end
end
