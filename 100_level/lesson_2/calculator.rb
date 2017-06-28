# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the results

# answer = gets
# puts answer

puts "Welcome to the Calculator!"
puts "What's the first number?"
num1 = gets.chomp.to_i
puts "What's the second number?"
num2 = gets.chomp.to_i
puts "What operation would you like to perform? 1) add 2) subtract 3) multiply 4) divide"
operator = gets.chomp.to_i

if operator == 1
  puts num1.to_s + " + " + num2.to_s + " = #{num1 + num2}"
elsif operator == 2
  puts num1.to_s + " - " + num2.to_s + " = #{num1 - num2}"
elsif operator == 3
  puts num1.to_s + " * " + num2.to_s + " = #{num1 * num2}"
elsif operator == 4
  puts num1.to_s + " / " + num2.to_s + " = #{(num1.to_f / num2.to_f)}"
else
  puts "please select 1-4"

end