VALID_CHOICES = %w(rock paper scissors).freeze

def prompt(message)
  puts "=> #{message}"
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'scissors' && second == 'paper')
end

def display_winner(player, computer)
  if win? player, computer
    prompt 'you won!'
  elsif win? computer, player
    prompt 'the computer won!'
  else
    prompt 'It is a tie!'
  end
end

loop do
  choice = ''
  loop do
    prompt "Choose one: #{VALID_CHOICES.join(', ')}"
    choice = gets.chomp
    break if VALID_CHOICES.include?(choice)
    puts "you need to enter one: #{VALID_CHOICES.join(', ')}"
  end

  computer_choice = %w(rock paper scissors).sample

  puts "you have #{choice}, and the computer has #{computer_choice}"

  display_winner choice, computer_choice

  prompt 'do you want to play again?'
  answer = gets.chomp

  break unless answer.downcase.start_with? 'y'
end
