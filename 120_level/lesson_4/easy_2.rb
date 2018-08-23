# Question 1
# You are given the following code:

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end
# What is the result of calling

oracle = Oracle.new
oracle.predict_the_future

# it will return "You will " + one of the three choices returned by Array#sample

# Question 2
# We have an Oracle class and a RoadTrip class that inherits from the Oracle class.

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end
# What is the result of the following:

trip = RoadTrip.new
trip.predict_the_future

# When an instance of RoadTrip calls the inherited instance method predict_the_future it calls choices which ruby finds in its own class.

# Question 3
# How do you find where Ruby will look for a method when that method is called? How can you find an object's ancestors?

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

# What is the lookup chain for Orange and HotSauce?

# call the class method ancestors on Orange and HotSauce

# Question 4
# What could you add to this class to simplify it and remove two methods from the class definition while still maintaining the same functionality?

class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end

# remove type=() and type and replace with attr_accessor :type

# Question 5
# There are a number of variables listed below. What are the different types and how do you know which is which?

excited_dog = "excited dog"
@excited_dog = "excited dog"
@@excited_dog = "excited dog"

# local variable, instance variable begins with @, and class variable begins with @@

# Question 6
# If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# Which one of these is a class method (if any) and how do you know? How would you call a class method?

# class methods begin with self, because methods are defined at the class level

# Question 7
# If we have a class such as the one below:

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end

  def cats
    @@cats_count
  end
end

red = Cat.new("red")
tab = Cat.new("Tabby")
lou = Cat.new("blue")
shi = Cat.new("heyo")

# Explain what the @@cats_count variable does and how it works. What code would you need to write to test your theory?

# Class variable are the only variables that are shared between objects.  Only one copy exists for all instances and subclasses  

# Question 8
# If we have this class:

class Game
  def play
    "Start the game!"
  end
end
# And another class:

class Bingo
  def rules_of_play
    #rules of play
  end
end
# What can we add to the Bingo class to allow it to inherit the play method from the Game class?

# add < Game after Bingo on line 155 this means Bingo inherits behavors and state from Game

# Question 9
# If we have this class:

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# What would happen if we added a play method to the Bingo class, 
# keeping in mind that there is already a method of this name in the Game class 
# that the Bingo class inherits from.

# play would be overridden by the Bingo class, ruby always looks in its own class first then works through the ancestor chain.

# Question 10
# What are the benefits of using Object Oriented Programming in Ruby? Think of as many as you can.

# you can create complex hierachical programs with clear design that is maintainable.
# state management is much easier to track and change.
# higher level problems can be broken down into classes, and those classes work with each other to solve problems.
# classes and objects allow the programmer to think more abstractly
# 
