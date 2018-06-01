require 'yaml'

VALID_CHOICES = { rock: '1', paper: '2', scissors: '3',
                 lizard: '4', spock: '5' }.freeze


WINNING_HAND = { rock: ['lizard', 'scissors'], paper: ['rock', 'spock'],
                 scissors: ['lizard', 'paper'], lizard: ['spock', 'paper'],
                 spock: ['rock', 'scissors'] }.freeze

MESSAGES = YAML.load_file('rpsls_messages.yml')

TOTAL_WINS_NEEDED = 5

def prompt(message)
  puts "=> #{message}"
end

def clear_screen
  system('clear') || system('cls')
end

def win_lose_tie(player, computer)
  if winner?(player, computer)
    'You win!'
  elsif player == computer
    'It is a tie!'
  else
    'You lose!'
  end
end

def valid_choice?(choice)
  VALID_CHOICES.values.include?(choice)
end

def increment_score(winner)
  winner += 1
end

def choose_rpsls()
  loop do
    prompt MESSAGES['choose_prompt']
    print "\n==> " 
    player_choice = gets.chomp

    return VALID_CHOICES.key(player_choice) if valid_choice?(player_choice)
    prompt MESSAGES['error_choice']
  end
end

def winner?(player_choice, computer_choice)
  WINNING_HAND[player_choice].include? computer_choice.to_s
end

def display_result(player_choice, computer_choice)
  clear_screen
  prompt "You have #{player_choice.upcase}"
  prompt "The computer has #{computer_choice.upcase}. "
  prompt win_lose_tie(player_choice, computer_choice) + "\n\n"
end

def display_score(player_score, computer_score)
  prompt "player score: #{player_score}"
  prompt "computer_score: #{computer_score}\n\n"
end

def continue_prompt
  prompt MESSAGES['press_enter']
  gets
end

def reached_wins?(player_score, computer_score)
  player_score == TOTAL_WINS_NEEDED || computer_score == TOTAL_WINS_NEEDED
end

player_score = 0
computer_score = 0

loop do
  clear_screen

  player_choice = choose_rpsls
  computer_choice = VALID_CHOICES.keys.sample

  if winner?(player_choice, computer_choice)
    player_score = increment_score player_score
  elsif winner?(computer_choice, player_choice)
    computer_score = increment_score computer_score
  end

  display_result(player_choice, computer_choice)
  display_score(player_score, computer_score)

  if reached_wins? player_score, computer_score
    prompt player_score == TOTAL_WINS_NEEDED ? "You Won!" : "The Computer Won!"
    break
  else
    continue_prompt
  end
end
