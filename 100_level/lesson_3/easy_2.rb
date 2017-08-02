# ----------------------------------------
# in this hash see if spot is present
# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# p ages.include? 'Eddie'

# also .include?, .member? is also acceptable 

# ----------------------------------------

# Starting with this string:

# munsters_description = "The Munsters are creepy in a good way."
# Convert the string in the following ways (code will be executed on original munsters_description above):

# "The munsters are creepy in a good way."
# "tHE mUNSTERS ARE CREEPY IN A GOOD WAY."
# "the munsters are creepy in a good way."
# "THE MUNSTERS ARE CREEPY IN A GOOD WAY."

# p munsters_description.capitalize
# p munsters_description.swapcase
# p munsters_description.downcase
# p munsters_description.upcase

# ------------------------------------------

# We have most of the Munster family in our age hash:
# add ages for Marilyn and Spot to the existing hash

# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
# additional_ages = { "Marilyn" => 22, "Spot" => 237 }

# additional_ages.each do |name, age|
#   ages[name] = age
# end

# ALTERNATIVE ELEGANT APPROACH
# ages.merge!(additional_ages)

# -------------------------------------------

# See if the name "Dino" appears in the string below:

# advice = "Few things in life are as important as house training your pet dinosaur."

# p advice.include? 'Dino'

# ALTERNATIVE APPROACH 
# advice.match? 'Dino'

# --------------------------------------------

# Show an easier way to write this

# flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]

# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# ---------------------------------------------

# How can we add the family pet "Dino" to our usual array:

# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# flintstones << Dino

# -----------------------------------------------

# In the previous practice problem we added Dino to our array like this:

# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
# # flintstones << "Dino"
# # We could have used either Array#concat or Array#push to add Dino to the family.

# flintstones.insert -1, 'Dino', 'Hoppy'
# #How can we add multiple items to our array? (Dino and Hoppy)

# ALTERNATIVE APPROACH
# flintstones.push("Dino").push("Hoppy")   # push returns the array so we can chain
# or

# flintstones.concat(%w(Dino Hoppy))  # concat adds an array rather than one item

# ------------------------------------------------

# Shorten this sentence:

# advice = "Few things in life are as important as house training your pet dinosaur."
# ...remove everything starting from "house".
# Review the String#slice! documentation
# use that method to make the return value "Few things in life are as important as ".
# But leave the advice variable as "house training your pet dinosaur."

# first_half = ''
# p first_half = advice.slice!(0,39)
# p advice

# ALTERNATIVE APPROACH
# advice.slice!(0, advice.index('house'))

# --------------------------------------------------

# Write a one-liner to count the number of lower-case 't' characters in the following string:

# statement = "tttTTT"
# count = 0

# statement.split("").each{|let| count +=1 if let == 't' }

# BETTER APPROACH
# statement.count('t')

# ---------------------------------------------------

# Back in the stone age (before CSS) we used spaces to align things on the screen. If we had a 40 character wide table of Flintstone family members, how could we easily center that title above the table with spaces?

title = "Flintstone Family Members"

centerd = title.center 40

p centerd





