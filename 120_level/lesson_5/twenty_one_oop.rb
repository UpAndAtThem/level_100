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
  attr_accessor :cards, :name, :hand, :is_hitting

  def initialize
    @is_hitting = false
  end

  def total
    binding.pry
  end

  def hit?
    is_hitting == true
  end

  def hit(deck)
    hand << deck.deal_card
  end

  def stay?
    is_hitting == false
  end

  def busted?

  end

  def total

  end
end

class Player < Participant

end

class Dealer < Participant
  def deal

  end

  def mask
    dup_hand = hand.dup
    dup_hand[1] = Card.new(' ', ' ')
    dup_hand
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

  def deal_card
    deck.pop
  end
end

module DisplayableCards
  def create_card(card)
    if card.rank == ' '
      ['@==========@',
       '|//////////|',
       '|//////////|',
       '|//////////|',
       '|//////////|',
       '|//////////|',
       '|//////////|',
       '|//////////|',
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

  def display_cards(hand)
    display_cards = []
    hand.each { |card| display_cards << create_card(card) }
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
      break if count == cards.first.count
    end
    return_arr
  end

  def display_hands
    # dealer.hand.length.times do |index|
      system 'clear'
      puts 'Dealers cards: '
      puts display_cards dealer.mask
      # puts "Dealer count: #{dealer.sum_of_cards(dealer.hand[0..index])}\n\n"
      puts 'YOUR CARDS'
      puts display_cards player.hand
      # puts "Your count: #{player_count}\n\n"
      # index.zero? ? sleep(0.66) : sleep(1.0)
    # end
  end
end

# Game class
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

  def show_cards
    display_hands
  end

  def hit_or_stay
    loop do
      print "Do you want to hit or stay? :"
      response = gets.chomp

      if %w(hit stay).include?(response.downcase)
        (response == 'hit') ? player.is_hitting = true : player.is_hitting = false
        break
      end
    end
  end

  def player_turn
    loop do
      show_cards
      hit_or_stay
      player.hit(deck) if player.hit?
      return if player.stay?
      break if player.total
    end
  end

  def dealer_turn

  end

  def play
    deal_cards
    show_cards
    player_turn
    # dealer_turn
    # show_result
  end
end

twenty_one = Game.new

twenty_one.play
