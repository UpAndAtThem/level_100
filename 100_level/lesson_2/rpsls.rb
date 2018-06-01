require 'yaml'

VALID_CHOICES = {rock: '1', paper: '2', scissors: '3',
                 lizard: '4', spock: '5'}.freeze


WINNING_HAND = { rock: ['lizard', 'scissors'], paper: ['rock', 'spock'],
                 scissors: ['lizard', 'paper'], lizard: ['spock', 'paper'],
                 spock: ['rock', 'scissors'] }.freeze

MESSAGES = YAML.load_file('rpsls_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def win_lose_tie(player, computer)
  if WINNING_HAND[player].include? computer.to_s
    'you win!'
  elsif player == computer
    'It is a tie!'
  else
    'you lose!'
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

def display_result_and_score(p_score, p_choice, c_score, c_choice)
  system"clear"
  prompt "you have #{p_choice.upcase}, the computer has #{c_choice.upcase}. " + 
         win_lose_tie(p_choice, c_choice) + "\n\n"
  prompt "player score: #{p_score}"
  prompt "computer_score: #{c_score}\n\n"

end

player_score = 0
computer_score = 0
player_choice = ''
computer_choice = ''

loop do
  system "clear"

  player_choice = choose_rpsls
  computer_choice = VALID_CHOICES.keys.sample

  if winner?(player_choice, computer_choice)
    player_score = increment_score player_score
  elsif winner?(computer_choice, player_choice) 
    computer_score = increment_score computer_score
  end

  display_result_and_score(player_score, player_choice, computer_score, computer_choice)

  prompt MESSAGES['press_enter'] 
  gets

  if player_score == 5 || computer_score == 5
    prompt "GAME OVER! You won #{player_score} #{player_score == 1 ? 'time' : 'times'}" +
            ", and the computer won #{computer_score} #{computer_score == 1 ? 'time' : 'times'}"
    break
  end
end
