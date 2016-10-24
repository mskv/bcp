module BCP
  class CrossoverPicker
    def initialize(config:)
      @config = config
    end

    def call(genomes:)
      sorted_genomes = genomes.sort { |x, y| x.score <=> y.score }

      score_sum = genomes.reduce(0) { |acc, g| acc + g.score }
      genomes_with_probability_ranges = sorted_genomes.reduce([[], 0]) do |acc, genome|
        result, pivot_memo = acc
        hi = genome.score / score_sum + pivot_memo
        [
          result.concat([{ genome: genome, lo: pivot_memo, hi: hi }]),
          hi,
        ]
      end.first

      sorted_genomes.each_with_index.map do |genome, index|
        ran = @config.random_generator.rand
        pick = genomes_with_probability_ranges.select do |genome_with_range|
          genome_with_range[:lo] <= ran && genome_with_range[:hi] > ran
        end.first[:genome]
        [genome, pick]
      end.last(sorted_genomes.count / 2)
    end

    private

    attr_reader :config
  end
end
