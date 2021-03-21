class GameBoard
  
  def initialize
    @board = [['','',''],['','',''],['','','']]
  end

  public

  def winner?

  end

  def make_move(side, move)

  end

  def winner

  end

  def display_board

  end
end

def computer_move(board, symbols)
  puts 'computer'
end

def player_move(board, symbols)
  puts "You are #{symbols.key('player')}."
  puts 'Where do you want to move?'
end

def print_game_intro
  puts "Let's play tic-tac-toe!"
  puts 'You know how to play, right?'
  puts 'First to get three in a row wins!'
end

def assign_symbols
  if rand(2).zero?
    { 'x' => 'player', 'o' => 'computer' }
  else
    { 'x' => 'computer', 'o' => 'player' }
  end
end

# Game loop
begin
  print_game_intro
  board = GameBoard.new
  symbols = assign_symbols

  until board.winner?
    board.display_board
    if symbols['x'] == 'player'
      player_move(board, symbols)
      computer_move(board, symbols)
    else
      computer_move(board, symbols)
      player_move(board, symbols)
    end
  end

  puts "Congratulations, #{board.winner}! You won!"
  puts "Press 'q' to quit, or any other key to play again."
end until gets.chomp == 'q'