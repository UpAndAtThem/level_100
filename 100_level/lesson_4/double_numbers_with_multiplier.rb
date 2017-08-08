def multiply(numbers, multiplier)
  mult_arr = []
  numbers.size.times do |ind|
    mult_arr << numbers[ind] * multiplier
  end
  mult_arr
end

my_numbers = [1, 4, 3, 7, 2, 6]
multiply(my_numbers, 3) # => [3, 12, 9, 21, 6, 18]

# my_numbers was not mutated

# ALTERNATIVE APPROACH
# def multiply(numbers, multiplier)
#   multiplied_numbers = []
#   counter = 0

#   loop do
#     break if counter == numbers.size

#     multiplied_numbers << numbers[counter] * multiplier
#     counter += 1
#   end

#   multiplied_numbers
# end

