require 'pry'

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]] # diagnals

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts ''
  puts '     |     |'
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]} "
  puts '     |     |'
  puts '-----+-----+-----'
  puts '     |     |'
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts '     |     |'
  puts '-----+-----+-----'
  puts '     |     |'
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts '     |     |'
  puts ''
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def initalize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def prompt(message)
  puts "=> #{message}"
end

def player_places_piece(brd)
  square = ''
  loop do
    prompt "Choose a position to place a piece: #{joinor(empty_squares(brd))}"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt 'Sorry, thats not a valid choice'
  end
  brd[square] = PLAYER_MARKER
  display_board brd
end

def computer_places_piece(brd)
  prompt "Choose a position to place a piece: #{joinor(empty_squares(brd))}"
  if offensive_move? brd
    square = offensive_move(brd)
    brd[square] = 'O'
  elsif defensive_move? brd
    square = defensive_move(brd)
    brd[square] = 'O'
  elsif brd[5] == ' '
    brd[5] = 'O'
  else
    square = empty_squares(brd).sample
    brd[square] = COMPUTER_MARKER
  end
  display_board brd
end

def board_full?(brd)
  empty_squares(brd) == []
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    return 'Player' if brd.values_at(*line).count('X') == 3
    return 'Computer' if brd.values_at(*line).count('O') == 3
  end
  nil
end

def joinor(arr, symbol = ',', conjunction = 'or')
  result = ''
  arr.each_with_index do |square, index|
    result << "#{square}#{symbol} " if index + 1 != arr.length
    result << "#{conjunction} #{square}" if index + 1 == arr.length
  end
  result
end

def play_again?
  play_again = ''
  loop do
    prompt 'Would you like to play again? (Y/N)'
    play_again = gets.chomp.downcase
    play_again = play_again == 'y' ? true : false # if is_true
    break
  end
  play_again
end

def defensive_move?(brd)
  WINNING_LINES.each do |line|
    return true if brd.values_at(*line).count('X') == 2 && brd.values_at(*line).count(' ') == 1
  end
  false
end

def defensive_move(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count('X') == 2 && brd.values_at(*line).count(' ') == 1
      line.select{ |square| return square if empty_squares(brd).include? square }
    end
  end
  nil
end

def offensive_move?(brd)
  WINNING_LINES.each do |line|
    return true if brd.values_at(*line).count('O') == 2 && brd.values_at(*line).count(' ') == 1
  end
  false
end

def offensive_move(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count('O') == 2 && brd.values_at(*line).count(' ') == 1
      line.select{ |square| return square if empty_squares(brd).include? square }
    end
  end
  nil
end

computer_score = 0
player_score = 0

loop do
  board = initalize_board
  winner = ''
  loop do
    display_board(board)
    prompt "player: #{player_score} | computer: #{computer_score}"
    player_places_piece(board)
    break if someone_won?(board) || board_full?(board)
    display_board(board)
    computer_places_piece(board)
    break if someone_won?(board) || board_full?(board)
  end

  winner = detect_winner(board)
  player_score += 1 if winner == 'Player'
  computer_score += 1 if winner == 'Computer'
  
  if player_score == 5 || computer_score == 5
    prompt "#{detect_winner(board)} won 5 times, and is the overall winner!"
    player_score = 0
    computer_score = 0 
    break if play_again? == false
  elsif someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt 'It\'s a tie!'
  end
end