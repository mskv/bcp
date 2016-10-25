module BCP
  class SolutionAssessor
    def initialize(config:)
      @config = config
      @counter = 0
    end

    def continue?
      bump_counter

      counter < 50000
    end

    private

    def bump_counter
      @counter += 1
    end

    attr_reader :config, :counter
  end
end
