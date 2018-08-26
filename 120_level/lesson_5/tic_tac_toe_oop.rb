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

  def initialize
    @board = (1..9).each_with_object({}) { |pos, result| result[pos] = Square.new }
  end

  def [](index)
    board[index]
  end
  
  def free_spaces
    board.select { |_, square| square.marker == ' ' }.keys
  end

  def board_full?
    board.free_spaces.empty?
  end

  def choices
    free_spaces.join " "
  end
end

class Player
  include Displayable
  attr_accessor :choice

  def initialize
    @score = 0
  end

  def increment_score
    @score += 1
  end
end

class Computer
  def initialize
    @score = 0
  end

  def increment_score
    @score += 1
  end
end

class Square
  attr_accessor :marker

  def initialize
    @marker = ' '
  end

  def to_s
    marker
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

  def first_player_moves
    choice_prompt

    loop do
      player.choice = gets.chomp.to_i
      break if board.free_spaces.include? player.choice
      choice_prompt
    end

    board[player.choice].marker = "X"
  end

  def second_player_moves

  end

  def someone_won?
    binding.pry
  end

  def play
    greeting
    display_board
    loop do
      display_board
      first_player_moves

      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end

    display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play