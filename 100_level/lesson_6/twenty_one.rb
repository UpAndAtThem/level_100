FACE_CARD_VALUE = {"j" => 10, 'q' => 10, 'k' => 10}


def initialize_deck
  deck = [
           %w(2 c), %w(3 c), %w(4 c), %w(5 c), %w(6 c), %w(7 c), %w(8 c), %w(9 c), %w(10 c), %w(j c), %w(q c), %w(k c), %w(a c),
           %w(2 d), %w(3 d), %w(4 d), %w(5 d), %w(6 d), %w(7 d), %w(8 d), %w(9 d), %w(10 d), %w(j d), %w(q d), %w(k d), %w(a d),
           %w(2 h), %w(3 h), %w(4 h), %w(5 h), %w(6 h), %w(7 h), %w(8 h), %w(9 h), %w(10 h), %w(j h), %w(q h), %w(k h), %w(a h),
           %w(2 s), %w(3 s), %w(4 s), %w(5 s), %w(6 s), %w(7 s), %w(8 s), %w(9 s), %w(10 s), %w(j s), %w(q s), %w(k s), %w(a s)
          ]
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

def adding_aces count
  count + 11 > 21 ? 1 : 11
end

def hit_or_stay cards

end

def count_cards cards
  count = 0
  cards.each do |card|
    if card[0].to_i != 0
      count += card[0].to_i
    elsif card[0] == 'a'
      count += adding_aces count
    else
      count += FACE_CARD_VALUE[card[0]]
    end
  end
  count
end

computer_cards = []
player_cards = []
player_count = 0
computer_count = 0
#loop do
  deck = initialize_deck
  player_cards, computer_cards = deal_cards deck 
  loop do
    player_count = count_cards player_cards
    hit_or_stay player_cards
    p player_count
    p player_cards

    break
  end
#end
