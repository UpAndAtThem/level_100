VALID_CHOICES = ['rock', 'paper', 'scissors']

def prompt(message)
  puts "=> #{message}"
end

def display_winner player, computer
  if (player == 'rock' && computer == 'scissors') ||
     (player == 'paper' && computer == 'rock') ||
     (player == 'scissors' && computer == 'paper')
    prompt 'you won!'
  elsif (player == 'rock' && computer == 'paper') ||
        (player == 'paper' && computer == 'scissors') ||
        (player == 'scissors' && computer == 'rock')
    prompt 'you lost!'
  else
    prompt "It's a tie!"
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

  computer_choice = ['rock', 'paper', 'scissors'].sample  #the sample arr method randomly chooses one of the collection
  p "you have #{choice}, and the computer has #{computer_choice}"
  display_winner choice, computer_choice 
  prompt 'do you want to play again?'
  answer = gets.chomp
  break unless answer.downcase.start_with? 'y'

end