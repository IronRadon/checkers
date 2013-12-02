class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) {Array.new(8)}
  end

  def on_board?(position)
    position.max < 7 && position.min >= 0
  end

  def occupied?(position)
    @grid[position[0]][position[1]] != nil
  end

  def [](position)
    x, y = position
    @grid[x][y]
  end

  def []=(position, piece)
    x, y = position
    @grid[x][y] = piece
  end

end