# -----------------------------------------------------
# Let's do some "ASCII Art" (a stone-age form of nerd artwork from back in the days before computers had video screens).

# For this practice problem, write a one-line program that creates the following output 10 times, with the subsequent line indented 1 space to the right:

# The Flintstones Rock!
#  The Flintstones Rock!
#   The Flintstones Rock!


# flinstones_str = 'The Flintstones Rock!'

# 10.times{ |x| p (' ' * x) + "#{flinstones_str}"}

# -----------------------------------------------------

# The result of the following statement will be an error:

# puts "the value of 40 + 2 is " + (40 + 2)
# Why is this and what are two possible ways to fix this?

# Because the expression which is evaluated to 42 cannot be concat. to a string because it's an int

# puts "the value of 40 + 2 is #{(40 + 2)}"
# puts "the value of 40 + 2 is " + (40 + 2).to_s

# -----------------------------------------------------

# Alan wrote the following method, which was intended to show all of the factors of the input number:

# def factors(number)
#   dividend = number.abs
#   divisors = []
#   loop do
#     break if dividend == 0
#     divisors << number.abs / dividend if number % dividend == 0
#     dividend -= 1
#   end
#   divisors
# end

# Alyssa noticed that this will fail if the input is 0, or a negative number, and asked Alan to change the loop. How can you make this work without using begin/end/until? Note that we're not looking to find the factors for 0 or negative numbers, but we just want to handle it gracefully instead of raising an exception or going into an infinite loop.

# -------------------------------------------------------

# Alyssa was asked to write an implementation of a rolling buffer. Elements are added to the rolling buffer and if the buffer becomes full, then new elements that are added will displace the oldest elements in the buffer.

# She wrote two implementations saying, "Take your pick. Do you like << or + for modifying the buffer?". Is there a difference between the two, other than what operator she chose to use to add an element to the buffer?

# def rolling_buffer1(buffer, max_buffer_size, new_element)
#   buffer << new_element
#   buffer.shift if buffer.size > max_buffer_size
#   buffer
# end

# def rolling_buffer2(input_array, max_buffer_size, new_element)
#   buffer = input_array + [new_element]
#   buffer.shift if buffer.size > max_buffer_size
#   buffer
# end

# The first method will mutate the caller the other will not.

# -------------------------------------------------------

# Alyssa asked Ben to write up a basic implementation of a Fibonacci calculator, A user passes in two numbers, and the calculator will keep computing the sequence until some limit is reached.

# Ben coded up this implementation but complained that as soon as he ran it, he got an error. Something about the limit variable. What's wrong with the code?
# How would you fix it to make it work

# limit = 3

# def fib(first_num, second_num, limit)
#   sum = 0
#   fib_arr = []
#   fib_arr << first_num
#   fib_arr << second_num
#   while limit > 0
#     sum = first_num + second_num
#     fib_arr << sum
#     first_num = second_num
#     second_num = sum
#     limit -= 1
#   end
#   [fib_arr, fib_arr.sum]
# end

# result = fib(5, 8, limit)
# puts "result is #{result}"

# -------------------------------------------------------

# In an earlier practice problem we saw that depending on variables to be modified by called methods can be tricky:

# def tricky_method(a_string_param, an_array_param)
#   a_string_param += "rutabaga"
#   an_array_param += "rutabaga"

#   return [a_string_param, an_array_param]
# end

# my_string = "pumpkins"
# my_array = ["pumpkins"]
# tricky_method(my_string, my_array)

# puts "My string looks like this now: #{my_string}"
# puts "My array looks like this now: #{my_array}"

# We learned that whether the above "coincidentally" does what we think we wanted "depends" upon what is going on inside the method.
# How can we refactor this practice problem to make the result easier to predict and easier for the next programmer to maintain?


# -------------------------------------------------------

# What does this output?

# answer = 42

# def mess_with_it(some_number)
#   some_number += 8
# end

# new_answer = mess_with_it(answer)

# p answer - 8

# it outputs 34 because the caller is not mutated and the var wasn't reassigned.

# -------------------------------------------------------

#One day Spot was playing with the Munster family's home computer and he wrote a small program to mess with their demographic data:

# munsters = {
#   "Herman" => { "age" => 32, "gender" => "male" },
#   "Lily" => { "age" => 30, "gender" => "female" },
#   "Grandpa" => { "age" => 402, "gender" => "male" },
#   "Eddie" => { "age" => 10, "gender" => "male" },
#   "Marilyn" => { "age" => 23, "gender" => "female"}
# }

# def mess_with_demographics(demo_hash)
#   demo_hash.values.each do |family_member|
#     family_member["age"] += 42
#     family_member["gender"] = "other"
#   end
# end

# #After writing this method, he typed the following...and before Grandpa could stop him, he hit the Enter key with his tail:

# mess_with_demographics(munsters)

# p munsters

# YES IT WILL MUTATE THE MUNSTERS HASH.  becasuse the original object id is being acted upon

# -------------------------------------------------------

# Method calls can take expressions as arguments. Suppose we define a function called rps as follows, which follows the classic rules of rock-paper-scissors game, but with a slight twist that it declares whatever hand was used in the tie as the result of that tie.

def rps(fist1, fist2)
  if fist1 == "rock"
    (fist2 == "paper") ? "paper" : "rock"
  elsif fist1 == "paper"
    (fist2 == "scissors") ? "scissors" : "paper"
  else
    (fist2 == "rock") ? "rock" : "scissors"
  end
end

#What is the result of the following call?

puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock")





