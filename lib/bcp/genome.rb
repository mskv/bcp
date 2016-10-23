module BCP
  class Genome
    attr_reader :colouring

    def initialize(colouring:)
      @colouring = colouring
    end
  end
end
