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
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}"

    case human.move
    when 'rock'
      puts "It's a tie!" if computer.move == 'rock'
      puts "#{human.name} won!" if computer.move == 'scissors'
      puts "#{computer.name} won!" if computer.move == 'paper'
    when 'paper'
      puts "It's a tie!" if computer.move == 'paper'
      puts "#{human.name} won!" if computer.move == 'rock'
      puts "#{computer.name} won!" if computer.move == 'scissors'
    when 'scissors'
      puts "It's a tie!" if computer.move == 'scissors'
      puts "#{human.name} won!" if computer.move == 'paper'
      puts "#{computer.name} won!" if computer.move == 'rock'
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
        break if %w(rock paper scissors).include? choice
        puts "Sorry, invalid choice."
      end

    self.move = choice
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
    self.move = %w(rock paper scissors).sample
  end
end

class Move
  def initialize
    # seems like we need something to keep track
    # of the choice... a move object can be "paper", "rock" or "scissors"
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