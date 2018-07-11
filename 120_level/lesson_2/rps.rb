# Rock, Paper, Scissors is a two-player game where each player chooses
# one of three possible moves: rock, paper, or scissors. The chosen moves
# will then be compared to see who wins, according to the following rules:

# - rock beats scissors
# - scissors beats paper
# - paper beats rock

# If the players chose the same move, then it's a tie.

# Player
#  - choose
# Move
# Rule

# - compare

module Displayable
  def prompt(string)
    puts "=> #{string}"
  end
end

module Choice
  include Displayable
  @@MOVES = %w(rock paper scissors)

  def choose
    choice = ''
    if player_type == 'human'
      loop do
        prompt "Choose Rock, Paper, or Scissors"
        choice = gets.chomp.downcase
        break if @@MOVES.include? choice
      end
      self.hand = choice
    else
      self.hand = @@MOVES.sample
    end
  end

  def choose_name
    prompt "What is your name"
    @name = gets.chomp.capitalize
  end
end

class Player
  include Choice

  attr_accessor :hand, :player_type, :name

  def initialize(player_type)
    @player_type = player_type
  end
end

class Move
  def initialize

  end
end

class Rule
  @@WINNING_HANDS = {"rock" => "scissors",
                     "paper" => "rock",
                     "scissors" => "paper"}

  def self.compare(move1, move2)
    if move1 == move2
      0
    elsif @@WINNING_HANDS[move1] == move2
      1
    else
      -1
    end
  end
end

class RPSGame 
  @@QUIT_WORDS = %w(y yes)

  attr_accessor :human, :computer
  include Displayable

  def initialize
    @human = Player.new("human")
    @computer = Player.new("computer")
  end

  def play
    display_welcome_message
    human.choose_name
    loop do
      human.choose
      computer.choose
      display_winner

      if play_again?
        system 'clear'
        next
      else
        display_goodbye_message
        return
      end
    end
  end

  def play_again?
    answer = ''

    loop do
      prompt "would you like to play again? yes/no"
      answer = gets.chomp.downcase

      break if %w(y yes n no).include? answer
      prompt "type yes or no"
    end

    %w(y yes).include?(answer) ? true : false
  end

  def display_welcome_message
    prompt "Welcome to Rock, Paper, Scissors!"
  end

  def display_winner
    result = Rule.compare(@human.hand, @computer.hand)

    case result
    when 1  then prompt "#{human.name}, you have #{human.hand}. The computer has #{computer.hand}. \n   #{human.name} wins!"
    when -1 then prompt "The computer has #{computer.hand}. #{human.name}, you have #{human.hand}. \n   The computer wins!"
    when 0  then prompt "It's a tie!"
    end
  end

  def display_goodbye_message
    prompt "Have a nice day!"
  end
end

RPSGame.new.play