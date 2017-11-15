FACE_CARD_VALUE = { 'J' => 10, 'Q' => 10, 'K' => 10 }.freeze
DEALER_STAY_VAL = 17
BUST_VAL = 21
BEST_TO = 5

require 'pry'

def prompt(message)
  p "=> #{message}"
  sleep 1.5
end

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
  puts "             Welcome to #{BUST_VAL}"
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
  cards = []
  2.times do |index|
    cards << deck.sample
    remove_card deck, cards[index]
  end
  cards
end

def remove_card(deck, card)
  deck.delete(card)
end

def hit(deck, cards)
  new_card = deck.sample
  cards << new_card
  remove_card deck, new_card
end

def count_cards(cards)
  count = 0
  count = add_cards cards, count
  cards.each { |card| count -= 10 if card[0] == 'A' && count > BUST_VAL }
  count
end

def add_cards(cards, count)
  cards.each do |card|
    count += if card[0].to_i != 0
               card[0].to_i
             elsif card[0] == 'A'
               11
             else
               FACE_CARD_VALUE[card[0]]
             end
  end
  count
end

def create_card(card)
  return single_char_card =
    ['@==========@',
     "| #{card[0]}        |",
     '|          |',
     '|          |',
     '|          |',
     '|          |',
     "|        #{card[0]} |",
     '@==========@'] if card[0].to_s.size == 1

    # double char card
    ['@==========@ ',
     "| #{card[0]}       | ",
     '|          | ',
     '|          | ',
     '|          | ',
     '|          | ',
     "|       #{card[0]} | ",
     '@==========@ ']
end

def create_display_cards(cards)
  display_cards = []
  cards.each do |crd|
    card = create_card crd
    display_cards << card
  end
  manipulate_display_cards display_cards, display_cards.size
end

def manipulate_display_cards(cards, num_desired)
  crds = cards[0..num_desired]
  return_arr = []
  count = 0
  loop do
    result = ''
    crds.each do |card|
      result += card[count]
    end
    return_arr << result
    count += 1
    break if count == 8
  end
  return_arr
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
    puts 'Dealers cards: '
    puts create_display_cards computer_cards[0..index]
    puts "Dealer count: #{count_cards(computer_cards[0..index])}\n\n"
    puts 'YOUR CARDS'
    puts create_display_cards player_cards
    puts "Your count: #{player_count}\n\n"
    sleep 1.3
  end
end

def win_lose_tie(player_count, computer_count)
  player_greater = player_count > computer_count
  player_safe = !busted?(player_count)
  cmptr_bust = busted? computer_count

  win_lose_tie = if player_greater && player_safe || cmptr_bust && player_safe
                   'win'
                 else
                   'lose'
                 end

  win_lose_tie = 'tie' if player_count == computer_count
  win_lose_tie
end

def hit_stay_prompt(player_cards, computer_cards, player_count)
  approp_article = %w(A 8).include?(computer_cards[0][0]) ? 'an' : 'a'
  dealer_count = count_cards(computer_cards) - count_cards([computer_cards[1]])
  system 'clear'
  puts "Dealer's showing #{approp_article}"
  puts create_display_cards [computer_cards[0], [' ', ' ']]
  puts "Dealer count: #{dealer_count}\n\n"
  print "\n" if busted? player_count
  puts 'YOUR CARDS'
  puts create_display_cards player_cards
  puts "You have #{player_count}.\n\n"
  puts 'YOU BUSTED!' if busted? player_count
  print 'Hit or stay?: ' unless busted? player_count
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
  print "\nYou #{win_lose_tie(player_count, computer_count)}\n"
end

def print_score(plyr_tot, cmp_tot)
  puts "Player score: #{plyr_tot}"
  puts "Dealer score: #{cmp_tot}\n\n"
  print 'HIT ENTER TO CONTINUE:'
  gets
end

computer_cards = []
player_cards = []
player_count = 0
computer_count = 0
player_win_total = 0
comp_win_total = 0
answer = ''

greeting
loop do
  deck = initialize_deck
  player_cards = deal_cards deck
  computer_cards = deal_cards deck
  loop do
    player_count = count_cards player_cards
    computer_count = count_cards computer_cards
    until busted? player_count
      loop do
        hit_stay_prompt player_cards, computer_cards, player_count
        answer = gets.chomp.downcase
        break if %w(hit stay).include? answer
        prompt 'that is not a correct option!'
      end
      break if answer == 'stay'
      hit deck, player_cards
      player_count = count_cards player_cards
      hit_stay_prompt player_cards, computer_cards, player_count
    end
    while !busted?(player_count) && dealer_hit?(computer_count)
      hit(deck, computer_cards)
      computer_count = count_cards computer_cards
      break unless dealer_hit?(computer_count)
    end
    display_result computer_cards, player_cards, computer_count, player_count
    player_win = win_lose_tie(player_count, computer_count)
    player_win_total += 1 if player_win == 'win'
    comp_win_total += 1 if player_win == 'lose'
    break if !dealer_hit?(computer_count) || busted?(player_count)
  end
  break if comp_win_total == BEST_TO || player_win_total == BEST_TO
  print_score player_win_total, comp_win_total
end

salutation player_count, computer_count, player_win_total, comp_win_total