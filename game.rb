require_relative 'board'
class Game
  attr_accessor :board, :white, :black

  def initialize(white_player, black_player)
    @board = Board.new
    @board.set_board
    @white = white_player
    @black = black_player
    white_player.color = :white
    black_player.color = :black
    white_player.board = @board
    black_player.board = @board
  end

  def game_over?
    won?(:white) || won?(:black)
  end

  def no_moves?(color)
    find_pieces(color).all? {|piece| piece.slides.nil? && piece.jumps.nil?}
  end

  def find_pieces(color)
    pieces = []
    board.grid.each do |row|
      row.each do |piece|
        next if piece.nil?
        pieces << piece if piece.color == color
      end
    end
    pieces
  end

  def won?(color)
    no_moves?(opp(color)) || find_pieces(opp(color)).nil?
  end

  def opp(color)
    if color == :black
      :white
    else
      :black
    end
  end

  def play
    current_player = @black
    until game_over?
      current_player.play_moves
      current_player == @black ? current_player = @white : current_player = @black
    end
  end
end

w = Player.new
b = Player.new
game = Game.new(w,b)

b1 = Piece.new(game.board, [1,1], :black)
w1 = Piece.new(game.board, [2,2], :white)
w2 = Piece.new(game.board, [4,4], :white)

game.play