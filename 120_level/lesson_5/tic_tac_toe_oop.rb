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

class Board
  def initialize

  end
end

class Player
  def initialize
  end
end

class Computer
  def initialize
  end
end

class Square
  def initialize
  end
end

class TTTGame
  def initialize
    @player = Player.new
    @computer = Computer.new
    @board = Board.new
  end

  def greeting
    puts "Welcome to Tic Tac Toe"
  end

  def play
    greeting
    # ... Orchestration Engine ...
  end
end

game = TTTGame.new
game.play
