VALID_CHOICES = %w(rock paper scissors lizard spock).freeze

WINNING_HAND = { rock: ['lizard', 'scissors'], paper: ['rock', 'spock'],
                 scissors: ['lizard', 'paper'], lizard: ['spock', 'paper'],
                 spock: ['rock', 'scissors'] }.freeze

def prompt(message)
  puts "\n=> #{message}"
end

def display_winner(player, computer)
  if WINNING_HAND[player.to_sym].include? computer
    'you win!'
  elsif player == computer
    'It is a tie!'
  else
    'you lose!'
  end
end

def valid_entry?(choice)
  VALID_CHOICES.include?(choice)
end

def tally_score(winner)
  winner += 1
end

player_score = 0
computer_score = 0
player_choice = ''
computer_choice = ''

loop do
  loop do
    prompt "Choose one: #{VALID_CHOICES.join(', ')}"
    player_choice = gets.chomp
    break if valid_entry? player_choice
    prompt "you need to enter one: #{VALID_CHOICES.join(', ')}"
  end

  computer_choice = VALID_CHOICES.sample

  prompt "you have #{player_choice}, and the computer has #{computer_choice}." + (display_winner player_choice, computer_choice)

  if WINNING_HAND[player_choice.to_sym].include? computer_choice
    player_score = tally_score player_score
  elsif player_choice == computer_choice
    next
  else computer_score = tally_score computer_score
  end

  if player_score == 5 || computer_score == 5
    prompt "GAME OVER! You won #{player_score} #{player_score == 1 ? 'time' : 'times'}, and the computer won #{computer_score} #{computer_score == 1 ? 'time' : 'times'}"
    break
  end
end
