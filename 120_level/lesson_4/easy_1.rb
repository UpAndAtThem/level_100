# Question 1
# Which of the following are objects in Ruby? If they are objects, how can you find out what class they belong to?

# true
# "hello"
# [1, 2, 3, "happy days"]
# 142

# A: All of them are objects, you can invoke the instance method class which returns the class name.

# Question 2
# If we have a Car class and a Truck class and we want to be able to go_fast, 
# how can we add the ability for them to go_fast using the module Speed? 
# How can you check if your Car or Truck can now go fast?

# module Speed
#   def go_fast
#     puts "I am a #{self.class} and going super fast!"
#   end
# end

# class Car
#   include Speed

#   def go_slow
#     puts "I am safe and driving slow."
#   end
# end

# class Truck
#   include Speed

#   def go_very_slow
#     puts "I am a heavy truck and like going very slow."
#   end
# end

# truck = Truck.new
# car = Car.new

# (Truck.ancestors.include? Speed) && (Car.ancestors.include? Speed)

# Question 3
# In the last question we had a module called Speed which contained a go_fast 
# method. We included this module in the Car class as shown below.

# module Speed
#   def go_fast
#     puts "I am a #{self.class} and going super fast!"
#   end
# end

# class Car
#   include Speed
#   def go_slow
#     puts "I am safe and driving slow."
#   end
# end

# When we called the go_fast method from an instance of the Car class 
# (as shown below) you might have noticed that the string printed when we go 
# fast includes the name of the type of vehicle we are using. How is this done?

# >> small_car = Car.new
# >> small_car.go_fast
# I am a Car and going super fast!

# in the go_fast method inside Speed module, the string is output to the screen with self (the calling object ie: Car object) invoking the instance method class which returns the name of the objects class, then the interpolation calls to_s on it.

# Question 4

# If we have a class AngryCat how do we create a new instance of this class?

# The AngryCat class might look something like this:

# class AngryCat
#   def hiss
#     puts "Hisssss!!!"
#   end
# end

# anger = AngryCat.new

# anger.hiss

# Question 5
# Which of these two classes has an instance variable and how do you know?

# class Fruit
#   def initialize(name)
#     name = name
#   end
# end

# class Pizza
#   def initialize(name)
#     @name = name
#   end
# end

# A: Pizza, instance variables start with an @ symbol

# Question 6
# What could we add to the class below to access the instance variable @volume?

# class Cube
#   attr_accessor :volume

#   def initialize(volume)
#     @volume = volume
#   end
# end

# A: you could add attr_* to the class definition, or you could write your own volume= or volume method

# Question 7
# What is the default return value of to_s when invoked on an object? 
# Where could you go to find out if you want to be sure?

# The default to_s prints the object’s class and an encoding of the object id.
# check ruby docs Object#to_s

# Question 8
# If we have a class such as the one below:

# class Cat
#   attr_accessor :type, :age

#   def initialize(type)
#     @type = type
#     @age  = 0
#   end

#   def make_one_year_older
#     self.age += 1
#   end
# end

# You can see in the make_one_year_older method we have used self. 
# What does self refer to here?

# self is the calling object to this method.  A Cat instance.

# Question 9
# If we have a class such as the one below:

# class Cat
#   @@cats_count = 0

#   def initialize(type)
#     @type = type
#     @age  = 0
#     @@cats_count += 1
#   end

#   def self.cats_count
#     @@cats_count
#   end
# end

# In the name of the cats_count method we have used self. 
# What does self refer to in this context?

# self refers to the Cat class itself.  which makes this a class method not an instance.

# Question 10
# If we have the class below, what would you need to call to create a new instance of this class.

# class Bag
#   def initialize(color, material)
#     @color = color
#     @material = material
#   end
# end

# Bag.new("Red", "Leather")
# You need to pass in 2 arguments color and material to the new class method.