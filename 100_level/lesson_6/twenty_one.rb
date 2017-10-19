FACE_CARD_VALUE = {"j" => 10, 'q' => 10, 'k' => 10}

def initialize_deck
  deck = [
           %w(2 c), %w(3 c), %w(4 c), %w(5 c), %w(6 c), %w(7 c), %w(8 c), %w(9 c), %w(10 c), %w(j c), %w(q c), %w(k c), %w(a c),
           %w(2 d), %w(3 d), %w(4 d), %w(5 d), %w(6 d), %w(7 d), %w(8 d), %w(9 d), %w(10 d), %w(j d), %w(q d), %w(k d), %w(a d),
           %w(2 h), %w(3 h), %w(4 h), %w(5 h), %w(6 h), %w(7 h), %w(8 h), %w(9 h), %w(10 h), %w(j h), %w(q h), %w(k h), %w(a h),
           %w(2 s), %w(3 s), %w(4 s), %w(5 s), %w(6 s), %w(7 s), %w(8 s), %w(9 s), %w(10 s), %w(j s), %w(q s), %w(k s), %w(a s)
          ]
end

def greeting
  system "clear"
  puts "   Welcome to 21"
  puts "-------------------"
  puts "| A               |"
  puts "|                 |"
  puts "|                 |"
  puts "|        _        |"
  puts "|       ( )       |"
  puts "|       /_\\       |"
  puts "|                 |"
  puts "|                 |"
  puts "|                 |"
  puts "|                 |"
  puts "|               A |"
  puts "------------------"
 
  sleep 1.5
end

def deal_cards deck
  player_cards = []
  computer_cards = []
  1.upto(2) do |_|
    player_cards << deck.sample
    computer_cards << deck.sample
  end
  remove_cards deck, player_cards, computer_cards
  return player_cards, computer_cards
end

def remove_cards deck, player_cards, computer_cards
  [player_cards, computer_cards].each do |set_cards|
    set_cards.each do |card|
      deck.delete(card)
    end
  end
end

def adding_aces cards
  sorted_aces, rest = cards.partition{|card| card[0] == 'a'}
  count = 0
  rest.each do |card| 
    if card[0].to_i == 0
      count += FACE_CARD_VALUE[card[0]]
    else
      count += card[0].to_i
    end
  end
  num_aces = sorted_aces.size
  (num_aces - 1).times{|_| count += 1}
  count + 11 < 22 ? count += 11 : count += 1
end

def hit deck, cards, count 
  new_card = deck.sample
  cards << new_card
  deck.delete(new_card)
end

def count_cards cards
  count = 0
  cards.each do |card|
    if card[0].to_i != 0
      count += card[0].to_i
    elsif card[0] == 'a'
      count = adding_aces cards
      return count
    else
      count += FACE_CARD_VALUE[card[0]]
    end
  end
  count
end


def display_cards computer_cards, player_cards
    (computer_cards.length + 2).times do |index|
      system 'clear'
      puts "player count: #{count_cards player_cards}"
      print "player_cards"
      p player_cards
      puts "\ncomputer count: #{(count_cards computer_cards[0..index])}"
      p computer_cards[0..index]
      sleep 1.25
    end
end

def display_winner(player_cards, computer_cards, player_count, computer_count)
  win_lose_tie =  player_count > computer_count && player_count <= 21 || computer_count > 21 && player_count <= 21 ? "win!" : "lose!"
  win_lose_tie = 'tie' if player_count == computer_count
  system 'clear'
  
  print "player cards: "
  p player_cards
  print "\ncomputer_cards:"
  p computer_cards
  puts "\n\nYou have #{player_count}, and the dealer has #{computer_count} you #{win_lose_tie}\n\n"

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
    loop do
      system 'clear'
      player_count = count_cards player_cards
      break if player_count > 21
      p player_cards
      puts "\nYou have #{player_count}, and the dealer is showing a #{computer_cards[0]}. Hit or stay?"
      answer = gets.chomp
      break if answer == 'stay'
      hit deck, player_cards, player_count
      player_count = count_cards player_cards
    end

    loop do
      computer_count = count_cards computer_cards
      break if player_count > 21
      if computer_count < 17 
        hit(deck, computer_cards, computer_count) 
      end
      computer_count = count_cards computer_cards
      break if computer_count >= 17
    end
    
    display_cards computer_cards, player_cards
    display_winner player_cards, computer_cards, player_count, computer_count
    
    break if computer_count >= 17 || player_count > 21
  end
  break
end
