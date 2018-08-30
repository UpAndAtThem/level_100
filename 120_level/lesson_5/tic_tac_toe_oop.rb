# Description
# commandline tic tac toe is a game where 2 players a player and computer
# take turns choosing a square on a 3 X 3 board until one of them reaches 3
# quares in a row, column, or diagonal.

# Nouns:
#   -game
#   -player
#   -computer
#   -square
#   -board
# Verbs:
#   -play
#   -choose

# Board class
class Board
  attr_reader :board

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]].freeze # diagnals

  def initialize
    @board = (1..9).each_with_object({}) do |pos, result|
      result[pos] = Square.new
    end
  end

  # rubocop:disable Metrics/AbcSize, MethodLength
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
  # rubocop:enable Metrics/AbcSize, MethodLength

  def winning_lines
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

  def joinor(arr, delimiter = ',', conjunction = 'or')
    if arr.size == 1
      arr.first
    elsif arr.size == 2
      "#{arr.first} #{conjunction} #{arr.last}"
    else
      arr[0..-2].join("#{delimiter} ") +
        "#{delimiter} #{conjunction} #{arr.last}"
    end
  end

  def choices
    joinor free_positions
  end

  def full?
    free_positions.empty?
  end

  def two_opponent_and_blank?(line)
    line_markings = board.values_at(*line).map(&:marking)
    line_markings.count(TTTGame::PLAYER_MARKER) == 2 &&
    line_markings.count(' ') == 1
  end

  def three_in_a_row?(line)
    line_markings = board.values_at(*line).map(&:marking)

    line_markings.uniq.first != ' ' && line_markings.uniq.count == 1
  end

  def won_round?
    winning_lines.any? do |line|
      three_in_a_row?(line) ? true : false
    end
  end
end

# Player class
class Player
  attr_reader :marker, :score

  def initialize(marker)
    @score = 0
    @marker = marker
  end

  def to_s
    'Player'
  end

  def increment_score
    @score += 1
  end
end

# Computer class
class Computer
  attr_reader :marker, :score

  def initialize(marker)
    @score = 0
    @marker = marker
  end

  def to_s
    'Computer'
  end

  def increment_score
    @score += 1
  end
end

# Square class
class Square
  attr_accessor :marking
  INITIAL_MARKER = ' '.freeze

  def initialize
    @marking = INITIAL_MARKER
  end

  def to_s
    marking
  end
end

# TTTDisplays module
module AI
  private

  def defensive_move?
    board.winning_lines.any? do |line|
      board.two_opponent_and_blank?(line)
    end
  end

  def player_marker_position(line, marker)
    line.select do |position|
      board[position].marking == marker
    end
  end

  def defensive
    board.winning_lines.any? do |line|
      marker = TTTGame::PLAYER_MARKER

      player_markings = player_marker_position(line, marker)
      blank_spaces = player_marker_position(line, ' ')

      if player_markings.count == 2 && blank_spaces.count == 1
        board[blank_spaces.first] = TTTGame::COMPUTER_MARKER
        return
      end
    end
  end

  def offensive_move?

  end

  def offensive

  end

  def middle_available?

  end

  def middle

  end

  def random
    choice = board.free_positions.sample
    board[choice] = TTTGame::COMPUTER_MARKER
  end
end

module TTTDisplays
  private

  def display_greeting(best_to)
    clear
    puts 'Welcome to Tic Tac Toe.'
    print "The first player to #{best_to} wins! \nPress enter to continue:"
    gets.chomp
  end

  def display_board
    clear
    board.display
  end

  def display_score
    puts "\nPlayer score: #{player.score}\nComputer score: #{computer.score}"
  end

  def dispaly_round_winner
    @winner ? puts("#{@winner} wins!") : puts("It's a tie!")
  end

  def display_result
    dispaly_round_winner
    display_score

    return if [computer.score, player.score].include? best_to

    print "\nPress enter to start new round:"
    gets.chomp
  end

  def display_goodbye_message
    puts "\nCongratulations to the #{winner} for being the grand champion."
    puts "\nThanks for playing Tic Tac Toe! Goodbye!"
  end
end

# TTTGame class
class TTTGame
  COMPUTER_MARKER = 'O'.freeze
  PLAYER_MARKER = 'X'.freeze

  include TTTDisplays, AI
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
      puts "\nWho do you want to go first?"
      print "Enter '1' for Player.  Enter '2' for Computer: "

      choice = gets.chomp.to_i

      break if [1, 2].member? choice
    end
    @current_player = choice == 1 ? player : computer
    @first_player = @current_player
  end

  def clear
    system('clear') || system('cls')
  end

  def set_winner
    return unless board.won_round?
    @winner = player.marker == current_player.marker ? player : computer
    @winner.increment_score
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

    if offensive_move?
      offensive
    elsif defensive_move?
      defensive
    elsif middle_available?
      middle
    else
      random
    end
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

  def players_make_moves
    loop do
      current_player_moves
      display_board

      break if board.won_round? || board.full?
      rotate_current_player
    end
  end

  def game_loop
    loop do
      display_board
      players_make_moves
      set_winner
      display_result

      break if [player.score, computer.score].include? best_to
      reset
    end
  end

  public

  def play
    display_greeting(best_to)
    choose_first
    game_loop
    display_goodbye_message
  end
end

game = TTTGame.new(3)
game.play
