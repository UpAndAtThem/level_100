# Given the array below
# Turn this array into a hash where the names are the keys and the values are the positions in the array.

# flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
# flintstones_hash = Hash.new

# flintstones.each_with_index do |name, index|
#   flintstones_hash[name] = index
# end

# ----------------------------------------------------------

# Add up all of the ages from the Munster family hash:

# name_age_hash = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# p ages = name_age_hash.values.reduce(:+)

# ----------------------------------------------------------

# In the age hash:
# throw out the really old people (age 100 or older).

# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# ages.delete_if {|key, value| value >= 100 }

# ----------------------------------------------------------

# Pick out the minimum age from our current Munster family hash:

# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# ages.values.min

# ------------------------------------------------------------

# Find the index of the first name that starts with "Be"

# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# p flintstones.index { |x| x[0,2] == 'Be' } 

# ------------------------------------------------------------

# Amend this array so that the names are all shortened to just the first three characters:

# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# abbreviated_flintstones = flintstones.map do |name|
#   name[0, 3]
# end

# p abbreviated_flintstones
# p flintstones

# ------------------------------------------------------------

# Create a hash that expresses the frequency with which each letter occurs in this string:

# ex:

# { "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }

# statement = "The Flintstones Rock"

# letter_array = statement.split""
# letter_hash = Hash.new(0)

# letter_array.map do |letter|
#   letter_hash[letter] += 1
# end

# --------------------------------------------------------------
# Titleize the string

# words = "the flintstones rock"

# words.split.map{ |word| word.capitalize}.join(" ")

# ---------------------------------------------------------------

# munsters = {
#   "Herman" => { "age" => 32, "gender" => "male" },
#   "Lily" => { "age" => 30, "gender" => "female" },
#   "Grandpa" => { "age" => 402, "gender" => "male" },
#   "Eddie" => { "age" => 10, "gender" => "male" },
#   "Marilyn" => { "age" => 23, "gender" => "female"}
# }

# munsters.each do |key, value|
#   if value['age'] < 18
#     value['age_group'] = 'kid'
#   elsif value['age'] >= 18 && value['age'] < 65
#     value['age_group'] = 'adult'
#   else
#     value['age_group'] = 'senior'
#   end
#   p value
# end

# ALTERNATIVE APPROACH
# munsters.each do |name, details|
#   case details["age"]
#   when 0...18
#     details["age_group"] = "kid"
#   when 18...65
#     details["age_group"] = "adult"
#   else
#     details["age_group"] = "senior"
#   end
# end

# Note: a kid is in the age range 0 - 17, an adult is in the range 18 - 64 and a senior is aged 65+.
# Modify the hash such that each member of the Munster family has an additional "age_group"
# key that has one of three values describing the age group the family member is in (kid, adult, or senior). 
# Your solution should produce the hash below



