# Description
# commandline tic tac toe is a game where 2 players a player and computer take turns choosing a square
# on a 3 X 3 board until one of them reaches 3 squares in a row, column, or diagonal.

# Nouns:
#   -game
#   -player
#   -computer
#   -square
#   -board
# Verbs:
#   -play
#   -choose

require 'pry'

module Displayable
  def display_result
    display_board
    binding.pry
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    system 'clear'

    puts ''
    puts '     |     |'
    puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]} "
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}"
    puts '     |     |'
    puts ''
  end

  def choice_prompt
    puts "Choose a square: #{board.choices}"
  end  
end

class Board
  attr_reader :board
  include Displayable

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]] # diagnals

  def initialize
    @board = (1..9).each_with_object({}) { |pos, result| result[pos] = Square.new }
  end

  def winning_states
    WINNING_LINES
  end

  def [](index)
    board[index]
  end
  
  def free_spaces
    board.select { |_, square| square.marking == ' ' }.keys
  end

  def full?
    free_spaces.empty?
  end

  def choices
    free_spaces.join " "
  end
end

class Player
  include Displayable
  attr_accessor :choice, :winner, :marking

  def initialize
    @score = 0
    @marking = 'X'
  end

  def increment_score
    @score += 1
  end
end

class Computer
  include Displayable
  attr_accessor :choice, :winner, :marking

  def initialize
    @score = 0
    @marking = 'O'
  end

  def increment_score
    @score += 1
  end
end

class Square
  attr_accessor :marking

  def initialize
    @marking = ' '
  end

  def to_s
    marking
  end
end

class TTTGame
  include Displayable
  attr_accessor :board, :player, :computer

  def initialize
    @player = Player.new
    @computer = Computer.new
    @board = Board.new
  end

  def greeting
    puts "Welcome to Tic Tac Toe"
  end

  def set_winner(marking)
    @winner = player.marking == marking ? player : computer
  end

  def first_player_moves
    choice_prompt

    loop do
      player.choice = gets.chomp.to_i

      break if board.free_spaces.include? player.choice
      choice_prompt
    end

    board[player.choice].marking = "X"
  end

  def second_player_moves
    choice = board.free_spaces.sample
    board[choice].marking = 'O'
  end

  def someone_won?(passed_marking)
    board.winning_states.any? do |winning_set|
      win = winning_set.all? { |square| board[square].marking == passed_marking }
      set_winner(passed_marking) if win
    end
  end

  def play
    greeting
    display_board
    loop do
      first_player_moves
      display_board

      break if someone_won?("X") || board.full?

      second_player_moves
      display_board
      break if someone_won?("O") || board.full?
    end

    display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
