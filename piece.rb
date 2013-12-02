class Piece
  attr_accessor :board, :position, :color, :king

  def initialize(board, pos, color) #pos will be an array of two elements
    @board, @position, @color = board, pos, color
    @king = :false
    @board.grid[pos[0]][pos[1]] = self
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

  def perform_slide(end_pos)
    return false unless valid_slide?(end_pos)
    @board[position] = nil
    @board[end_pos] = self
    self.position = end_pos
    self.maybe_promote
    true
  end

  def valid_slide?(end_pos)
    if self.board.occupied?(end_pos) || !slides.include?(end_pos)
      return false
    else
      return true
    end
  end

  def slides
    slides = []
    move_shifts.each do |shift|
      potential_move = [@position[0] + shift[0], @position[1] + shift[1]]
      unless (board.occupied?(potential_move) && board.on_board?(potential_move))
        slides << potential_move
      end
    end
    slides
  end

  def perform_jump(end_pos)
    return false unless valid_jump?(end_pos)
    jump_shift = [end_pos[0] - position[0], end_pos[1] - position[1]]
    @board[position] = nil
    @board.grid[position[0] + jump_shift[0]][position[1] + jump_shift[0]] = nil
    @board[end_pos] = self
    self.position = end_pos
    self.maybe_promote
    true
  end

  def jumps
    jumps = []
    move_shifts.each do |shift|
      potential_jump = [@position[0] + shift[0]*2, @position[1] + shift[1]*2]
      jumped_pos = [@position[0] + shift[0], @position[1] + shift[1]]
      jumped_piece = board[jumped_pos]
      if board.occupied?(jumped_pos) && jumped_piece.color != @color
        jumps << potential_jump
      end
    end
    jumps
  end

  def valid_jump?(end_pos)
    if self.board.occupied?(end_pos) || !jumps.include?(end_pos)
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