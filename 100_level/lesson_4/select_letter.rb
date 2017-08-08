# Let's write a method called select_letter, that takes a string and returns a new string containing only the letter that we specified. We want it to behave like this:

def select_letter(question_str, let_selected)
  lett_arr = question_str.chars
  return_str = lett_arr.select do |let|
    let == let_selected
  end
  return_str.join
end

question = 'How many times does a particular character appear in this sentence?'

select_letter(question, 'a') # => "aaaaaaaa"
select_letter(question, 't') # => "ttttt"
select_letter(question, 'z') # => ""

# ALTERNATIVE APPROACH
# def select_letter(sentence, character)
#   selected_chars = ''
#   counter = 0

#   loop do
#     break if counter == sentence.size
#     current_char = sentence[counter]

#     if current_char == character
#       selected_chars << current_char
#     end

#     counter += 1
#   end

#   selected_chars
# end

