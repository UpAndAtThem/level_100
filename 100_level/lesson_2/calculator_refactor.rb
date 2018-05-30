require 'yaml'

MESSAGES = YAML.load_file('calculator_messages.yml')

def another_calculation
  loop do
    prompt(MESSAGES['another_calc'])
    response = gets.chomp
    return response if MESSAGES['yes_no'].values.include? response
  end
end

def calculate(num1, num2, operation)
  case operation
  when MESSAGES['operations']['add']      then num1 + num2
  when MESSAGES['operations']['subtract'] then num1 - num2
  when MESSAGES['operations']['multiply'] then num1 * num2
  when MESSAGES['operations']['divide']   then num1 / num2
  end
end

def get_number(mess)
  loop do
    prompt mess
    num = gets.chomp

    return num.to_f if num.match(/[+-]?\d*\.*\d+/).to_s == num && num != ''
    prompt MESSAGES['invalid_num']
  end
end

def get_operation(mess)
  loop do
    prompt mess
    operation = gets.chomp

    return operation if MESSAGES['operations'].values.include?(operation)
  end
end

def prompt(*str)
  string, num = str
  puts ">> #{string}#{' ' + num.to_s + "\n\n" if num}"
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
    prompt MESSAGES['language_select']
    lang = gets.chomp.capitalize
    if %w(English Spanish).include? lang
      lang = lang == 'English' ? 'en' : 'es'
      return MESSAGES[lang]
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

  break unless [MESSAGES['yes_no']['yes']].include?(another_calculation)
end

farewell
