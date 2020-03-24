require 'dry-initializer'
require_relative 'grid'

class Game
  extend Dry::Initializer

  option :width
  option :height
  option :cells_alive, default: proc { [] }

  def grid
    @grid ||= Grid.new(width: width, height: height, cells_alive: cells_alive)
  end

  def call
    at_exit { puts 'bye' }

    game_loop do
      puts grid

      break if grid.lifeless?
      break if grid.unchanged?
      break if grid.in_cycle?

      grid.evolve

    end

    puts ''
    puts game_end_reason
  end

  def game_end_reason
    if grid.lifeless?
      'Life ended'
    elsif grid.unchanged?
      'Progress stopped'
    elsif grid.in_cycle?
      'Life cycled'
    else
      'Unknown'
    end
  end

  def game_loop
    loop do
      system('clear')

      yield

      sleep 0.1
    rescue Interrupt
      exit 0
    end
  end
end
