def prompt message
  puts "=> #{message}"
end

def valid_number? num
  num.to_i != 0
end

def operation_to_message num
  case num
  when 1
    "Adding"
  when 2
    'Subtracting'
  when 3
    'Multiplying'
  when 4
    'Dividing'
  end
end

num1 = 0
num2 = 0
operator = 0
name = ''

prompt "welcome to Calculator! Enter your name: "
name = ''
loop do
  name = gets.chomp!
  break unless name.empty?
end

loop do #main loop
  loop do
    prompt "What's the first number?"
    num1 = gets.chomp.to_i
    break if valid_number? num1
    prompt "Thats not a valid number"
  end

  loop do 
    prompt "What's the second number?"
    num2 = gets.chomp.to_i
    break if valid_number? num2
    prompt "Thats not a valid number"
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
        1) add
        2) subtract
        3) multiply
        4) divide
  MSG

  prompt operator_prompt

  loop do  
    operator = gets.chomp.to_i
    break if [1,2,3,4].include? operator
    prompt "That was an invalid choice. Choose 1, 2, 3 or 4"
  end

  prompt "#{operation_to_message(operator)} the two numbers"
  result = case operator
           when 1 
            num1.to_i + num2.to_i
           when 2 
            num1.to_i - num2.to_i
           when 3 
            num1.to_i * num2.to_i
           when 4 
            num1.to_f / num2.to_f
  end
  
  prompt "your result is #{result}"
  prompt "Do you want perform another calculation 'y' if yes"
  
  break unless gets.chomp!.downcase.start_with? 'y'

end

prompt "Thank you for using our calculator! Good Bye, #{name}!"
puts ''


