require 'pry'
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
     ' ╦ ╔╦╗ ╔═╗    ╔═╗    ╔╦╗  ╦  ╔═╗' ,
     ' ║  ║  ╚═╗    ╠═╣     ║   ║  ║╣ ' ,
     ' ╩  ╩  ╚═╝    ╩ ╩     ╩   ╩  ╚═╝' ,
     '                          '       ,
     '╔═╗   ╦ ╦   ╔═╗   ╔═╗   ╔═╗   ╔═╗ ',
     '║     ╠═╣   ║ ║   ║ ║   ╚═╗   ║╣  ',
     '╚═╝   ╩ ╩   ╚═╝   ╚═╝   ╚═╝   ╚═╝ ',
     '   ╔═╗   ╔═╗   ╔═╗   ╦   ╔╗╔',     
     '   ╠═╣   ║ ╦   ╠═╣   ║   ║║║' ,    
     '   ╩ ╩   ╚═╝   ╩ ╩   ╩   ╝╚╝']
  end

  def clear_screen
    system('clear') || system('cls')
  end
  
  def display_left
    @human.move.sprite[1..-1].each { |row| puts row}
  end
  
  def display_center
    width_of_sprite = @human.move.sprite.max_by(&:length).length

    puts(' ' * (width_of_sprite + 5) + 'vs')
  end

  def display_tie
    tie.each { |row| puts((' ' * 20) + row) }
  end
  
  def display_right
    width_of_opponent = @human.move.sprite.max_by(&:length).length
    
    @computer.move.sprite[0..-2].each do |row|
      puts(' ' * (width_of_opponent + 12) + row)
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
    display_center
    display_right
    sleep 1.5
  end
end

class Player
  attr_accessor :move, :name, :score
  attr_reader :opponents_moves, :moves, :sprite, :MESSAGES
  
  require 'yaml'
  MESSAGES = YAML.load_file('rpsls_oop_messages.yml')

  def initialize
    set_name
    @score = 0
    @opponents_moves = []
    @moves = []
  end

  def set_type(move_type)
    case move_type
    when 'rock' then Rock.new('rock')
    when 'paper' then Paper.new('paper')
    when 'scissors' then Scissors.new('scissors')
    when 'lizard' then Lizard.new('lizard')
    when 'spock' then Spock.new('spock')
    end
  end

  def add_to_history(opponent_move)
    @opponents_moves << opponent_move
    @moves << move
  end
end

class Human < Player
  def prompt_name
    puts MESSAGES['one_through']
    puts MESSAGES['choose_move']
  end

  def choose
    choice = nil
    loop do
      prompt_name
      choice = gets.chomp.to_i

      break if Move::VALUES.keys.include? choice
      puts MESSAGES['invalid_move']
    end
    self.move = set_type(Move::VALUES[choice])
  end

  def set_name
    name = ""
    loop do
      puts MESSAGES['prompt_name']
      name = gets.chomp.strip

      break unless name.empty?
      puts MESSAGES['invalid_name']
    end
    self.name = name
    system('clear') || system('cls')
  end
end

class Computer < Player
  attr_accessor :name

  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Dolores'].sample
  end

  def opponents_achilles(move_type)
    Move::LOSING_HAND[move_type]
  end

  def smart_move
    return Move::VALUES.values.sample if self.opponents_moves.empty?

    most_occuring = find_most_occuring.value

    (Move::VALUES.values + opponents_achilles(most_occuring)).sample
  end

  def find_most_occuring
    occurances_hash = @opponents_moves.each_with_object(Hash.new(0)) do |move, result|
      result[move.value] += 1
    end

    most_frequent = occurances_hash.sort_by { |move, occurance| occurance}[-1][0]
    Move.new(most_frequent)
  end

  def choose
    self.move = set_type(smart_move)
  end
end

class Move
  attr_reader :value, :type

  WINNING_HAND = { 'rock' => %w(lizard scissors), 'paper' => %w(rock spock),
                   'scissors' => %w(lizard paper), 'lizard' => %w(spock paper),
                   'spock' => %w(rock scissors) }.freeze

  LOSING_HAND = { 'rock' => %w(spock paper), 'paper' => %w(scissors lizard),
                   'scissors' => %w(rock spock), 'lizard' => %w(rock scissors),
                   'spock' => %w(lizard paper) }.freeze

  VALUES = {1 => 'rock', 2 => 'paper', 3 => 'scissors', 4 => 'lizard', 5 => 'spock'}.freeze

  def initialize(value)
    @value = value
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
    WINNING_HAND[value].include?(other_move.value)
  end

  def <(other_move)
    LOSING_HAND[value].include?(other_move.value)
  end
end

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

class Paper < Move
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
 end


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

class Lizard < Move
  def sprite 
    [ "               LIZARD", 
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

class RPSGame
  attr_accessor :human, :computer
  include DisplayableSprites
  
  require 'yaml'
  MESSAGES = YAML.load_file('rpsls_oop_messages.yml')

  BEST_TO = 5

  def initialize
    system 'clear'
    display_rules
    @human = Human.new
    @computer = Computer.new
  end

  def winner
    if human.move > computer.move
      human
    elsif computer.move > human.move
      computer
    else
      nil
    end
  end

  def loser
    if human.move < computer.move
      human
    elsif computer.move < human.move
      computer
    else
      nil
    end
  end

  def tie?
    @human.move.value == @computer.move.value
  end

  def display_welcome_message
    puts MESSAGES['greeting']
  end

  def display_rules
    MESSAGES['rules'].each { |_, rule| puts rule}
    puts format(MESSAGES['first_to'], wins_needed: BEST_TO)
    puts MESSAGES['understand']
    print MESSAGES['press_enter']
    gets
    clear_screen
  end

  def display_goodbye_message
    puts MESSAGES['farewell']
  end

  def display_winning_sprite
    num_spaces = winner.move.sprite[-1].length - winner.move.value.length

    winner.move.sprite[1..-1].each { |line| puts line}
    puts(' ' * num_spaces + "WINS!\n\n\n")
  end

  def winner_width
    winner.move.sprite.max_by(&:length).length
  end

  def display_winner
    display_winning_sprite
    puts MESSAGES[winner.move.value][loser.move.value]
    display_score
  end

  def display_results
    if tie?
      display_tie
      return
    end

    display_winner
  end

  def display_moves
    display_left(@human.move.sprite)
    display_center("vs")
    display_right(@computer.move.sprite)
  end

  def adjust_score
    if human.move > computer.move
      human.score += 1
    elsif human.move < computer.move
      computer.score += 1
    else
      return
    end
  end

  def clear_scores
    human.score = 0
    computer.score = 0
  end

  def display_score
   if winner.class == Human
     puts "#{human.name} now has #{human.score}. #{computer.name} has #{computer.score}"
   else
     puts "#{human.name} has #{human.score}. #{computer.name} now has #{computer.score}"
   end
  end

  def play_again?
    choice = nil

    loop do
      puts MESSAGES['another_game']
      choice = gets.chomp
      break if ['y', 'n'].include? choice
      puts MESSAGES['y_or_n']
    end

    return true if choice == 'y'
    false
  end

  def congrats_message
    puts format(MESSAGES['winner_congrats'], the_winner: winner.name, best_to: BEST_TO)
  end

  def reset
    sleep 2.5
    clear_screen
  end

  def players_choose
    human.choose
    computer.choose
  end

  def add_players_history
    human.add_to_history(computer.move)
    computer.add_to_history(human.move)
  end

  def winner?
    human.score == BEST_TO || computer.score == BEST_TO
  end

  def win_by
    (computer.score - human.score).abs
  end

  def message_to_player
    if winner.class == Human
      puts MESSAGES['player_win_comment'][win_by]
    else
      puts MESSAGES['computer_win_comment'][win_by]
    end
  end

  def play
    loop do
      players_choose
      add_players_history

      display_opponents
      pow_animation
      adjust_score
      display_results
        
      reset

      if winner?
        congrats_message
        message_to_player
        clear_scores
        break unless play_again?
      end
    end

    display_goodbye_message
  end
end

RPSGame.new.play