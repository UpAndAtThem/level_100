FACE_CARD_VALUE = { 'J' => 10, 'Q' => 10, 'K' => 10 }.freeze

def initialize_deck
  deck = []
  suits = %w(c d h s)
  value = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  suits.map do |suit|
    value.map { |val| deck << [val, suit] }
  end
  deck
end

def greeting
  system 'clear'
  puts '             Welcome to 21'
  puts '------------------- --------------------'
  puts '| A               | | K                |'
  puts '|                 | |                  |'
  puts '|                 | |        WWW  |    |'
  puts '|        _        | |        ( )  |    |'
  puts '|       ( )       | |       --|-- t    |'
  puts '|       /_\\       | |         |        |'
  puts '|                 | |        / \       |'
  puts '|                 | |                  |'
  puts '|                 | |                  |'
  puts '|                 | |                  |'
  puts '|               A | |                K |'
  puts '------------------- --------------------'

  sleep 0.5
end

def deal_cards(deck)
  player_cards = []
  computer_cards = []
  1.upto(2) do |_|
    player_cards << deck.sample
    computer_cards << deck.sample
  end
  remove_cards deck, player_cards, computer_cards
  return player_cards, computer_cards
end

def remove_cards(deck, player_cards, computer_cards)
  [player_cards, computer_cards].each do |set_cards|
    set_cards.each do |card|
      deck.delete(card)
    end
  end
end

def hit(deck, cards)
  new_card = deck.sample
  cards << new_card
  deck.delete(new_card)
end

def count_cards(cards)
  count = 0
  count = add_cards cards, count
  cards.each { |card| count -= 10 if card[0] == 'A' && count > 21 }
  count
end

def add_cards(cards, count)
  cards.each do |card|
    if card[0].to_i != 0
      count += card[0].to_i
    elsif card[0] == 'A'
      count += 11
    else
      count += FACE_CARD_VALUE[card[0]]
    end
  end
  count
end

def display_result(computer_cards, player_cards, computer_count, player_count)
  display_cards computer_cards, player_cards
  result = win_lose_tie player_count, computer_count
  puts "\nYou have #{player_count}, and the dealer has #{computer_count} you #{result}\n\n\n"
end

def display_cards(computer_cards, player_cards)
  computer_cards.length.times do |index|
    system 'clear'
    puts "Your count: #{player_cards}\n\n"
    print 'Players cards: '
    p player_cards
    print 'Dealers cards: '
    p computer_cards[0..index]
    puts "\ndealer count: #{count_cards (computer_cards[0..index])}"
    sleep 1.3
  end
end

def win_lose_tie(player_count, computer_count)
  win_lose_tie = player_count > computer_count && player_count <= 21 || computer_count > 21 && player_count <= 21 ? 'win!' : 'lose!'
  win_lose_tie = 'tie' if player_count == computer_count
  win_lose_tie
end

def hit_stay_prompt(player_cards, computer_cards, player_count)
  p player_cards
  approp_article = computer_cards[0][0] == 'A' ? 'an' : 'a'
  puts "\nYou have #{player_count}. The dealer's showing #{approp_article} #{computer_cards[0][0]}. Hit or stay?"
end

computer_cards = []
player_cards = []
player_count = 0
computer_count = 0

loop do
  greeting
  sleep 2
  deck = initialize_deck
  player_cards, computer_cards = deal_cards deck
  loop do
    player_count = count_cards player_cards
    computer_count = count_cards computer_cards
    while player_count < 21
      system 'clear'
      hit_stay_prompt player_cards, computer_cards, player_count
      answer = gets.chomp
      break if answer == 'stay'
      hit deck, player_cards
      player_count = count_cards player_cards
    end
    while player_count < 22
      hit(deck, computer_cards) if computer_count < 17
      computer_count = count_cards computer_cards
      break if computer_count >= 17
    end
    display_result computer_cards, player_cards, computer_count, player_count
    break if computer_count >= 17 || player_count > 21
  end
  break
end
