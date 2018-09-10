# Twenty-one is a game where from a shuffled deck, 2 cards are dealt
# face up to the player, and 2 cards are dealt to the dealer, one face
# up, and one face down.
# Then the player has options to hit or stay.  If the player or dealer
# surpasses the score of 21 they bust.
# The dealer must continue to hit until they reach a minium score of 17.
# Once they reach 17 or above the must stay.
# The scores are compared and a winner is declared.
# the winner is awarded a point, the first player to a score of 5 wins

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

# Participant class
class Participant
  attr_accessor :cards, :name, :hand, :wins
  def initialize
    @hitting = false
    @wins = 0
  end

  def num_aces
    hand.count { |card| card.rank == 'A' }
  end

  def subract_aces(total_count)
    num_aces.times do |_|
      total_count -= 10
      return total_count if total_count <= 21
    end
    total_count
  end

  def total(hand = self.hand)
    total_amount = hand.reduce(0) do |memo, card|
      memo + Card::VALUES[card.rank]
    end

    if total_amount > 21 && num_aces > 0
      subract_aces total_amount
    else
      total_amount
    end
  end

  def hitting?
    hitting == true
  end

  def staying?
    !hitting?
  end

  def hit(shoe)
    hand << shoe.deal_card
  end

  def busted?
    total > 21
  end
end

# Player class
class Player < Participant
  attr_reader :hitting

  def end_turn?
    staying? || busted?
  end

  def hitting=(response)
    @hitting = response == 'hit' ? true : false
  end
end

# Dealer class
class Dealer < Participant
  def initialize
    super
    @name = ['Split Freeley', 'Tina \'Double Trouble\' Gracey',
             'Charlie Shoe', 'Push Williams'].sample
  end

  def mask
    dup_hand = hand.dup
    dup_hand[1] = Card.new('masked', ' ')
    dup_hand
  end
end

# Card class
class Card
  attr_accessor :rank, :suit

  VALUES = { '2' => 2, '3' => 3, '4' => 4,
             '5' => 5, '6' => 6, '7' => 7,
             '8' => 8, '9' => 9, '10' => 10,
             'J' => 10, 'Q' => 10, 'K' => 10,
             'A' => 11, 'masked' => 0 }.freeze

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
end

# Deck class
class Deck
  attr_accessor :cards

  def initialize
    @cards = new_deck.shuffle
  end

  def new_deck
    ranks = %w(2 3 4 5 6 7 8 9 10 J Q K A)
    suits = ["\u2662", "\u2661", "\u2664", "\u2667"]
    deck_makeup = ranks.product suits

    deck_makeup.each_with_object([]) do |(rank, suit), cards|
      cards << Card.new(rank, suit)
    end
  end

  def deal
    2.times.with_object([]) do |_, hand|
      hand << cards.pop
    end
  end

  def deal_card
    cards.pop
  end
end

# Shoe class
class Shoe < Deck
  def initialize(num_decks)
    @cards = num_decks.times.with_object([]) do |_, shoe|
      shoe << Deck.new.cards
    end.flatten
  end
end

# DisplayableCards module
module DisplayableCards
  # rubocop:disable MethodLength
  def create_card(card)
    if card.rank == 'masked'
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
  # rubocop:enable MethodLength

  def display_greeting
    system 'clear'
    puts 'Welcome to Twenty-one.'
    puts "\nAttempt to win against the dealer by getting a count"
    puts 'as close to 21 as possible, without going over.'
    puts "\nNumbered cards are worth their stated value."
    puts 'Face cards are worth 10, and aces are worth 1 or 11.'
    puts "\nFirst participant to #{Game::WINS_NEEDED} wins is the champ."
    print "\nPress enter to continue:"
    gets.chomp
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
      cards.each { |card| result += card[count] }
      return_arr << result
      count += 1

      break if count == cards.first.count
    end
    return_arr
  end

  def press_enter_prompt
    print "\nPRESS ENTER TO CONTINUE:"
    gets.chomp
  end

  def display_result
    puts win_lose_tie_message

    if wins_needed_reached?
      puts "\nCongratulations to our overall winner, #{winner_name}!"
    end

    puts "\nPlayer wins: #{player.wins} \nDealer wins: #{dealer.wins}"
    press_enter_prompt unless wins_needed_reached?
  end

  def display_farewell_message
    puts "\nThank you for playing 21! Goodbye"
  end

  def display_hands(dealer_hand)
    system 'clear'
    puts 'DEALERS CARDS: '
    puts display_cards dealer_hand
    puts "Dealer count: #{dealer.total dealer_hand}\n\n"
    puts 'YOUR CARDS:'
    puts display_cards player.hand
    puts "Your count: #{player.total}\n\n"
  end

  def win_lose_tie_message
    if tie?
      'It\'s a tie!'
    elsif player_won?
      'You won!'
    else
      'The dealer won!'
    end
  end
end

# Game class
class Game
  attr_accessor :shoe, :player, :dealer

  WINS_NEEDED = 3
  NUM_DECKS = 3

  include DisplayableCards

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @shoe = Shoe.new NUM_DECKS
  end

  def deal_cards
    player.hand = shoe.deal
    dealer.hand = shoe.deal
  end

  def hit_or_stay
    loop do
      print 'Do you want to hit or stay? :'
      response = gets.chomp.downcase

      if %w(hit stay).include?(response)
        player.hitting = response
        break
      end
    end
  end

  def player_turn
    loop do
      display_hands dealer.mask
      hit_or_stay
      player.hit(shoe) if player.hitting?
      sleep 0.25

      return if player.end_turn?
    end
  end

  def dealer_turn
    loop do
      display_hands dealer.hand
      sleep 1.25

      dealer.total >= 17 || player.busted? ? return : dealer.hit(shoe)
    end
  end

  def tie?
    player.total == dealer.total
  end

  def player_won?
    (dealer.busted? && !player.busted?) ||
      (player.total > dealer.total && !player.busted?)
  end

  def wins_needed_reached?
    [player.wins, dealer.wins].include? WINS_NEEDED
  end

  def winner_name
    player.wins == Game::WINS_NEEDED ? 'you' : dealer.name
  end

  def adjust_score
    if tie?
      nil
    elsif player_won?
      player.wins += 1
    else
      dealer.wins += 1
    end
  end

  def play_again?
    loop do
      puts "\nWould you like to play again 'yes' or 'no'?"
      response = gets.chomp.downcase

      return response == 'yes' if %w(yes no).include? response
    end
  end

  def new_shoe
    @shoe = Shoe.new NUM_DECKS
  end

  def low_cards?
    shoe.cards.count < 20
  end

  def reset_round
    player.wins = 0
    dealer.wins = 0
    player.hand = []
    dealer.hand = []
  end

  def game_loop
    loop do
      deal_cards
      player_turn
      dealer_turn
      adjust_score
      display_result

      new_shoe if low_cards?

      break if wins_needed_reached?
    end
  end

  def play
    display_greeting
    loop do
      game_loop
      break unless play_again?
      reset_round
    end
    display_farewell_message
  end
end

twenty_one = Game.new
twenty_one.play

