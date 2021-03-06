require 'yaml'

# DisplayableMessage module
module DisplayableMessage
  def display_welcome_message
    puts messages['greeting']
  end

  def display_rules
    clear_screen
    messages['rules'].each { |_, rule| puts rule }

    puts format(messages['first_to'], wins_needed: RPSGame::BEST_TO)
    puts messages['understand']

    print messages['press_enter']
    gets.chomp
    clear_screen
  end

  def display_goodbye_message
    clear_screen
    puts messages['farewell']
  end

  def display_round_result
    if tie?
      display_tie
      return
    end

    display_winner
  end

  def display_score
    human_stats = "#{human.name} has #{human.score}"
    computer_stats = "#{computer.name} has #{computer.score}"

    puts ""
    puts "#{human_stats}  -  #{computer_stats}".center(width_of_winner)
  end

  def message_to_player
    if winner.class == Human
      puts messages['player_win_comment'][win_by]
    else
      puts messages['computer_win_comment'][win_by]
    end
  end

  def congrats_message
    puts format(messages['winner_congrats'],
                the_winner: winner.name, best_to: RPSGame::BEST_TO)
  end

  def display_game_result
    clear_screen
    congrats_message
    message_to_player
  end
end

# DisplayableSprites module
module DisplayableSprites
  def pow
    ["╔═╗╔═╗╦ ╦┬",
     "╠═╝║ ║║║║│",
     "╩  ╚═╝╚╩╝o"]
  end

  def clouds
    ["            _                                   ",
     "         (`  ).                   _             ",
     "        (     ).              .:(`  )`.         ",
     "       _(       '`.          :(   .    )        ",
     "   .=(`(      .   )     .--  `.  (    ) )       ",
     "  ((    (..__.:'-'   .+(   )   ` _`  ) )        ",
     "  `(       ) )       (   .  )     (   )  ._     ",
     "    ` __.:'   )     (   (   ))     `-'.-(`  )   ",
     " ( )       --'       `- __.'         :(      )) ",
     "(_.'          .')                    `(    )  ))",
     "             (_  )                     ` __.:'  "]
  end

  def tie
    ["\n\n\n\n",
     ' ╦ ╔╦╗ ╔═╗    ╔═╗    ╔╦╗  ╦  ╔═╗',
     ' ║  ║  ╚═╗    ╠═╣     ║   ║  ║╣ ',
     ' ╩  ╩  ╚═╝    ╩ ╩     ╩   ╩  ╚═╝',
     '                          ',
     '╔═╗   ╦ ╦   ╔═╗   ╔═╗   ╔═╗   ╔═╗ ',
     '║     ╠═╣   ║ ║   ║ ║   ╚═╗   ║╣  ',
     '╚═╝   ╩ ╩   ╚═╝   ╚═╝   ╚═╝   ╚═╝ ',
     '   ╔═╗   ╔═╗   ╔═╗   ╦   ╔╗╔',
     '   ╠═╣   ║ ╦   ╠═╣   ║   ║║║',
     '   ╩ ╩   ╚═╝   ╩ ╩   ╩   ╝╚╝']
  end

  def num_spaces_to_center_of_sprite
    wins_letter_length = 5

    num_w_space_before_type = winner.move.sprite[-1].count(" ")

    num_w_space_to_center_under_type =
      (winner.move.value.length / 2) - (wins_letter_length / 2)

    num_w_space_before_type +
      num_w_space_to_center_under_type
  end

  def display_winning_sprite
    wins = "WINS!\n\n\n"
    num_to_center = num_spaces_to_center_of_sprite

    display_name_bottom winner
    puts((' ' * num_to_center) + wins)
  end

  def display_fighting_method
    winning_style = messages[winner.move.value][loser.move.value]

    puts winning_style.center(winner.sprite_width)
  end

  def display_winner_name
    puts "#{winner.name} wins the round!".center(winner.sprite_width)
  end

  def display_winner
    display_winning_sprite
    display_fighting_method
    display_winner_name
    display_score
  end

  def display_name_bottom(player)
    player.move.sprite[1..-1].each { |row| puts row }
  end

  def display_name_top
    vs_space_width = 12

    computer.move.sprite[0..-2].each do |row|
      puts((' ' * (human.sprite_width + vs_space_width)) + row)
    end
  end

  def display_sprite_left
    display_name_bottom human
  end

  def display_sprite_right
    display_name_top
  end

  def display_center_vs
    width = human.sprite_width

    vs = (' ' * (width + 5)) + 'vs'
    puts vs
  end

  def display_tie
    tie.each { |row| puts((' ' * 20) + row) }
  end

  def display_sprite_center(sprite_choice)
    sprite_choice.each { |row| puts((' ' * 20) + row) }
  end

  def pow_animation
    clear_screen

    [pow, clouds, pow].each do |current_sprite|
      display_sprite_center current_sprite
      sleep 0.5
    end

    clear_screen
  end

  def display_opponents
    clear_screen
    display_sprite_left
    display_center_vs
    display_sprite_right
    sleep 1.5
  end
end

# RPSGame class
class RPSGame
  attr_accessor :human, :computer
  include DisplayableSprites, DisplayableMessage

  MESSAGES = YAML.load_file('rpsls_oop_messages.yml')
  OPTIONS_WIDTH = MESSAGES['choose_move'].length
  BEST_TO = 5

  def initialize
    display_rules
    @human = Human.new
    @computer = Computer.new
  end

  def messages
    MESSAGES
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def winner
    if human.move > computer.move
      human
    elsif computer.move > human.move
      computer
    end
  end

  def loser
    if human.move < computer.move
      human
    elsif computer.move < human.move
      computer
    end
  end

  def tie?
    human.move.value == computer.move.value
  end

  def winner?
    human.score == BEST_TO || computer.score == BEST_TO
  end

  def width_of_winner
    winner.sprite_width
  end

  def adjust_score
    if human.move > computer.move
      human.score += 1
    elsif human.move < computer.move
      computer.score += 1
    end
  end

  def clear_scores
    human.score = 0
    computer.score = 0
  end

  def play_again?
    loop do
      puts messages['another_game']
      choice = gets.chomp

      return choice == 'y' if ['y', 'n'].include? choice

      puts messages['y_or_n']
    end
  end

  def reset
    sleep 3.5
  end

  def players_choose
    clear_screen
    human.choose
    computer.choose
  end

  def add_player_history
    computer.add_to_history(human.move)
  end

  def win_by
    (computer.score - human.score).abs
  end

  def play
    loop do
      players_choose
      add_player_history

      display_opponents
      pow_animation

      adjust_score

      display_round_result
      reset

      if winner?
        display_game_result
        clear_scores
        break unless play_again?
      end
    end
    display_goodbye_message
  end
end

# Move class
class Move
  attr_reader :value, :type

  LOSES_AGAINST = { 'rock' => %w[lizard scissors], 'paper' => %w[rock spock],
                    'scissors' => %w[lizard paper], 'lizard' => %w[spock paper],
                    'spock' => %w[rock scissors] }.freeze

  WINS_AGAINST = { 'rock' => %w[spock paper], 'paper' => %w[scissors lizard],
                   'scissors' => %w[rock spock], 'lizard' => %w[rock scissors],
                   'spock' => %w[lizard paper] }.freeze

  VALUES = { 1 => 'rock', 2 => 'paper', 3 => 'scissors',
             4 => 'lizard', 5 => 'spock' }.freeze

  def initialize(value)
    @value = value
  end

  def self.types
    Move::VALUES.values
  end

  def rock?
    value == 'rock'
  end

  def scissors?
    value == 'scissors'
  end

  def paper?
    value == 'paper'
  end

  def lizard?
    value == 'lizard'
  end

  def spock?
    value == 'spock'
  end

  def >(other_move)
    LOSES_AGAINST[value].include?(other_move.value)
  end

  def <(other_move)
    WINS_AGAINST[value].include?(other_move.value)
  end
end

# Player class
class Player
  attr_accessor :move, :name, :score
  attr_reader :sprite

  def initialize
    set_name
    @score = 0
  end

  def messages
    RPSGame::MESSAGES
  end

  def create_move(move_type)
    case move_type
    when 'rock' then Rock.new
    when 'paper' then Paper.new
    when 'scissors' then Scissors.new
    when 'lizard' then Lizard.new
    when 'spock' then Spock.new
    end
  end

  def sprite_width
    move.sprite.max_by(&:length).length
  end
end

class Human < Player
  OPTIONS_WIDTH = RPSGame::OPTIONS_WIDTH
  VALUES = Move::VALUES
  CENTER_UNDER_OPTIONS = (OPTIONS_WIDTH / 2) - 1

  def prompt_move
    puts messages['one_through'].center(OPTIONS_WIDTH)
    puts messages['choose_move'].center(OPTIONS_WIDTH)
    print "\n#{' ' * CENTER_UNDER_OPTIONS}"
  end

  def valid_choice?(choice)
    Move::VALUES.keys.include? choice
  end

  def choose
    loop do
      prompt_move
      choice = gets.chomp.to_i

      if valid_choice? choice
        self.move = create_move(VALUES[choice])
        return nil
      end
      puts messages['invalid_move'].center(OPTIONS_WIDTH)
    end
  end

  def valid_name?(name)
    !name.empty?
  end

  def prompt_name
    print messages['prompt_name'].rjust(40)
  end

  def set_name
    loop do
      prompt_name
      name = gets.chomp.strip

      if valid_name?(name)
        self.name = name
        return nil
      end
      puts messages['invalid_name'].center(OPTIONS_WIDTH)
    end
  end
end

# Computer class
class Computer < Player
  attr_accessor :name, :opponent_history

  def initialize
    super
    @opponent_history = []
  end

  def set_name
    self.name = ['R2D2', 'Furiosa', 'Hal', 'Ripley',
                 'Chappie', 'Dolores', 'Jaycee'].sample
  end

  def wins_against(move_type)
    Move::WINS_AGAINST[move_type]
  end

  def random_type
    Move::VALUES.values.sample
  end

  def random_selection
    create_move(random_type)
  end

  def random_weighted_selection(most_chosen_type)
    (Move.types + wins_against(most_chosen_type)).sample
  end

  def smart_move
    return random_selection if opponent_history.empty?

    most_chosen_type = find_most_chosen

    move = random_weighted_selection(most_chosen_type)

    create_move move
  end

  def most_frequent_type(occurances)
    occurances.sort_by { |_, occurance| occurance }.last[0]
  end

  def find_most_chosen
    hash = Hash.new(0)
    occurances = opponent_history.each_with_object(hash) do |move, result|
      result[move.value] += 1
    end

    most_frequent_type occurances
  end

  def choose
    self.move = smart_move
  end

  def add_to_history(opponent_move)
    opponent_history << opponent_move
  end
end

# Rock class
class Rock < Move
  def initialize
    super "rock"
  end

  def sprite
    ["                   ROCK",
     '                          _',
     '                -` -`\ -_-_ /. --/^./\__    ',
     '            .--"\\ _ \\__/.      \\ /     \\}',
     '   -\\_    _/ ^      \\/  __  :"   ^\\^\\  ^\\ ',
     '  ;``-^_    \\  /    ."   _/  /  \\   ^ /  \\^',
     ' /\\/\\^ /\\/ :" __  ^/  ^/    `--./."  ^  `-.)',
     '/   ^\\/   \\ _{  \\-" __/." ^ _   \\_   ."\'  }',
     '  .-   `. \\/     {\\ / -.   _/ \\ -. `_/   \\ /',
     '`-.__ ^--=/ .-".--"    . /    `--./ .-"  `',
     '                   ROCK']
  end
end

# Paper class
class Paper < Move
  def initialize
    super "paper"
  end

  # rubocop:disable Metrics/MethodLength
  def sprite
    ["            PAPER",
     "             _._________",
     "          _.'           ;..",
     "      _.-'          _.'`   \\",
     "    _'______     _.'        |",
     "  .'        '-.-'           |",
     " /            \\             |",
     "|     __      |             |",
     "|   .x$$x.    |             |",
     "|   |%$$$|    |             |",
     "|   |%%$$|    |             |",
     "|   '%%%?'    ;             |",
     " \\           ,|         ,.-.\\",
     "  '.______ ,-  |      .- `",
     "               \\..- ^`   ",
     "            PAPER"]
  end
  # rubocop:enable Metrics/MethodLength
end

# Scissors class
class Scissors < Move
  def initialize
    super "scissors"
  end

  def sprite
    ['                SCISSORS',
     ' ,--.',
     '(    )____ ___________________________',
     ' `--"---,-"  ,.   --------------------`-.',
     ' ,--.---`-.__`"__|_______________________`>',
     '(    )',
     ' `--\'',
     '                SCISSORS']
  end
end

# Lizard class
class Lizard < Move
  def initialize
    super "lizard"
  end

  def sprite
    ["               LIZARD",
     "                     )/_",
     "              _.--..---\"-,----c_",
     "         \\L..'           .___O__)====&",
     ",-.     _.+  _  \\..--( /",
     " `\\.-''__.-' \\ (     \\_ ",
     "   `'''       `\\__   /\\",
     "               ')",
     "               LIZARD"]
  end
end

# Spock class
class Spock < Move
  def initialize
    super "spock"
  end

  # rubocop:disable Metrics/MethodLength
  def sprite
    ["             SPOCK",
     '               .',
     '              .:.',
     '             .:::.',
     '             .:::::.',
     '        ***.:::::::.***',
     '    *******.:::::::::.*******',
     '  ********.:::::::::::.********',
     ' ********.:::::::::::::.********',
     ' *******.::::::\'***`::::.*******',
     ' ******.::::\'*********`::.******',
     ' ****.:::\'*************`:.****',
     '   *.::\'*****************`.*',
     '    .:\'  ***************    .',
     "  .",
     "             SPOCK"]
  end
  # rubocop:enable Metrics/MethodLength
end

RPSGame.new.play
