#create a destructive version of #double_numbers

def double_numbers!(numbers)
  (numbers.size).times do |count|
    numbers[count] *= 2
  end
  numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]
new_arr = double_numbers!(my_numbers) # => [2, 8, 6, 14, 4, 12]

p new_arr
p my_numbers
