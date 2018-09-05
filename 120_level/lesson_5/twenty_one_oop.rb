# Twenty-one is a game where from a shuffled deck, 2 cards are dealt face up to the player, and 2 cards are dealt to the dealer, one face up, and one face down.  
# Then the player has options to hit or stay.  If the player or dealer surpasses the score of 21 they bust.  
# The dealer must continue to hit until they reach a minium score of 17.  Once they reach 17 or above the must stay.  
# The scores are compared and a winner is declared. the winner is awarded a point, the first player to a score of 5 wins

# Nouns:
#   game
#   player
#   cards
#   deck
#   dealer
#   score
#   participant
# Verbs:
#   deal
#   shuffle
#   hit
#   stay
#   bust

# player
#   -cards
# Dealer
#   -hit?
#   -stay?
#   -deal
# Deck
#   -deal
# Card
#   -rank
#   -suit
# Participant
#   -hit
#   -stay
#   -busted?
# Game
#   play
require 'pry'

class Player
  def initialize

  end
end

class Dealer
  def deal

  end
end

class Deck
  def deal

  end
end

class Card
  attr_accessor :rank, :suit
end

class Participant
  attr_accessor :cards, :name

  def hit

  end

  def stay

  end

  def busted?

  end

  def total

  end
end

class Game
  def play
    binding.pry
  end
end

twenty_one = Game.new

twenty_one.play