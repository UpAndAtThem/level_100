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
    @winner ? puts("#{@winner} wins!") : puts("It's a tie!")
    puts "\nPlayer score: #{player.score}\nComputer score: #{computer.score}"

    return if [computer.score, player.score].include? best_to

    print "\nPress enter to start new round:"
    gets.chomp
  end

  def display_goodbye_message
    puts "\nCongratulations to the #{winner} for being the grand champion."
    puts "\nThanks for playing Tic Tac Toe! Goodbye!"
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
  
  def free_positions
    board.select { |_, square| square.marking == ' ' }.keys
  end

  def full?
    free_positions.empty?
  end

  def choices
    free_positions.join " "
  end
end

class Player
  include Displayable
  attr_reader :marker
  attr_accessor :score

  def initialize(marker)
    @score = 0
    @marker = marker
  end

  def to_s
    "Player"
  end

  def increment_score
    @score += 1
  end
end

class Computer
  include Displayable
  attr_reader :marker
  attr_accessor :score

  def initialize(marker)
    @score = 0
    @marker = marker
  end

  def to_s
    "Computer"
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
  COMPUTER_MARKER = 'O'
  PLAYER_MARKER = 'X'

  include Displayable
  attr_accessor :board, :player, :computer, :best_to, :winner

  def initialize(best_to)
    @best_to = best_to
    @player = Player.new(PLAYER_MARKER)
    @computer = Computer.new(COMPUTER_MARKER)
    @board = Board.new
  end

  def greeting(best_to)
    system "clear"
    print "Welcome to Tic Tac Toe.\nThe first player to #{best_to} wins! \nPress enter to continue:"
    gets.chomp
  end

  def set_winner(passed_marker)
    @winner = player.marker == passed_marker ? player : computer
    @winner.score += 1 
  end

  def reset
    @board = Board.new
    @winner = nil
  end

  def first_player_moves
    choice_prompt
    player_choice = nil

    loop do
      player_choice = gets.chomp.to_i

      break if board.free_positions.include? player_choice
      choice_prompt
    end

    board[player_choice].marking = PLAYER_MARKER
  end

  def second_player_moves
    sleep 1.25
    choice = board.free_positions.sample
    board[choice].marking = COMPUTER_MARKER
  end

  def someone_won?(passed_marker)
    board.winning_states.any? do |winning_set|
      win = winning_set.all? { |square| board[square].marking == passed_marker }
      set_winner(passed_marker) if win
    end
  end

  def play
    greeting(best_to)
    loop do
      display_board
      loop do
        first_player_moves
        display_board
        break if someone_won?(PLAYER_MARKER) || board.full?
  
        second_player_moves
        display_board
        break if someone_won?(COMPUTER_MARKER) ||  board.full?
      end

      display_result

      break if [player.score, computer.score].include? best_to
      reset
    end

    display_goodbye_message
  end
end

game = TTTGame.new(3)
game.play
