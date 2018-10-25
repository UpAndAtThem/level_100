def reduce(collection, accumulator = 0)
  count = 0

  if collection[0].class == Array
    accumulator = []
  elsif collection[0].class == String
    accumulator = ''
  end

  while count < collection.length
    accumulator = yield(accumulator, collection[count])

    count += 1
  end

  accumulator
end

array = [1, 2, 3, 4, 5]

reduce(array) { |acc, num| acc + num }                    # => 15
reduce(array, 10) { |acc, num| acc + num }                # => 25
reduce(['a', 'b', 'c']) { |acc, value| acc += value }     # => 'abc'
reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']