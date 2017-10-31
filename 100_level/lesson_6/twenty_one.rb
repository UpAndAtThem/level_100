FACE_CARD_VALUE = { 'J' => 10, 'Q' => 10, 'K' => 10 }.freeze
DEALER_STAY_VAL = 17
BUST_VAL = 21

def initialize_deck
  deck = []
  suits = %w(c d h s)
  value = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  suits.map do |suit|
    value.map { |val| deck << [val, suit] }
  end
  deck
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
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

  sleep 2.5
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

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
  cards.each { |card| count -= 10 if card[0] == 'A' && count > BUST_VAL }
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
  display_cards computer_cards, player_cards, player_count
  result = win_lose_tie player_count, computer_count
  print "\nYou have #{player_count}, and the dealer has"
  print " #{computer_count} you #{result}\n\n\n"
end

def display_cards(computer_cards, player_cards, player_count)
  computer_cards.length.times do |index|
    system 'clear'
    puts "Your count: #{player_count}\n\n"
    print 'Players cards: '
    p player_cards
    print 'Dealers cards: '
    p computer_cards[0..index]
    puts "\ndealer count: #{count_cards(computer_cards[0..index])}"
    sleep 1.3
  end
end

def win_lose_tie(player_count, computer_count)
  player_greater = player_count > computer_count
  player_safe = !busted?(player_count)
  cmptr_bust = busted? computer_count

  win_lose_tie = if player_greater && player_safe || cmptr_bust && player_safe
                   'win!'
                 else
                   'lose!'
                 end

  win_lose_tie = 'tie!' if player_count == computer_count
  win_lose_tie
end

def hit_stay_prompt(player_cards, computer_cards, player_count)
  p player_cards
  approp_article = %w(A 8).include?(computer_cards[0][0]) ? 'an' : 'a'
  print "\nYou have #{player_count}. The dealer's showing #{approp_article}"
  print " #{computer_cards[0][0]}. Hit or stay?: "
end

def busted?(count)
  count > BUST_VAL
end

def dealer_hit?(count)
  count < DEALER_STAY_VAL
end

def salutation(player_count, computer_count, player_win_total, comp_win_total)
  system 'clear'
  print 'Thank you for playing 21. The final score is'
  print "\n\nPlayer: #{player_win_total}\n"
  print "Computer: #{comp_win_total}\n"
  print "\nyou #{win_lose_tie(player_count, computer_count)}\n"
end

# def win?(player_count, computer_count)
#   player_greater = player_count > computer_count
#   player_safe = !busted?(player_count)
#   cmptr_bust = busted? computer_count
#   win = if player_greater && player_safe || cmptr_bust && player_safe
#                    true
#                  else
#                    false
#                  end

#   win = false if player_count == computer_count
#   win
# end

computer_cards = []
player_cards = []
player_count = 0
computer_count = 0
player_win_total = 0
comp_win_total = 0

greeting
loop do
  deck = initialize_deck
  player_cards, computer_cards = deal_cards deck
  loop do
    player_count = count_cards player_cards
    computer_count = count_cards computer_cards
    until busted? player_count
      system 'clear'
      hit_stay_prompt player_cards, computer_cards, player_count
      answer = gets.chomp
      break if answer == 'stay'
      hit deck, player_cards
      player_count = count_cards player_cards
    end
    while !busted?(player_count) && dealer_hit?(computer_count)
      hit(deck, computer_cards)
      computer_count = count_cards computer_cards
      break unless dealer_hit?(computer_count)
    end
    display_result computer_cards, player_cards, computer_count, player_count
    player_win = win_lose_tie(player_count, computer_count)
    player_win_total += 1 if player_win == 'win!'
    comp_win_total += 1 if player_win == 'lose!'
    break if !dealer_hit?(computer_count) || busted?(player_count)
  end
  break if comp_win_total == 3 || player_win_total == 3
end

salutation player_count, computer_count, player_win_total, comp_win_total
