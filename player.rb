class Player
  attr_accessor :board, :color

  def initialize
  end

  def play_moves
    puts "Please enter piece to move. Format: 2,4"
    start_pos = gets.chomp.split(",").map {|elem| Integer(elem)}
    puts "Enter a sequence of moves, separated by a return."
    puts "Type 'done' when done."
    moves = []
    input = ""
    until input == "done"
      input = gets.chomp
      move = input.split(",").map {|elem| elem.to_i}
      moves << move unless move == [0]
    end
    start_piece = board[start_pos]
    start_piece.perform_moves(moves)
  end

end