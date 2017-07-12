require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  num.to_f.nonzero?
end

def operation_to_message(num)
  case num
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

num1 = 0
num2 = 0
operator = 0
name = ''

prompt(MESSAGES['welcome'])
name = ''
loop do
  name = gets.chomp!
  break unless name.empty?
  prompt(MESSAGES['invalid_name'])
end

loop do # main loop
  loop do
    prompt(MESSAGES['first_num'])
    num1 = gets.chomp
    break if valid_number? num1
    prompt(MESSAGES['invalid_num'])
  end

  loop do
    prompt(MESSAGES['second_num'])
    num2 = gets.chomp
    break if valid_number? num2
    prompt(MESSAGES['invalid_num'])
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
    operator = gets.chomp
    break if ['1', '2', '3', '4'].include? operator
    prompt(MESSAGES['invalid_operator'])
  end

  prompt "#{operation_to_message(operator)} the two numbers"
  result = case operator
           when '1'
             num1.to_f + num2.to_f
           when '2'
             num1.to_f - num2.to_f
           when '3'
             num1.to_f * num2.to_f
           when '4'
             num1.to_f / num2.to_f
           end
  prompt(MESSAGES['result'] + " #{result}")
  prompt(MESSAGES['another_calc'])
  break unless gets.chomp!.downcase.start_with? 'y'
end

prompt(MESSAGES['salutation'] + " #{name.capitalize}!")
