require 'yaml'
require 'pry'

VALID_CHOICES = { 'rock' => '1', 'paper' => '2', 'scissors' => '3',
                  'lizard' => '4', 'spock' => '5' }.freeze

WINNING_HAND = { 'rock' => %w(lizard scissors), 'paper' => %w(rock spock),
                 'scissors' => %w(lizard paper), 'lizard' => %w(spock paper),
                 'spock' => %w(rock scissors) }.freeze

MESSAGES = YAML.load_file('rpsls_messages.yml')

SPRITES = YAML.load_file('sprites.yml')

HANDS = VALID_CHOICES.keys

TOTAL_WINS_NEEDED = 5

def prompt(message)
  puts "=> #{message}"
end

def greeting
  clear_screen
  display_rules
  prompt format(MESSAGES['first_to'], wins_needed: TOTAL_WINS_NEEDED)
  prompt MESSAGES['understand']
  hit_enter
end

def farewell
  clear_screen
  prompt MESSAGES['goodbye']
end

def display_rules
  MESSAGES['rules'].each_value { |rule| prompt rule }
end

def display_options_menu
  following_line_length = MESSAGES['choose_prompt'].length
  one_through = format(MESSAGES['one_through'], wins_needed: HANDS.size)

  prompt(one_through.center(following_line_length))
  prompt MESSAGES['choose_prompt']
  print "\n=> "
end

def display_opponents(player_sprite, computer_sprite)
  clear_screen

  width_of_opponent = sprite(player_sprite).max_by(&:length).length

  display_sprite_left(player_sprite)
  puts(' ' * (width_of_opponent + 5) + 'vs')
  display_sprite_right(computer_sprite, width_of_opponent)
end

def display_tie
  puts "\n\n\n\n"
  display_sprite_center('tie')
  sleep 1.33
end

def display_winning_sprite(players_choice, computers_choice)
  winning_choice = winning_hand players_choice, computers_choice

  # This makes the 'WINS!' output line-up with sprite name in terminal output
  num_spaces = sprite(winning_choice)[-1].length - winning_choice.length

  display_sprite_left winning_choice
  puts(' ' * num_spaces + "WINS!\n\n\n")
end

def pow_animation
  %w(pow clouds pow).each do |current_sprite|
    display_sprite_center current_sprite
    sleep 0.333
  end
  clear_screen
end

def display_sprite_left(players_choice)
  # slices off text line at top of sprite array
  sprite(players_choice)[1..-1].each { |row| puts row }
end

def display_sprite_center(sprite_choice)
  sprite(sprite_choice).each { |row| puts((' ' * 20) + row) }
end

def display_sprite_right(computers_choice, width_of_opponent)
  # slices off text line at bottom of sprite array
  sprite(computers_choice)[0..-2].each do |row|
    puts(' ' * (width_of_opponent + 10) + row)
  end
  sleep 1.25
  clear_screen
end

def display_score(players_score, computers_score)
  prompt format(MESSAGES['players_score'], score: players_score)
  prompt format(MESSAGES['computers_score'], score: computers_score)
end

def display_result(players_choice, computers_choice)
  prompt format(MESSAGES['players_choice'], choice: players_choice.upcase)
  prompt format(MESSAGES['computers_choice'], choice: computers_choice.upcase)
  prompt victors_method players_choice, computers_choice
  prompt win_lose_tie(players_choice, computers_choice) + "\n\n"
end

def display_won_or_lost(players_score, computers_score)
  prompt(players_score == TOTAL_WINS_NEEDED ? 'You Won!' : 'The Computer Won!')
  color_commentary(players_score, computers_score)
end

def color_commentary(players_score, computers_score)
  difference = difference_in_score(players_score, computers_score)

  if difference < 0
    prompt MESSAGES['computer_win_comment'][difference.abs] + "\n\n"
  else
    prompt MESSAGES['player_win_comment'][difference] + "\n\n"
  end
end

def player_choose_rpsls
  clear_screen
  loop do
    display_options_menu

    players_choice = gets.chomp

    return hand players_choice if valid_choice? players_choice

    clear_screen
    prompt MESSAGES['error_choice']
  end
end

def computer_choose_rpsls
  HANDS.sample
end

def hand(players_choice)
  VALID_CHOICES.key players_choice
end

def sprite(choice)
  SPRITES[choice]
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

def tie?(players_score, computers_score)
  players_score == computers_score
end

def computer_winner?(players_choice, computers_choice)
  losing_hands(computers_choice).include? players_choice
end

def player_winner?(players_choice, computers_choice)
  losing_hands(players_choice).include? computers_choice
end

def victors_method(players_choice, computers_choice)
  if player_winner? players_choice, computers_choice
    MESSAGES[players_choice][computers_choice]
  else
    MESSAGES[computers_choice][players_choice]
  end
end

def hit_enter
  prompt MESSAGES['press_enter']
  gets
end

def overall_winner?(players_score, computers_score)
  players_score == TOTAL_WINS_NEEDED || computers_score == TOTAL_WINS_NEEDED
end

def clear_screen
  system('clear') || system('cls')
end

def valid_choice?(choice)
  VALID_CHOICES.values.include? choice
end

def winning_hand(players_choice, computers_choice)
  if player_winner?(players_choice, computers_choice)
    players_choice
  else
    computers_choice
  end
end

def losing_hands(players_choice)
  WINNING_HAND[players_choice]
end

def increment(winner_score)
  winner_score + 1
end

def difference_in_score(players_score, computers_score)
  players_score - computers_score
end

def play_again?
  loop do
    prompt MESSAGES['another_game']

    response = gets.chomp.downcase
    return response == 'yes' if %w(yes no).include? response
  end
end

greeting

loop do
  players_score = 0
  computers_score = 0

  loop do
    players_choice = player_choose_rpsls
    computers_choice = computer_choose_rpsls

    display_opponents(players_choice, computers_choice)
    pow_animation

    if tie? players_choice, computers_choice
      display_tie
      next
    end

    if player_winner?(players_choice, computers_choice)
      players_score = increment players_score
    elsif computer_winner?(players_choice, computers_choice)
      computers_score = increment computers_score
    end

    display_winning_sprite(players_choice, computers_choice)
    display_result(players_choice, computers_choice)
    display_score(players_score, computers_score)

    if overall_winner? players_score, computers_score
      display_won_or_lost(players_score, computers_score)
      break
    else
      hit_enter
    end
  end

  break unless play_again?
end

farewell

