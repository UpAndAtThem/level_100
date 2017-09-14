#How would you order this array of number strings by descending numeric value?

# arr = ['10', '11', '9', '7', '8']

# sorted_arr = arr.sort do |x,y|
#   y.to_i <=> x.to_i
# end
# -------------------------------------------------

#How would you order this array of hashes based on the year of publication of each book, from the earliest to the latest?

# books = [
#   {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
#   {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
#   {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
#   {title: 'Ulysses', author: 'James Joyce', published: '1922'}
# ]

# p books.sort{|x,y| y[:published] <=> x[:published]}
# -------------------------------------------------

#For each of these collection objects demonstrate how you would reference the letter 'g'.

# arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]

# arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]

# arr3 = [['abc'], ['def'], {third: ['ghi']}]

# hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}

# hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}

# p arr1[2][1][3]
# p arr2[1][:third][0]
# p arr3[2][:third][0].split("")[0]
# p hsh1['b'][1]
# p hsh2[:third].key(0)
# -------------------------------------------------

# find sum of all the male ages
# munsters = {
#   "Herman" => { "age" => 32, "gender" => "male" },
#   "Lily" => { "age" => 30, "gender" => "female" },
#   "Grandpa" => { "age" => 402, "gender" => "male" },
#   "Eddie" => { "age" => 10, "gender" => "male" },
#   "Marilyn" => { "age" => 23, "gender" => "female"}
# }

# total_male_age = 0

# munsters.each_value do |member_details|
#   total_male_age += member_details['age'] if member_details["gender"] == "male"
# end

# p total_male_age
# -------------------------------------------------

#One of the most frequently used real-world string properties is that of "string substitution", where we take a hard-coded string and modify it with various parameters from our program.

#Given this previously seen family hash, print out the name, age and gender of each family member:

# munsters = {
#   "Herman" => { "age" => 32, "gender" => "male" },
#   "Lily" => { "age" => 30, "gender" => "female" },
#   "Grandpa" => { "age" => 402, "gender" => "male" },
#   "Eddie" => { "age" => 10, "gender" => "male" },
#   "Marilyn" => { "age" => 23, "gender" => "female"}
# }

# munsters.each_pair do |member, details|
#   p "#{member} is #{details["age"]} years old, and is #{details["gender"]}"
# end

# --------------------------------------------------
# What are the final values of a and b?  
# a = 2
# b = [5, 8]
# arr = [a, b]

# arr[0] += 2
# arr[1][0] -= a

# p a == 2
# p b == [3,8]

# -------------------------------------------------
# output only vowels from the hash values
# hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

# hsh.each_value do |word_arr|
#   word_arr.each do |word|
#     word.chars.each do |letter|
#       p letter if letter =~ /[aeiou]/
#     end
#   end
# end
# -------------------------------------------------

# Given this data structure, return a new array of the same structure but with the sub arrays being ordered (alphabetically or numerically as appropriate) in descending order.

# arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

# new_arr = arr.map do |sub_arr|
#   sub_arr.sort_by{|item| item}.reverse
# end

# p new_arr
# -------------------------------------------------
#Given the following data structure and without modifying the original array, use the map method to return a new array identical in structure to the original but where the value of each integer is incremented by 1.

# hsh_arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

# return_hash = hsh_arr.map do |hash|
#   new_hsh = {}
#   hash.each do |key, value|
#     new_hsh[key] = value + 1
#   end
#   new_hsh
# end

# p hsh_arr
# p return_hash

# -------------------------------------------------

#Given the following data structure use a combination of methods, including either the select or reject method, 
#to return a new array identical in structure to the original but containing only the integers that are multiples of 3.

# arr = [[2], [3, 5, 7], [9], [11, 3, 6, 13, 15]]

# mult_of_3_arr = arr.map do |arr|
#   return_arr = []
#   arr.each do |num|
#     return_arr << num if num % 3 == 0
#   end
#   return_arr
# end

# p mult_of_3_arr
# -------------------------------------------------

#Given the following data structure, and without using the Array#to_h method, 
#write some code that will return a hash where the key is the first item in each sub array and the value is the second item.

# arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]

# arr.each_with_object({}) do |val, hash|
#   hash[val[0]] = val[1]
# end
# -------------------------------------------------
# Given the following data structure, return a new array containing the same sub-arrays as the original but ordered logically
# according to the numeric value of the odd integers they contain.
# The sorted array should look like this:
# [[1, 8, 3], [1, 6, 7], [1, 4, 9]]

# arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

# sorted_arr = arr.sort_by do |sub_arr|
#   sub_arr.select do |num|
#     num.odd?
#   end
# end

# p sorted_arr
# -------------------------------------------------
# Given this data structure write some code to return an array containing the colors of the fruits and the sizes 
# of the vegetables. The sizes should be uppercase and the colors should be capitalized.

#return value: [["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]

# hsh = {
#   'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
#   'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
#   'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
#   'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
#   'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
# }
# return_arr = []
# hsh.each_value do |value|
#   return_arr << value[:colors].map{|color| color.capitalize} if value[:type] == 'fruit'
#   return_arr << value[:size].upcase if value[:type] == 'vegetable'
# end
# -------------------------------------------------

# Given this data structure write some code to return an array which contains only the hashes where all the integers are even.

# arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

# return_arr = arr.select do |hash|
#   hash.all? do |key, value|
#     value.all?{|num| num.even?}
#   end
# end

# p return_arr

# -------------------------------------------------

# def generate_UUID
#   characters = []
#   (0..9).each { |digit| characters << digit.to_s }
#   ('a'..'f').each { |digit| characters << digit }

#   uuid = ""
#   sections = [8, 4, 4, 4, 12]
#   sections.each_with_index do |section, index|
#     section.times { uuid += characters.sample }
#     uuid += '-' unless index >= sections.size - 1
#   end

#   uuid
# end

