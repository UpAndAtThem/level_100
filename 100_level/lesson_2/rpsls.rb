require 'yaml'
require 'pry'

VALID_CHOICES = { rock: '1', paper: '2', scissors: '3',
                 lizard: '4', spock: '5' }.freeze

WINNING_HAND = { rock: ['lizard', 'scissors'], paper: ['rock', 'spock'],
                 scissors: ['lizard', 'paper'], lizard: ['spock', 'paper'],
                 spock: ['rock', 'scissors'] }.freeze

MESSAGES = YAML.load_file('rpsls_messages.yml')

TOTAL_WINS_NEEDED = 5

def player_choose_rpsls
  loop do
    prompt MESSAGES['choose_prompt']
    print "\n==> " 
    player_choice = gets.chomp

    return VALID_CHOICES.key player_choice if valid_choice? player_choice
    clear_screen
    prompt MESSAGES['error_choice']
  end
end

def computer_choose_rpsls
  VALID_CHOICES.keys.sample
end

def prompt(message)
  puts "=> #{message}"
end

def win_lose_tie(player, computer)
  if winner? player, computer
    'YOU WIN!'
  elsif player == computer
    'IT\'S A TIE!'
  else
    'YOU LOSE!'
  end
end

def winner?(player_choice, computer_choice)
  WINNING_HAND[player_choice].include? computer_choice.to_s
end

def display_result(player_choice, computer_choice)
  clear_screen
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

def reached_wins?(player_score, computer_score)
  player_score == TOTAL_WINS_NEEDED || computer_score == TOTAL_WINS_NEEDED
end

def reached_wins_display(player_score)
  prompt player_score == TOTAL_WINS_NEEDED ? 'You Won!' : 'The Computer Won!' #insult / high praise
end

def clear_screen
  system('clear') || system('cls')
end

def valid_choice?(choice)
  VALID_CHOICES.values.include? choice
end

def increment(winner)
  winner += 1
end

def score_difference(player_score, computer_score)
  player_score - computer_score
end

def color_commentary(player_score, computer_score)
  difference = score_difference(player_score, computer_score)

  if difference < 0
    prompt MESSAGES['computer_win_comment'][difference.abs] + "\n\n"
  else
    prompt MESSAGES['player_win_comment'][difference] + "\n\n"
  end
end

def greeting
  clear_screen
  MESSAGES['rules'].each_value { |rule| prompt rule }
  prompt MESSAGES['understand']
  hit_enter
end

player_score = 0
computer_score = 0

greeting

loop do
  clear_screen

  player_choice = player_choose_rpsls
  computer_choice = computer_choose_rpsls

  if winner?(player_choice, computer_choice)
    player_score = increment player_score
  elsif winner?(computer_choice, player_choice)
    computer_score = increment computer_score
  end

  display_result(player_choice, computer_choice)
  display_score(player_score, computer_score)

  if reached_wins? player_score, computer_score
    reached_wins_display(player_score)
    color_commentary(player_score, computer_score)
    break
  else
    hit_enter
  end
end
