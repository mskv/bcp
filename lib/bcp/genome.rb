module BCP
  class Genome
    attr_reader :colouring, :score

    def initialize(colouring:, score: nil)
      @colouring = colouring
      @score = score
    end
  end
end
