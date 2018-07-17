require 'pry'

class Player
  attr_accessor :move, :name, :score
  attr_reader :history

  def initialize
    set_name
    @score = 0
    @history = []
  end

  def history(move)
    @history << move
  end
end

class Human < Player
  def choose
    choice = nil
    loop do
      puts "Choose rock, paper, scissors, lizard, or spock"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end

    self.move = Move.new(choice)
    self.history move
  end

  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must have input"
    end
    self.name = n
  end
end

class Computer < Player
  attr_accessor :name

  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Dolores'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
    self.history move
  end
end

class Move
  attr_reader :value

  WINNING_HAND = { 'rock' => %w(lizard scissors), 'paper' => %w(rock spock),
                   'scissors' => %w(lizard paper), 'lizard' => %w(spock paper),
                   'spock' => %w(rock scissors) }.freeze

  LOSING_HAND = { 'rock' => %w(spock paper), 'paper' => %w(scissors lizard),
                   'scissors' => %w(rock spock), 'lizard' => %w(rock scissors),
                   'spock' => %w(lizard paper) }.freeze

  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock'].freeze

  def initialize
    @history = []
  end

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

  end
end

class Paper < Move

  def sprite

  end
end

class Scissors < Move
  def sprite 

  end
end

class Lizard < Move
  def sprite

  end
end

class Spock < Move
  def sprite

  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    display_welcome_message
    @human = Human.new
    @computer = Computer.new()
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors!"
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_moves
    puts "#{human.name} chose #{human.move.value}."
    puts "#{computer.name} chose #{computer.move.value}"
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

  def display_score
    puts "You have #{human.score}.  The Computer has #{computer.score}"
  end

  def play_again?
    choice = nil

    loop do
      puts 'would you like to play again? (y/n)'
      choice = gets.chomp
      break if ['y', 'n'].include? choice
      puts "enter 'y' or 'n'"
    end

    return true if choice == 'y'
    false
  end

  def congrats_message
    winner = human.score > computer.score ? human : computer
    puts "Congratulations, #{winner.name}! You were first to score 10 points"
  end

  def reset
    sleep 2.5
    system 'clear'
  end

  def play
    loop do
      human.choose
      computer.choose

      display_moves
      display_winner
      adjust_score
      display_score
      reset

      if human.score == 10 || computer.score == 10
        congrats_message
        break unless play_again?
      end
    end

    display_goodbye_message
  end
end

class Rule
  def initialize
    # not sure what the "state" of a rule object should be
  end
end

# not sure where "compare" goes yet
def compare(move1, move2); end

RPSGame.new.play




# module DisplayMove
#   lizard = [ "               LIZARD\n\n", 
#            "                     )/_",
#            "              _.--..---\"-,--c_",
#            "         \\L..'           ._O__)_",
#            ",-.     _.+  _  \\..--( /",
#            " `\\.-''__.-' \\ (     \\_ ",     
#            "   `'''       `\\__   /\\",
#            "               ')",
#            "               \n\nLIZARD"]

#   spock = ["             SPOCK",
#            '               .',
#            '              .:.',
#            '             .:::.',
#            '             .:::::.',
#            '        ***.:::::::.***',
#            '    *******.:::::::::.*******',       
#            '  ********.:::::::::::.********',    
#            ' ********.:::::::::::::.********',   
#            ' *******.::::::\'***`::::.*******',    
#            ' ******.::::\'*********`::.******',    
#            ' ****.:::\'*************`:.****',
#            '   *.::\'*****************`.*',
#            '    .:\'  ***************    .',
#            "  .           SPOCK"]
          
#   paper =  ['      PAPER',
#             ' _______________',
#             '|  ------------ |',
#             '| ------------- |',
#             '| -- ---------- |',
#             '| ------  ----- |',
#             '| ------------- |',
#             '| ------------- |',
#             '| ----------    |',
#             '|  ------------ |',
#             '| ------------- |',
#             '| ------ -----  |',
#             '| ------------- |',
#             '|_______________|',
#             '      PAPER']
  
       
  
#   scissors =  ['                SCISSORS',
#                ' ,--.',
#                '(    )____ ___________________________',
#                ' `--"---,-"  ,.   --------------------`-.',
#                ' ,--.---`-.__`"__|_______________________`>',
#                '(    )',
#                ' `--\'',
#                '                SCISSORS']
  
  
#   rock = ["                       ROCK\n",
#           '                          _',
#           '                / -` -`\ -_ /.  /^./\__    ',
#           '    _        .--"\\ _ \\__/.      \\ /    \\',  
#           '   / \\_    _/ ^      \\/  __  :"   /\\/\\  /\\ ',
#           '  ;-_    \\  /    ."   _/  /  \\   ^ /    \\/', 
#           ' /\\/\\  /\\/ :" __  ^/  ^/    `--./."  ^  `-.',
#           '/    \\/  \\  _/  \\-" __/." ^ _   \\_   ."\'',
#           '  .-   `. \\/     \\ / -.   _/ \\ -. `_/   \\ /',
#           '`-.__ ^   / .-".--"    . /    `--./ .-"  `-',
#           '                      ROCK']
    
  
#   def vs_display(player_sprite, computer_sprite, vs)
#     display_left(player_sprite)
#     display_center(vs)
#     display_right(computer_sprite)
#   end
  
#   def display_left(player_sprite)
#     player_sprite[1..-1].each { |row| puts row}
#   end
  
#   def display_center(vs, width = 100)
#     puts(vs.center(width))
#   end
  
#   def display_right(computer_sprite, width = 100)
#     computer_sprite[0..-2].each { |row| puts "#{" " * 70} " + row}
#   end
# end