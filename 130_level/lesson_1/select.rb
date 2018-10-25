def select(collection)
  count = 0
  result = []

  while count < collection.size
    current_element = collection[count]

    result << current_element if yield(current_element)

    count += 1
  end

  result
end


arr = [1, 2, 3, 4, 5, 22, 101, 99, 13, 84, 44, 66, 53]

select(arr) { |num| num.odd?}
