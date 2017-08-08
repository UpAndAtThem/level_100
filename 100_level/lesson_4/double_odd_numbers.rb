#Try coding a solution that doubles the numbers that have odd indices:
def double_odd_numbers(numbers)
  double_odd_arr = []

  (numbers.size).times do |index|

    if (index).odd?
      double_odd_arr << numbers[index] * 2
    else
      double_odd_arr << numbers[index]
    end
  end

  double_odd_arr
end
  
my_numbers = [1, 4, 3, 7, 2, 6]
p double_odd_numbers(my_numbers)  # => [1, 8, 3, 14, 2, 12]
p my_numbers  # => [1, 4, 3, 7, 2, 6]  NOT MUTATED

# ALTERNATIVE APPROACH
# def double_odd_indices(numbers)
#   doubled_numbers = []
#   counter = 0

#   loop do
#     break if counter == numbers.size

#     current_number = numbers[counter]
#     current_number *= 2 if counter.odd?
#     doubled_numbers << current_number

#     counter += 1
#   end

#   doubled_numbers
# end

# my_numbers = [1, 4, 3, 7, 2, 6]
# double_odd_indices(my_numbers) # => [1, 8, 3, 14, 2, 12]