require 'yaml'

def another_calculation?
  loop do
    prompt(MESSAGES['another_calc'])
    response = gets.chomp

    if MESSAGES['yes_no'].values.include? response
      return response == 'yes' ? true : false
    end
  end
end

def calculate(num1, num2, operation)
  result = case operation
           when MESSAGES['operations']['add']      then num1 + num2
           when MESSAGES['operations']['subtract'] then num1 - num2
           when MESSAGES['operations']['multiply'] then num1 * num2
           when MESSAGES['operations']['divide']   then num1 / num2
           end

  result
end

def get_number(message)
  loop do
    prompt message
    num = gets.chomp

    return num.to_f if valid_number? num
    prompt MESSAGES['invalid_num']
  end
end

def valid_number?(num)
  num.match(/[+-]?\d*\.*\d+/).to_s == num && num != ''
end

def get_operation(message)
  loop do
    prompt message
    operation = gets.chomp

    return operation if valid_operation? operation
  end
end

def valid_operation?(operation)
  MESSAGES['operations'].values.include?(operation)
end

def prompt(string, number = nil)
  puts ">> #{string}#{' ' + number.to_s + "\n\n" if number}"
end

def greeting
  system('clear')
  prompt MESSAGES['greeting']
  sleep(1.5)
end

def farewell
  prompt MESSAGES['exit']
end

def pick_language
  loop do
    prompt 'what language would you like? \'English\' or \'Spanish\'?'
    lang = gets.chomp.capitalize

    if %w(English Spanish).include? lang
      lang = lang == 'English' ? 'en' : 'es'
      return YAML.load_file('calculator_messages.yml')[lang]
    end
  end
end

MESSAGES = pick_language

greeting

loop do
  system('clear')

  num1 = get_number(MESSAGES['num1'])
  num2 = get_number(MESSAGES['num2'])
  operation = get_operation(MESSAGES['input_operation'])

  solution = calculate(num1, num2, operation)
  prompt(MESSAGES['solution'], solution)

  break unless another_calculation?
end

farewell
