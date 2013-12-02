class Piece
  attr_accessor :board, :position, :color, :king

  def initialize(board, pos, color) #pos will be an array of two elements
    @board, @position, @color = board, pos, color
    @king = :false
  end

  #incomPLETE! DON'T TEST IT YET OMG
  def perform_slide(end_pos)
    return false unless valid_move?(end_pos)
    @board.grid[position[0]][position[1]] = nil #remove piece from old pos
    @board.grid[end_pos[0]][end_pos[1]] = self #move piece on board
    self.position = end_pos
    self.maybe_promote
    true
  end

  def move_shifts
    if @king == true
      move_shifts = [[1,1], [1,-1],[-1,1], [-1,-1]]
    elsif
      @color == :black
      move_shifts = [[1,1], [-1,1]]
    else
      move_shifts = [[1,-1], [-1,-1]]
    end
    move_shifts
  end

  def slides
    slides = []
    move_shifts.each do |shift|
      potential_move = [@position[0] + shift[0], @position[1] + shift[1]]
      unless (board.occupied?(potential_move) && board.on_board?(self))
        slides << potential_move
      end
    end
    slides
  end

  def valid_move?(end_pos) #currently for slide moves only
    if self.board.occupied?(end_pos) || !slides.include?(end_pos)
      return false
    else
      return true
    end
  end

  def maybe_promote
    if self.color == :black && self.position[0] == 7
      self.king = :true
    elsif
      self.color == :white && self.position[0] == 0
      self.king = :true
    end
  end


end