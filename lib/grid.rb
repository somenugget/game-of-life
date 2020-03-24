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

    @grid = Array
            .new(width * height)
            .map! { Cell.new }
            .each_slice(width)
            .to_a

    @cells_alive.each do |coordinates|
      @grid.dig(*coordinates).live!
    end
  end

  def evolve
    log_grid_state!

    grid_cells.each do |grid_cell|
      cell = grid_cell[:cell]
      alive_neighbours_count = neighbours(grid_cell[:x], grid_cell[:y]).select(&:alive?).count

      if cell.alive?
        cell.will_be_alive!(false) unless (2..3).include? alive_neighbours_count
      elsif alive_neighbours_count == 3
        cell.will_be_alive!
      end
    end

    apply_changes!
  end

  def apply_changes!
    grid_cells.each do |grid_cell|
      grid_cell[:cell].apply_changes!
    end
  end

  def neighbours(x, y)
    RELATIVE_NEIGHBOUR_COORDINATES.values.map do |x_diff, y_diff|
      neighbour_x = x + x_diff
      neighbour_y = y + y_diff

      @grid.dig(
        neighbour_x < width ? neighbour_x : 0,
        neighbour_y < width ? neighbour_y : 0
      )
    end
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

  def grid_cells
    cells = []

    @grid.each_with_index do |rows, x|
      rows.each_with_index do |cell, y|
        cells.push(x: x, y: y, cell: cell)
      end
    end

    cells
  end

  def to_s
    @grid
      .map { |line| line.map(&:to_s).join(' ') }
      .join("\n")
  end

  private

  def log_grid_state!
    @grid_state_log.push to_s
  end
end
