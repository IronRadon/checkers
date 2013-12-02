class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) {Array.new(8)}
  end

  def on_board?(piece)
    piece.position.max < 7 && piece.position.min >= 0
  end

  def occupied?(position)
    @grid[position[0]][position[1]] != nil
  end

end