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

class Participant
  attr_accessor :cards, :name, :hand

  def hit

  end

  def stay

  end

  def busted?

  end

  def total

  end

  def sum_of_cards(cards)
    binding.pry
  end
end

class Player < Participant
  def initialize

  end
end

class Dealer < Participant
  def deal

  end
end

class Card
  attr_accessor :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
end

class Deck
  attr_accessor :deck

  def initialize
    @deck = new_deck.shuffle
  end

  def new_deck
    deck_makeup = %w(2 3 4 5 6 7 8 9 10 J Q K A).product ["\u2662", "\u2661", "\u2664", "\u2667"]

    @deck = deck_makeup.each_with_object([]) do |(rank, suit), deck|
      deck << Card.new(rank, suit)
    end
  end

  def deal
    2.times.with_object([]) do |_, hand|
      hand << deck.pop
    end
  end
end

module DisplayableCards
  def create_card(card)
    if card.rank == ' '
      ['@==========@',
       "|//////////|",
       '|//////////|',
       '|//////////|',
       '|//////////|',
       '|//////////|',
       '|//////////|',
       "|//////////|",
       '@==========@']
  
    elsif card.rank.length == 1
      ['@==========@',
       "| #{card.rank}        |",
       '|          |',
       '|          |',
       "|    #{card.suit}     |",
       '|          |',
       '|          |',
       "|        #{card.rank} |",
       '@==========@']
  
    else
      # double char card
      ['@==========@',
       "| #{card.rank}       |",
       '|          |',
       '|          |',
       "|    #{card.suit}     |",
       '|          |',
       '|          |',
       "|       #{card.rank} |",
       '@==========@']
    end
end

  def create_display_cards(participant)
    display_cards = []
    participant.hand.each { |card| display_cards << create_card(card) }
    create_row_cards display_cards
  end
  
  def create_row_cards(cards)
    return_arr = []
    count = 0
    loop do
      result = ''
      cards.each do |card|
        result += card[count]
      end
      return_arr << result
      count += 1
      break if count == 9 # 9 is the height of the individual card
    end
    return_arr
  end

  def display_hands
    dealer.hand.length.times do |index|
      system 'clear'
      puts 'Dealers cards: '
      puts create_display_cards dealer
      # puts "Dealer count: #{dealer.sum_of_cards(dealer.hand[0..index])}\n\n"
      puts 'YOUR CARDS'
      puts create_display_cards player
      # puts "Your count: #{player_count}\n\n"
      index == 0 ? sleep(0.66) : sleep(1.0)
    end
  end
end

class Game
  attr_accessor :deck, :player, :dealer

  include DisplayableCards

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def deal_cards
    player.hand = deck.deal
    dealer.hand = deck.deal
  end

  def show_initial_cards
    display_hands
  end

  def play
    deal_cards
    show_initial_cards
    # player_turn
    # dealer_turn
    # show_result
  end
end

twenty_one = Game.new

twenty_one.play

binding.pry