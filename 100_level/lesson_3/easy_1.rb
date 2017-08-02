#-----------------------------------
# What would you expect the code below to print out?

# numbers = [1, 2, 2, 3]
# numbers.uniq

# puts numbers

# 1
# 2
# 2
# 3

# --------------------------------

# Describe the difference between ! and ? in Ruby. And explain what would happen in the following scenarios:

# what is != and where should you use it?
    # != means does not equal when comparing 2 objects
# put ! before something, like !user_name
    # ! before something means NOT.  and evaluates to the opposite of its current bool.  !nil == true
# put ! after something, like words.uniq!
    # ! after a method means it will mutate the caller
# put ? before something
    # ? before something is the ternary symbol just before the  x : y  true/false conditional
# put ? after something
    # ? after a method name typically denotes a true/false return 
# put !! before something, like !!user_name
    # !! before turns any object into it's boolean equivalent.

# -------------------------------------

# Replace the word "important" with "urgent" in this string:

# advice = "Few things in life are as important as house training your pet dinosaur."

# advice.gsub!(/important/, 'urgent')

# --------------------------------------

# The Ruby Array class has several methods for removing items from the array. Two of them have very similar names. Let's see how they differ:

# numbers = [1, 2, 3, 4, 5]
# What do the following method calls do (assume we reset numbers to the original array between method calls)?

# numbers.delete_at(1)
# numbers.delete(1)

# numbers.delete_at(1) will delete at index 1 of the collection (this is a mutative method)
# numbers.delete(1) will delete all instances of the int 1 from the collection

# ----------------------------------------

# Programmatically determine if 42 lies between 10 and 100.

# p (10..100).include? 42  #cover? method will work here too

# ----------------------------------------

# famous_words = "seven years ago..."

# show 2 different ways to add 'four score and' to the front

# famous_words.prepend 'four score and '
# famous_words = ['four score and', famous_words].join ' '

# -----------------------------------------

# def add_eight(number)
#   number + 8
# end

# number = 2

# how_deep = "number"
# 5.times { how_deep.gsub!("number", "add_eight(number)") }

# p how_deep
# This gives us a string that looks like a "recursive" method call:

# "add_eight(add_eight(add_eight(add_eight(add_eight(number)))))"
# If we take advantage of Ruby's Kernel#eval method to have it execute this string as if it were a "recursive" method call

# eval(how_deep)
# what will be the result?

# 42

# ---------------------------------------------

flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

flintstones = flintstones.select do |k,v|
  true if k == 'Barney'
end

flintstones = flintstones.to_a.flatten!

p flintstones




# flintstones << ["Barney", "Betty"]
# flintstones << ["BamBam", "Pebbles"]
# We will end up with this "nested" array:

# ["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]
# Make this into an un-nested array.

# flintstones.flatten!

# ----------------------------------------------

flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
