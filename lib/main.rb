require_relative 'game'


width = 30
height = 30

cells_alive = Array.new(80).map { [rand(width - 1), rand(height - 1)] }
# cells_alive = [[0, 2], [1, 0], [1, 2], [2, 1], [2, 2]]
# cells_alive = [[0, 0], [0, 1], [1, 1], [1, 0]]
Game.new(width: width, height: height, cells_alive: cells_alive).call
