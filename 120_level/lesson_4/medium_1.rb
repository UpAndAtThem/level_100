# Question 1
# Ben asked Alyssa to code review the following code:

class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

# BankAccount.new(100).positive_balance?

# Alyssa glanced over the code quickly and said - 

# "It looks fine, except that you forgot to put the @ before balance when 
# you refer to the balance instance variable in the body of the positive_balance? 
# method."

# "Not so fast", Ben replied. "What I'm doing here is valid - I'm not missing an @!"

# Who is right, Ben or Alyssa, and why?

# Ben is right.  He is making use of the attr_reader of balance.


# Question 2
# Alyssa created the following code to keep track of items for a shopping cart application she's writing:

class InvoiceEntry
  attr_accessor :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    self.quantity = updated_count if updated_count >= 0
  end
end

# Alan looked at the code and spotted a mistake. 
# "This will fail when update_quantity is called", he says.

# Can you spot the mistake and how to address it?

# Question 3
# In the last question Alyssa showed Alan this code which keeps track 
# of items for a shopping cart application:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

# Alan noticed that this will fail when update_quantity is called. 
# Since quantity is an instance variable, it must be accessed with 
# the @quantity notation when setting it. One way to fix this is to
# change attr_reader to attr_accessor and change quantity to self.quantity.

# Is there anything wrong with fixing it this way?

# not unless you want them to be private or protected. because then things 
# could be changed and you might not want that

# Let's practice creating an object hierarchy.

# Create a class called Greeting with a single method called greet that takes a 
# string argument and prints that argument to the terminal.

# Now create two other classes that are derived from Greeting: one called Hello 
# and one called Goodbye. The Hello class should have a hi method that takes no
# arguments and prints "Hello". The Goodbye class should have a bye method to say 
# "Goodbye". Make use of the Greeting class greet method when implementing the 
# Hello and Goodbye classes - do not use any puts in the Hello or Goodbye classes.

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet "Hello"
  end
end

class Goodbye < Greeting
  def bye
    greet "Goodbye"
  end
end

# Question 5
# You are given the following class that has been implemented:
require 'pry'

class KrispyKreme
  attr_reader :filling_type, :glazing

  def initialize(filling_type, glazing)
    if filling_type
      @filling_type = filling_type
    else
      @filling_type = "Plain" if filling_type.nil?
    end

    @glazing = glazing
  end

  def to_s
    "#{filling_type}#{" with " + glazing if glazing}"
  end
end

# And the following specification of expected behavior:

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
  # => "Plain"

puts donut2
  # => "Vanilla"

puts donut3
  # => "Plain with sugar"

puts donut4
  # => "Plain with chocolate sprinkles"

puts donut5
  # => "Custard with icing"

# Write additional code for KrispyKreme such that the puts statements will work as specified above.

# Question 6
# If we have these two methods:

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end


class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

# in the top Computer class the instance method create_template uses instance variable assignment rather than invoking the setter method on the class below create_template method.
# in the top Computer class the instance method show_template invokes the getter method template, where as the class below invokes the getter method but with the unessesary self prefix.

# Question 7
# How could you change the method name below so that the method name is more clear and less repetitive.
# A: remove the redundant light in the class method light_information, to just information, so it reads Light.information when invoked.

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    "I want to turn on the light with a brightness level of super high and a colour of green"
  end
end




