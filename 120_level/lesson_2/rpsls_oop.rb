require 'yaml'
# DisplayableMessage module
module DisplayableMessage
  def display_welcome_message
    puts messages['greeting']
  end

  def display_rules
    messages['rules'].each { |_, rule| puts rule }

    puts format(messages['first_to'], wins_needed: RPSGame::BEST_TO)
    puts messages['understand']

    print messages['press_enter']
    gets.chomp

    clear_screen
  end

  def display_goodbye_message
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
    puts "\n#{human.name} has #{human.score}."
    puts "#{computer.name} has #{computer.score}"
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

  def display_winning_sprite
    num_blank_spaces = winner.move.sprite[-1].count " "

    winner.move.sprite[1..-1].each { |line| puts line }
    puts(' ' * num_blank_spaces + "WINS!\n\n\n")
  end

  def display_fighting_method
    puts messages[winner.move.value][loser.move.value]
  end

  def display_winner
    display_winning_sprite
    display_fighting_method
    display_score
  end

  def display_left
    @human.move.sprite[1..-1].each { |row| puts row }
  end

  def display_center_vs
    width_of_sprite = @human.move.sprite.max_by(&:length).length

    vs = (' ' * (width_of_sprite + 5)) + 'vs'
    puts vs
  end

  def display_tie
    tie.each { |row| puts((' ' * 20) + row) }
  end

  def width_of_opponent
    @human.move.sprite.max_by(&:length).length
  end

  def display_right
    width = width_of_opponent

    @computer.move.sprite[0..-2].each do |row|
      puts(' ' * (width + 12) + row)
    end
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
    display_left
    display_center_vs
    display_right
    sleep 1.5
  end
end

# Player class
class Player
  attr_accessor :move, :name, :score
  attr_reader :sprite, :MESSAGES

  MESSAGES = YAML.load_file('rpsls_oop_messages.yml')

  def initialize
    set_name
    @score = 0
  end

  def create_move(move_type)
    case move_type
    when 'rock' then Rock.new('rock')
    when 'paper' then Paper.new('paper')
    when 'scissors' then Scissors.new('scissors')
    when 'lizard' then Lizard.new('lizard')
    when 'spock' then Spock.new('spock')
    end
  end
end

class Human < Player
  def prompt_move
    puts MESSAGES['one_through']
    puts MESSAGES['choose_move']
  end

  def valid_choice?(choice)
    Move::VALUES.keys.include? choice
  end

  def choose
    loop do
      prompt_move
      choice = gets.chomp.to_i

      if valid_choice? choice
        self.move = create_move(Move::VALUES[choice])
        return nil
      end
      puts MESSAGES['invalid_move']
    end
  end

  def valid_name?(name)
    !name.empty?
  end

  def set_name
    loop do
      puts MESSAGES['prompt_name']
      name = gets.chomp.strip

      if valid_name?(name)
        self.name = name
        return nil
      end
      puts MESSAGES['invalid_name']
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
    self.name = ['R2D2', 'Hal', 'Chappie', 'Dolores'].sample
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

  def smart_move
    return random_selection if opponent_history.empty?

    most_chosen_type = find_most_chosen.value

    move = (Move.types + wins_against(most_chosen_type)).sample

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

    most_frequent = most_frequent_type occurances

    Move.new(most_frequent)
  end

  def choose
    self.move = smart_move
  end

  def add_to_history(opponent_move)
    @opponent_history << opponent_move
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
    @value == 'rock'
  end

  def scissors?
    @value == 'scissors'
  end

  def paper?
    @value == 'paper'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def >(other_move)
    LOSES_AGAINST[value].include?(other_move.value)
  end

  def <(other_move)
    WINS_AGAINST[value].include?(other_move.value)
  end
end

# Rock class
class Rock < Move
  def sprite
    ["                     ROCK",
     '                          _',
     '                / -` -`\ -_ /.  /^./\__    ',
     '    _        .--"\\ _ \\__/.      \\ /    \\',
     '   / \\_    _/ ^      \\/  __  :"   /\\/\\  /\\ ',
     '  ;-_    \\  /    ."   _/  /  \\   ^ /    \\/',
     ' /\\/\\  /\\/ :" __  ^/  ^/    `--./."  ^  `-.',
     '/    \\/  \\  _/  \\-" __/." ^ _   \\_   ."\'',
     '  .-   `. \\/     \\ / -.   _/ \\ -. `_/   \\ /',
     '`-.__ ^   / .-".--"    . /    `--./ .-"  `-',
     '                     ROCK']
  end
end

# Paper class
class Paper < Move
  # rubocop:disable Metrics/MethodLength
  def sprite
    ["       PAPER",
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
     "        PAPER"]
  end
  # rubocop:enable Metrics/MethodLength
end

# Scissors class
class Scissors < Move
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
     "  .           SPOCK"]
  end
end

# RPSGame class
class RPSGame
  attr_accessor :human, :computer
  include DisplayableSprites, DisplayableMessage

  MESSAGES = YAML.load_file('rpsls_oop_messages.yml')

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
      puts MESSAGES['another_game']
      choice = gets.chomp

      if ['y', 'n'].include? choice
        return choice == 'y'
      end
      puts MESSAGES['y_or_n']
    end
  end

  def reset
    sleep 2.5
    clear_screen
  end

  def players_choose
    human.choose
    computer.choose
  end

  def add_player_history
    computer.add_to_history(human.move)
  end

  def winner?
    human.score == BEST_TO || computer.score == BEST_TO
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

RPSGame.new.play
