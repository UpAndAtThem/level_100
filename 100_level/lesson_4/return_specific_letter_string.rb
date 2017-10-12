# Let's write a method called select_letter, that takes a string and returns a new string containing only the letter that we specified. We want it to behave like this:

def select_letter(question_str, let_selected)
  lett_arr = question_str.chars
  p lett_arr
end

question = 'How many times does a particular character appear in this sentence?'
select_letter(question, 'a') # => "aaaaaaaa"
select_letter(question, 't') # => "ttttt"
select_letter(question, 'z') # => ""

