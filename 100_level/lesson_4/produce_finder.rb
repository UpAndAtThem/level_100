def select_fruit(grocery_list_hsh)
  fruit_hsh = Hash.new
  grocery_list_hsh.each do |item, type|
    fruit_hsh[item] = type if ('Fruit').include? type 
  end
  fruit_hsh
end

produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

p select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"} # How would you implement a method like this?

#Alternative Approach
# def select_fruit(produce_list)
#   produce_keys = produce_list.keys
#   counter = 0
#   selected_fruits = {}

#   loop do
#     # this has to be at the top in case produce_list is empty hash
#     break if counter == produce_keys.size      

#     current_key = produce_keys[counter]
#     current_value = produce_list[current_key]

#     if current_value == 'Fruit'
#       selected_fruits[current_key] = current_value
#     end

#     counter += 1
#   end

#   selected_fruits
# end
