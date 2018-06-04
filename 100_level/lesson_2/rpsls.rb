require 'yaml'
require 'pry'

VALID_CHOICES = { rock: '1', paper: '2', scissors: '3',
                  lizard: '4', spock: '5' }.freeze

WINNING_HAND = { rock: %w(lizard scissors), paper: %w(rock spock),
                 scissors: %w(lizard paper), lizard: %w(spock paper),
                 spock: %w(rock scissors) }.freeze

MESSAGES = YAML.load_file('rpsls_messages.yml')

SPRITES = YAML.load_file('sprites.yml')

HANDS = VALID_CHOICES.keys

TOTAL_WINS_NEEDED = 5

def display_vs(player_sprite, computer_sprite)
  clear_screen
  display_sprite_left(player_sprite.to_s)
  puts "#{" " * 40}" + "vs"
  display_sprite_right(computer_sprite.to_s)
end

def display_tie
  display_sprite_center('tie')
  sleep 1.33
end

def display_winning_sprite(player_choice, computer_choice)
  #binding.pry
  winner = winning_hand player_choice, computer_choice
  num_spaces = SPRITES[winner.to_s][-1].length - winner.to_s.length # this makes 'WINS!' output line up with sprite in the terminal on line 40

  display_sprite_left(winner.to_s)
  puts "#{" " * num_spaces}" + "WINS!\n\n\n"
end

def display_sprite_left(player_sprite)
  SPRITES[player_sprite][1..-1].each { |row| puts row} # word at bottom of sprite if left aligned
end

def display_sprite_center(sprite)
  SPRITES[sprite].each { |row| puts "#{" " * 20}" + row}
end

def display_sprite_right(computer_sprite, width = 100)
  SPRITES[computer_sprite.to_s][0..-2].each { |row| puts "#{" " * 45} " + row} # word at top of sprite if right aligned
  sleep 1.25
  clear_screen
end

def display_pow(num)
  num.times do |_| 
    %w(pow clouds pow).each do |sprite|
      display_sprite_center sprite
      sleep 0.222
    end
    clear_screen
  end
end

def player_choose_rpsls
  loop do
    prompt "Choose 1-#{TOTAL_WINS_NEEDED}".center(MESSAGES['choose_prompt'].length) + "\n"
    prompt MESSAGES['choose_prompt']
    print "\n=> "

    player_choice = gets.chomp

    return hand player_choice if valid_choice? player_choice

    clear_screen
    prompt MESSAGES['error_choice']
  end
end

def hand(player_choice)
  VALID_CHOICES.key player_choice
end

def computer_choose_rpsls
  HANDS.sample
end

def prompt(message)
  puts "=> #{message}"
end

def win_lose_tie(player, computer)
  if player_winner? player, computer
    MESSAGES['you_win']
  elsif tie? player, computer
    MESSAGES['tie']
  else
    MESSAGES['you_lose']
  end
end

def tie?(player_score, computer_score)
  player_score == computer_score
end

def computer_winner?(computer_choice, player_choice)
  losing_hands(computer_choice).include? player_choice.to_s
end

def player_winner?(player_choice, computer_choice)
  losing_hands(player_choice).include? computer_choice.to_s
end

def display_result(player_choice, computer_choice)
  prompt "You have #{player_choice.upcase}"
  prompt "The computer has #{computer_choice.upcase}.\n\n"
  prompt win_lose_tie(player_choice, computer_choice) + "\n\n"
end

def display_score(player_score, computer_score)
  prompt "player score: #{player_score}"
  prompt "computer_score: #{computer_score}\n\n"
end

def hit_enter
  prompt MESSAGES['press_enter']
  gets
end

def overall_winner?(player_score, computer_score)
  player_score == TOTAL_WINS_NEEDED || computer_score == TOTAL_WINS_NEEDED
end

def won_or_lost_display(player_score)
  prompt(player_score == TOTAL_WINS_NEEDED ? 'You Won!' : 'The Computer Won!')
end

def clear_screen
  system('clear') || system('cls')
end

def valid_choice?(choice)
  VALID_CHOICES.values.include? choice
end

def winning_hand(player_choice, computer_choice)
  player_winner?(player_choice, computer_choice) ? player_choice : computer_choice
end

def increment(winner_score)
  winner_score + 1
end

def difference_in_score(player_score, computer_score)
  player_score - computer_score
end

def color_commentary(player_score, computer_score)
  difference = difference_in_score(player_score, computer_score)

  if difference < 0
    prompt MESSAGES['computer_win_comment'][difference.abs] + "\n\n"
  else
    prompt MESSAGES['player_win_comment'][difference] + "\n\n"
  end
end

def greeting
  clear_screen
  MESSAGES['rules'].each_value { |rule| prompt rule }
  prompt "First to #{TOTAL_WINS_NEEDED} wins!\n\n"
  prompt MESSAGES['understand']
  hit_enter
end

def play_again?
  loop do
    prompt MESSAGES['another_game']

    response = gets.chomp.downcase
    return response == 'yes' if %w(yes no).include? response
  end
end

def farewell
  clear_screen
  prompt MESSAGES['goodbye']
end

def losing_hands(player_choice)
  WINNING_HAND[player_choice]
end

greeting

loop do
  player_score = 0
  computer_score = 0

  loop do
    clear_screen

    player_choice = player_choose_rpsls
    computer_choice = computer_choose_rpsls

    display_vs(player_choice, computer_choice)
    display_pow(2)

    if player_choice == computer_choice
      display_tie
      next
    end

    display_winning_sprite(player_choice, computer_choice)

    if player_winner?(player_choice, computer_choice)
      player_score = increment player_score
    elsif computer_winner?(computer_choice, player_choice)
      computer_score = increment computer_score
    end

    display_result(player_choice, computer_choice)
    display_score(player_score, computer_score)

    if overall_winner? player_score, computer_score
      won_or_lost_display(player_score)
      color_commentary(player_score, computer_score)
      break
    else
      hit_enter
    end
  end

  break unless play_again?
end

farewell

