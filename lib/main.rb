require_relative 'game'

width = 30
height = 30
cells_alive_count = (width * height) / 10

# random game
cells_alive = Array.new(cells_alive_count).map { [rand(width - 1), rand(height - 1)] }

# glider
# cells_alive = [[0, 2], [1, 0], [1, 2], [2, 1], [2, 2]]

# block
# cells_alive = [[0, 0], [0, 1], [1, 1], [1, 0]]
Game.new(width: width, height: height, cells_alive: cells_alive).call
