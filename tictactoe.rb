class GameBoard
  attr_reader :board

  def initialize
    @board = [*'1'..'9']
  end

  def initialize_copy(original)
    @board = original.board.dup
  end

  public

  def make_move(symbol, move)
    if @board[move - 1] != 'x' && @board[move - 1] != 'o'
      @board[move - 1] = symbol
      true
    else
      false
    end
  end

  def winner
    %w[x o].each do |symbol|
      if @board[0] == symbol && @board[1] == symbol && @board[2] == symbol ||
         @board[3] == symbol && @board[4] == symbol && @board[5] == symbol ||
         @board[6] == symbol && @board[7] == symbol && @board[8] == symbol ||
         @board[0] == symbol && @board[3] == symbol && @board[6] == symbol ||
         @board[1] == symbol && @board[4] == symbol && @board[7] == symbol ||
         @board[2] == symbol && @board[5] == symbol && @board[8] == symbol ||
         @board[0] == symbol && @board[4] == symbol && @board[8] == symbol ||
         @board[2] == symbol && @board[4] == symbol && @board[6] == symbol
        return symbol
      end
    end
    @board.each do |n|
      return false if n.to_i.between?(1, 9)
    end
    'tie'
  end

  def display_board
    puts ''
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts '---+---+---'
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts '---+---+---'
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    puts ''
  end
end

def computer_move(board, symbol)
  opponent = symbol == 'x' ? 'o' : 'x'
  if (move = winning_move(board, symbol)) ||  # See if computer can win
     (move = winning_move(board, opponent))   # See if player can win, and block
    board.make_move(symbol, move)
  elsif board.dup.make_move(symbol, 5)    # Move to center if possible
    board.make_move(symbol, 5)
  else
    [1, 3, 7, 9, 2, 4, 6, 8].each do |n|
      if board.dup.make_move(symbol, n)   # Move to corner, or edge, if possible
        board.make_move(symbol, n)
        break
      end
    end
  end
  'player'
end

def winning_move(board, symbol)
  (1..9).each do |move|
    temp_board = board.dup
    temp_board.make_move(symbol, move)
    return move if temp_board.winner == symbol
  end
  false
end

def player_move(board, symbol)
  puts "You are #{symbol}."
  puts 'Where do you want to move?'
  loop do
    move = gets.chomp.to_i
    break if move.between?(1, 9) && board.make_move(symbol, move)

    puts 'Invalid move'
  end
  'computer'
end

def print_game_intro
  puts "Let's play tic-tac-toe!"
  puts 'You know how to play, right?'
  puts 'First to get three in a row wins!'
end

def assign_symbols
  rand(2).zero? ? %w[x o] : %w[o x]
end

def announce_winner(board, player)
  board.display_board
  if board.winner == player
    puts 'Congratulations, player! You won!'
  elsif board.winner == 'tie'
    puts 'It was a tie!'
  else
    puts 'You lost!'
  end
end

# Game loop
loop do
  print_game_intro
  board = GameBoard.new
  player, computer = assign_symbols

  turn = player == 'x' ? 'player' : 'computer'

  until board.winner
    board.display_board
    case turn
    when 'player'
      turn = player_move(board, player)
    when 'computer'
      turn = computer_move(board, computer)
    end
  end

  announce_winner(board, player) 

  puts "Press 'q' to quit, or any other key to play again."
  break if gets.chomp == 'q'
end
