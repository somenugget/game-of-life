require 'matrix'
require 'dry-initializer'
require_relative 'cell'

class Grid
  extend Dry::Initializer

  RELATIVE_NEIGHBOUR_COORDINATES = {
    north: [-1, 0].freeze, north_east: [-1, 1].freeze,
    east: [0, 1].freeze,   south_east: [1, 1].freeze,
    south: [1, 0].freeze,  south_west: [1, -1].freeze,
    west: [0, -1].freeze,  north_west: [-1, -1].freeze
  }.freeze

  option :width
  option :height
  option :cells_alive, default: proc { [] }

  def initialize(**)
    super

    @grid_state_log = []
    @grid = Matrix.build(height, width) { Cell.new }
    @cells_alive.each { |coordinates| @grid[*coordinates].live! }
  end

  def evolve
    log_grid_state!

    grid_cells.each do |grid_cell|
      grid_cell[:cell].will_be_alive_with_neighbours! neighbours(grid_cell[:x], grid_cell[:y])
    end

    apply_changes!
  end

  def lifeless?
    grid_cells.all? { |grid_cell| grid_cell[:cell].dead? }
  end

  def unchanged?
    @grid_state_log.last == to_s
  end

  def in_cycle?
    @grid_state_log.include? to_s
  end

  def to_s
    @grid
      .to_a
      .map { |line| line.map(&:to_s).join(' ') }
      .join("\n")
  end

  private

  def apply_changes!
    grid_cells.each do |grid_cell|
      grid_cell[:cell].apply_changes!
    end
  end

  def neighbours(x, y)
    RELATIVE_NEIGHBOUR_COORDINATES.values.map do |x_diff, y_diff|
      neighbour_x = x + x_diff
      neighbour_y = y + y_diff

      @grid[
        neighbour_y < width ? neighbour_y : 0,
        neighbour_x < width ? neighbour_x : 0
      ]
    end
  end

  def grid_cells
    cells = []

    @grid.each_with_index do |cell, y, x|
      cells.push(x: x, y: y, cell: cell)
    end

    cells
  end

  def log_grid_state!
    @grid_state_log.push to_s
  end
end
