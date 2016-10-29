$:.unshift File.dirname(__FILE__)
require "pry"
require "ostruct"

require "bcp/observer"
require "bcp/file_reader"
require "bcp/solver"
require "bcp/genome_initializer"
require "bcp/genome_assessor"
require "bcp/solution_assessor"
require "bcp/crossover_picker"
require "bcp/crossover_performer"
require "bcp/mutator"

GRAPH_FILE_PATH = File.expand_path(File.join(File.dirname(__FILE__), "../external/GEOM30.col"))

observer = BCP::Observer.new
random_generator = Random.new(115032730400174366788466674494640623225)
config = OpenStruct.new(
  observer: observer,
  random_generator: random_generator,
  initial_genome_score: 50,
  punishment_for_same_colour: -1,
  prize_for_correct_colour_distance: 1,
  punishment_for_incorrect_colour_distance: -> (colour_distance, edge_weight) {
    - ((edge_weight - colour_distance).abs * 0.5)
  },
  prize_for_colour_count: -> (colour_count, node_count) {
    (node_count - colour_count) * 0.1
  },
  crossover_breakpoint: -> (node_count) {
    random_generator.rand(node_count)
  },
  population_size: 40,
  mutation_chance: 0.01,
)

graph = BCP::FileReader.read(file_path: GRAPH_FILE_PATH)

solver = BCP::Solver.new(
  config: config,
  genome_initializer: BCP::GenomeInitializer.new(config: config),
  genome_assessor: BCP::GenomeAssessor.new(config: config),
  solution_assessor: BCP::SolutionAssessor.new(config: config),
  crossover_picker: BCP::CrossoverPicker.new(config: config),
  crossover_performer: BCP::CrossoverPerformer.new(config: config),
  mutator: BCP::Mutator.new(config: config),
)

solver.solve(graph: graph)
