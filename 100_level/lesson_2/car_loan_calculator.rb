# Take everything you've learned so far and build a mortgage calculator

# You'll need three pieces of information:

# the loan amount
# the Annual Percentage Rate (APR)
# the loan duration
# From the above, you'll need to calculate the following two things:

# monthly interest rate
# loan duration in months
# You can use the following formula:  m = p * (j / (1 - (1 + j)**(-n)))
# m = monthly payment
# p = loan amount
# j = monthly interest rate
# n = loan duration in months

require 'yaml'
MESSAGES = YAML.load_file('car_loan_calculator.yml')
p MESSAGES
def prompt(str)
  puts "==> #{str}"
end

prompt(MESSAGES['greeting'])

loop do
  loan_duration = nil
  loop do # loops until a good monthly payment is entered
    prompt(MESSAGES['loan duration'])
    loan_duration = gets.chomp
    break unless loan_duration.empty? || loan_duration.to_i < 0
  end

  loan_amount = nil
  loop do # loops until a good loan amount is entered
    prompt(MESSAGES['loan amount'])
    loan_amount = gets.chomp
    break unless loan_amount.empty? || loan_amount.to_i < 0
    prompt(MESSAGES['invalid number'])
  end

  apr = nil
  loop do # loops until a good apr is entered
    prompt(MESSAGES['apr'])
    apr = gets.chomp
    break unless apr.empty? || apr.to_f < 0
    prompt(MESSAGES['invalid number'])
  end

  monthly_interest_rate_percentage = apr.to_f / 12
  monthly_interest_rate_decimal = monthly_interest_rate_percentage / 100

  monthly_payment = loan_amount.to_f * (monthly_interest_rate_decimal / (1 - (1 + monthly_interest_rate_decimal)**-loan_duration.to_f))
  prompt "your monthly payment is $#{sprintf('%.2f', monthly_payment)}"
  sleep 3
  prompt(MESSAGES['restart?'])
  restart = gets.chomp
  break unless restart.downcase.start_with? 'y'
end

prompt(MESSAGES['salutation'])
