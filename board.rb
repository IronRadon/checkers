class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) {Array.new(8)}
  end

  def set_board
    black_start = [[0, 0],
    [0, 2],
    [0, 4],
    [0, 6],
    [1, 1],
    [1, 3],
    [1, 5],
    [1, 7],
    [2, 0],
    [2, 2],
    [2, 4],
    [2, 6]]

    white_start = [[7, 1],
    [7, 3],
    [7, 5],
    [7, 7],
    [6, 0],
    [6, 2],
    [6, 4],
    [6, 6],
    [5, 1],
    [5, 3],
    [5, 5],
    [5, 7]]

    black_start.each do |position|
      @board[position] = Piece.new(self, position, :black)
    end

    white_start do |position|
      @board[position] = Piece.new(self, position, :white)
    end
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

  def dup
    board_dup = Board.new
    grid.each_with_index do |row, row_index|
      row.each_with_index do |piece, col_index|
        next if piece.nil?
        board_dup[[row_index, col_index]] = piece.dup
      end
    end
    board_dup
  end

  def no_pieces?(color)
    grid.all? do |row|
      row.none? do |piece|
        next if piece.nil?
        piece.color == color
      end
    end
  end

  def display
    display = ""
    grid.each do |row|
      row.each do |piece|
        if piece.nil?
          display << "_"
        else
          display << piece.display
        end
      end
      display << "\n"
    end
    puts display
  end

end