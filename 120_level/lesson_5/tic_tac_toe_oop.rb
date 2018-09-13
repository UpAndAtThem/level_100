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

# --------------------------------------------------

# Board class
class Board
  attr_reader :squares

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]].freeze # diagnals

  def initialize
    @squares = (1..9).each_with_object({}) do |position, result|
      result[position] = Square.new
    end
  end

  # rubocop:disable Metrics/AbcSize
  def display
    puts ''
    puts '     |     |'
    puts "  #{squares[1]}  |  #{squares[2]}  |  #{squares[3]} "
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{squares[4]}  |  #{squares[5]}  |  #{squares[6]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{squares[7]}  |  #{squares[8]}  |  #{squares[9]}"
    puts '     |     |'
    puts ''
  end
  # rubocop:enable Metrics/AbcSize, MethodLength

  def winning_lines
    WINNING_LINES
  end

  def [](index)
    squares[index]
  end

  def []=(index, value)
    squares[index].marking = value
  end

  def free_positions
    squares.select { |_, square| square.marking == Square::BLANK }.keys
  end

  def joinor(arr, delimiter = ',', conjunction = 'or')
    case arr.size
    when 1
      arr.first
    when 2
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

  def get_line_markings(line)
    squares.values_at(*line).map(&:marking)
  end

  def two_markers_and_blank?(line, marker)
    line_markings = get_line_markings line

    line_markings.count(marker) == 2 &&
      line_markings.count(Square::BLANK) == 1
  end

  def three_in_a_row?(line)
    line_markings = get_line_markings line

    line_markings.uniq.first != Square::BLANK &&
      line_markings.uniq.count == 1
  end

  def won_round?
    winning_lines.any? do |line|
      three_in_a_row?(line) ? true : false
    end
  end
end

# Player class
class Player
  attr_accessor :name, :marker, :score

  def initialize(marker)
    self.score = 0
    self.marker = marker
  end

  def to_s
    name
  end

  def increment_score
    self.score += 1
  end
end

# Human class
class Human < Player
  attr_accessor :marker

  def initialize
    super nil
  end

  def set_name
    loop do
      print "\nWhat is your first name?: "
      self.name = gets.chomp.capitalize.strip
      break unless name.empty?
    end
  end

  def valid_choice?(choice)
    choice.length == 1 && choice != 'O'
  end

  def set_marker
    loop do
      print "Choose a single character as your marker: "
      marker = gets.chomp.strip

      if valid_choice? marker
        @marker = marker
        break
      end
    end
  end
end

# Computer class
class Computer < Player
  def initialize(marker)
    super
  end

  def set_name
    self.name = ['Wall-e', 'Eve', 'R2D2', 'Hal',
                 'Miss Machina', 'The Voice from Knight Rider'].sample
  end
end

# Square class
class Square
  attr_accessor :marking

  BLANK = ' '.freeze

  def initialize
    self.marking = BLANK
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
      board.two_markers_and_blank?(line, human.marker)
    end
  end

  def offensive_move?
    board.winning_lines.any? do |line|
      board.two_markers_and_blank? line, computer.marker
    end
  end

  def make_move(marker)
    board.winning_lines.each do |line|
      player_markings = marker_line_positions(line, marker)
      blank_spaces = marker_line_positions(line, Square::BLANK)

      if player_markings.count == 2 && blank_spaces.count == 1
        board[blank_spaces.first] = TTTGame::COMPUTER_MARKER
        return nil
      end
    end
  end

  def middle_available?
    board[5].marking == Square::BLANK
  end

  def middle_move
    board[5] = computer.marker
  end

  def random
    choice = board.free_positions.sample
    board[choice] = TTTGame::COMPUTER_MARKER
  end
end

# module TTTDisplays
module TTTDisplays
  private

  def display_greeting
    clear
    puts 'Welcome to Tic Tac Toe.'
    puts "The first player to #{best_to} wins!"
  end

  def display_board
    clear
    board.display
  end

  def display_score
    puts "\n#{human.name}'s score: #{human.score}"
    puts "#{computer.name}'s score: #{computer.score}"
  end

  def dispaly_round_winner
    winner ? puts("#{@winner.name} wins!") : puts("It's a tie!")
  end

  def display_result
    dispaly_round_winner
    display_score

    return if [computer.score, human.score].include? best_to

    print "\nPress enter to start new round:"
    gets.chomp
  end

  def display_goodbye_message
    puts "\nCongratulations to #{winner} for being the grand champion."
    puts "\nThanks for playing Tic Tac Toe! Goodbye!"
  end
end

# Moving module
module Moving
  private

  def human_moves
    choice_prompt
    choice = nil

    loop do
      choice = gets.chomp.to_i

      break if board.free_positions.include? choice
      choice_prompt
    end

    board[choice] = human.marker
  end

  def computer_moves
    sleep 1.25

    if offensive_move?
      make_move TTTGame::COMPUTER_MARKER
    elsif defensive_move?
      make_move human.marker
    elsif middle_available?
      middle_move
    else
      random
    end
  end

  def current_player_moves
    if current_player.marker == human.marker
      human_moves
    else
      computer_moves
    end
  end

  def players_make_moves
    loop do
      current_player_moves
      display_board

      break if board.won_round? || board.full?
      rotate_players
    end
  end
end

# TTTGame class
class TTTGame
  COMPUTER_MARKER = 'O'.freeze

  include TTTDisplays, AI, Moving

  attr_accessor :board, :human, :computer, :winner,
                :current_player, :first_player

  attr_reader :best_to

  def initialize(best_to)
    @best_to = best_to
    @human = Human.new
    @computer = Computer.new(COMPUTER_MARKER)
    @board = Board.new
  end

  private

  def clear
    system('clear') || system('cls')
  end

  def set_winner
    return unless board.won_round?

    self.winner = (human.marker == current_player.marker ? human : computer)
    winner.increment_score
  end

  def reset
    self.board = Board.new
    self.winner = nil
    self.current_player = first_player
  end

  def choose_first
    choice = nil

    loop do
      puts "\nWho do you want to go first?"
      print "Enter '1' for #{human.name}.\nEnter '2' for #{computer.name}.\n\n:"

      choice = gets.chomp.to_i

      break if [1, 2].member? choice
    end

    self.current_player = (choice == 1 ? human : computer)
    self.first_player = @current_player
  end

  def marker_line_positions(line, marker)
    line.select do |position|
      board[position].marking == marker
    end
  end

  def choice_prompt
    puts "Choose a square: #{board.choices}"
  end

  def rotate_players
    self.current_player =
      if current_player == human
        computer
      else
        human
      end
  end

  def set_names
    human.set_name
    computer.set_name
  end

  def game_loop
    loop do
      display_board
      players_make_moves
      set_winner
      display_result

      break if [human.score, computer.score].include? best_to
      reset
    end
  end

  public

  def play
    display_greeting
    set_names
    human.set_marker
    choose_first
    game_loop
    display_goodbye_message
  end
end

game = TTTGame.new(3)
game.play
