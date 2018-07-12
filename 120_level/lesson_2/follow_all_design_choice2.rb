require 'pry'
class RPSGame
  attr_accessor :human, :computer

  def initialize
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
    puts "#{human.name} chose #{human.move.value}."
    puts "#{computer.name} chose #{computer.move.value}"

    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    choice = nil

    loop do
      puts "would you like to play again? (y/n)"
      choice = gets.chomp
      break if %w(y n).include? choice 
      puts "enter 'y' or 'n'"
    end

    return true if choice == 'y'
    return false
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose

      display_winner

      break unless play_again?
    end

    display_goodbye_message
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def choose
    choice = nil
      loop do
        puts "Choose rock, paper, or scissors"
        choice = gets.chomp
        break if Move::VALUES.include? choice
        puts "Sorry, invalid choice."
      end

    self.move = Move.new(choice)
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
  end
end

class Move
  attr_reader :value

  VALUES = ['rock', 'paper', 'scissors']

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

  def >(other_move)
    case @value
    when 'rock'
      return true if other_move.scissors?
      return false
    when 'paper'
      return true if other_move.rock?
      return false
    when 'scissors'
      return true if other_move.paper?
      return false
    end
  end

  def <(other_move)
    case @value
    when 'rock'
      return true if other_move.paper?
      return false
    when 'paper'
      return true if other_move.scissors?
      return false
    when 'scissors'
      return true if other_move.rock?
      return false
    end
  end
end

class Rule
  def initialize
    # not sure what the "state" of a rule object should be
  end
end

# not sure where "compare" goes yet
def compare(move1, move2)

end

RPSGame.new.play