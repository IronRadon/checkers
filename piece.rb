class Piece
  attr_accessor :board, :position, :color, :king

  def initialize(pos) #pos will be an array of two elements
    @position = pos
    @king = :false
  end

  def perform_slide(end_pos)
    @board.grid[position[0]][position[1]] = nil #remove piece from old pos
    @board.grid[end_pos[0]][end_pos[1]] = self #move piece on board
    self.position = end_pos #set piece position
  end

  def move_diffs
    if @king == true
      move_diffs = [[1,1], [1,-1],[-1,1], [-1,-1]]
    elsif
      @color == :black
      move_diffs = [[1,1], [-1,1]]
    else
      move_diffs = [[1,-1], [-1,-1]]
    end
    move_diffs
  end


end