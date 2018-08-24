# Question 1
# If we have this code:

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
# What happens in each of the following cases:

# case 1:

hello = Hello.new
hello.hi
# The variable hello which is pointing to a Hello instance invokes the instance variable hi, 
# in the method body the greet method is invoked and is given the string literal "Hello" 
# as an argument. Rubys looks for the method in its own class for the method 
# if it cannot find it, it will then look to the hierarchy resolution lookup path. 
# which it finds in the superclass Greeting.  
# greeting invokes the puts method and passes it's argument to puts 
# with output to the screen and returns nil which is the return value of greet

hello = Hello.new
#hello.bye
# case 3:
# undefined method NoMethodError exception is raised
hello = Hello.new
#hello.greet
# case 4:
# wrong number of arguments. ArgumentError exception is raised
hello = Hello.new
hello.greet("Goodbye")
# case 5:
# "Goodbye is out put to the screen"  hello invokes greet which it finds (it's inherited) in the superclass
Hello.hi
# undefined method. NoMethodErrir

# Question 2
# In the last question we had the following classes:

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi
    puts "Hello"
  end

  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# If we call Hello.hi we get an error message. How would you fix this?

# Question 3
# When objects are created they are a separate realization of a particular class.

# Given the class below, how do we create two different instances of this class, both with separate names and ages?

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

bigs = AngryCat.new(2, "bigsby")
bee = AngryCat.new(2, "topdolla")

# Question 4
# Given the class below, if we created a new instance of the class and then called to_s on that instance we would get something like "#<Cat:0x007ff39b356d30>"

class Cat
  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{@type} cat"
  end
end

# How could we go about changing the to_s output on this method to look like this: I am a tabby cat? (this is assuming that "tabby" is the type we passed in during initialization).

# Question 5
# If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end
# What would happen if I called the methods like shown below?

tv = Television.new # new Television object created.
tv.manufacturer #no method error.  Needs class name, not an instance
tv.model # code would run logic

Television.manufacturer # code would run logic
Television.model # no method error

# Question 6
# If we have a class such as the one below:

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end
# In the make_one_year_older method we have used self. What is another way we could write this method so we don't have to use the self prefix?

# use the instance variable instead of the setter method.  change line 152 to @age += 1

# Question 7
# What is used in this class but doesn't add any value?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end
end

# the explicit return on line 171.  ruby implicitly returns on the last line.
