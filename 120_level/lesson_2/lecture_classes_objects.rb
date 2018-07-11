#Given the below usage of the Person class, code the class definition.

# class Person
#   attr_accessor :first_name, :last_name
#   attr_writer :name

#   def initialize(name)
#     self.name = name
#     self.first_name = name
#     self.last_name = ''
#   end

#   def name
#     "#{first_name} #{last_name}"
#   end
# end

# bob = Person.new('bob')
# bob.name                  # => 'bob'
# bob.name = 'Robert'
# bob.name                  # => 'Robert'

# --------------------------------

# Modify the class definition from above to facilitate the following methods. 
# Note that there is no name= setter method now.

# bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
# p bob.last_name = 'Smith'
# p bob.name                  # => 'Robert Smith'

# Hint: let first_name and last_name be "states" and create an instance method 
# called name that uses those states.

# ---------------------------------

# Now create a smart name= method that can take just a first name or a full name, 
# and knows how to set the first_name and last_name appropriately.

class Person
  attr_accessor :first_name, :last_name
  attr_writer :name

  def initialize(name)
    self.name = name
  end

  def name
    "#{first_name} #{last_name}"
  end

  def name=(name)
    if name.count(" ").zero?
      @name = name
      @first_name = name
    else
      @first_name, @last_name = name.split(" ")
    end
  end

  def has_same_name?(other_bob)
    name == other_bob.name
  end
end

bob = Person.new('Smith')
other_bob = Person.new('Smithyboy')
