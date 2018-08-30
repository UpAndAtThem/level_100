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

class Board
  attr_reader :board

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]] # diagnals

  def initialize
    @board = (1..9).each_with_object({}) { |pos, result| result[pos] = Square.new }
  end

  def display
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

  def winning_states
    WINNING_LINES
  end

  def [](index)
    board[index]
  end

  def []=(index, value)
    board[index].marking = value 
  end
  
  def free_positions
    board.select { |_, square| square.marking == ' ' }.keys
  end

  def full?
    free_positions.empty?
  end

  def three_in_a_row?(line)
    line_markings = board.values_at(*line).map(&:marking)

    line_markings.uniq.first != ' ' && line_markings.uniq.count == 1
  end

  def won_round?
    WINNING_LINES.any? do |line|
      if three_in_a_row? line
        true
      else
        false
      end
    end
  end

  def choices
    free_positions.join " "
  end
end

class Player
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
  INITIAL_MARKER = ' '

  def initialize
    @marking = INITIAL_MARKER
  end

  def to_s
    marking
  end
end

class TTTGame
  COMPUTER_MARKER = 'O'
  PLAYER_MARKER = 'X'

  attr_accessor :board, :player, :computer, :best_to, :winner, :current_player

  def initialize(best_to)
    @best_to = best_to
    @player = Player.new(PLAYER_MARKER)
    @computer = Computer.new(COMPUTER_MARKER)
    @board = Board.new
  end

  private

  def choose_first
    choice = nil
    
    loop do
      print "\nWho do you want to go first? \nEnter '1' for Player.  Enter '2' for Computer: "
      choice = gets.chomp.to_i

      break if [1,2].member? choice
    end
    @current_player = choice == 1 ? player : computer
    @first_player = @current_player
  end

  def clear
    system 'clear'
    system 'cls'
  end

  def greeting(best_to)
    system 'clear'
    print "Welcome to Tic Tac Toe.\nThe first player to #{best_to} wins! \nPress enter to continue:"
    gets.chomp
  end

  def set_winner
    @winner = player.marker == current_player.marker ? player : computer
    @winner.score += 1 
  end

  def reset
    @board = Board.new
    @winner = nil
    @current_player = @first_player
  end

  def first_player_moves
    choice_prompt
    player_choice = nil

    loop do
      player_choice = gets.chomp.to_i

      break if board.free_positions.include? player_choice
      choice_prompt
    end

    board[player_choice] = PLAYER_MARKER
  end

  def second_player_moves
    sleep 1.25
    choice = board.free_positions.sample
    board[choice] = COMPUTER_MARKER
  end

  def display_board
    clear
    board.display
  end

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

  def choice_prompt
    puts "Choose a square: #{board.choices}"
  end

  def current_player_moves
    if current_player.marker == 'X'
      first_player_moves
    else
      second_player_moves
    end
  end

  def rotate_current_player
    self.current_player = current_player.marker == 'X' ? computer : player
  end

  public

  def play
    greeting(best_to)
    choose_first

    loop do
      display_board

      loop do
        current_player_moves
        display_board

        break if board.won_round? || board.full?
        rotate_current_player
      end

      set_winner
      display_result

      break if [player.score, computer.score].include? best_to
      reset
    end

    display_goodbye_message
  end
end

game = TTTGame.new(3)
game.play
