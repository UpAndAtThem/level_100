INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
GOES_FIRST = 'choose'.freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]] # diagnals
require 'pry'
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
  (1..9).each_with_object({}) { |num, board| board[num] = INITIAL_MARKER }
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def prompt(message)
  puts "=> #{message}"
end

def player_places_piece!(brd)
  square = ''

  loop do
    remaining = joinor(empty_squares(brd), ',', 'or')

    prompt "Choose a position to place a piece: #{remaining}"
    square = gets.chomp.to_i

    break if empty_squares(brd).include?(square)
    prompt 'Sorry, thats not a valid choice'
  end

  brd[square] = PLAYER_MARKER
  display_board brd
end

def computer_places_piece!(brd)
  sleep 0.5

  if offensive_move? brd
    brd[offensive_move(brd)] = 'O'
  elsif defensive_move? brd
    brd[defensive_move(brd)] = 'O'
  elsif brd[5] == ' '
    brd[5] = 'O'
  else
    brd[empty_squares(brd).sample] = COMPUTER_MARKER
  end
end

def board_full?(brd)
  empty_squares(brd) == []
end

def someone_won?(brd)
  detect_winner(brd).nil? ? false : true
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    return 'Player' if brd.values_at(*line).count('X') == 3
    return 'Computer' if brd.values_at(*line).count('O') == 3
  end
  nil
end

def joinor(arr, symbol = ',', conjunction = 'or')
  arr.each_with_object('').with_index do |(square, result), index|
    result << "#{square}#{symbol} " unless index + 1 == arr.length
    result << "#{conjunction} #{square}" if index + 1 == arr.length
  end
end

def play_again?
  loop do
    prompt 'Would you like to play again? (Y/N)'
    play_again = gets.chomp.downcase

    return play_again if %w(y Y yes Yes YES n N no No NO).include? play_again
  end
end

def defensive_move?(brd)
  WINNING_LINES.each do |line|
    return true if brd.values_at(*line).count('X') == 2 &&
                   brd.values_at(*line).count(' ') == 1
  end

  nil
end

def defensive_move(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count('X') == 2 &&
       brd.values_at(*line).count(' ') == 1

      line.select do |square|
        return square if empty_squares(brd).include? square
      end
    end

    next
  end
  nil
end

def offensive_move?(brd)
  WINNING_LINES.each do |line|
    return true if brd.values_at(*line).count('O') == 2 &&
                   brd.values_at(*line).count(' ') == 1
  end
  nil
end

def offensive_move(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count('O') == 2 &&
       brd.values_at(*line).count(' ') == 1
      line.select do |square|
        return square if empty_squares(brd).include? square
      end
    end

    next
  end
  nil
end

def place_piece!(brd, current_player)
  player_places_piece! brd if current_player == 'player'
  computer_places_piece! brd if current_player == 'computer'
  nil
end

def alternate_player(current_player)
  current_player == 'player' ? 'computer' : 'player'
end

def choose_who_goes_first
  loop do
    prompt 'Who goes first? Choose "player" or "computer"'
    first_player = gets.chomp

    return first_player if %w(computer player).include? first_player
    prompt 'That is not a valid choice'
  end
end

computer_score = 0
player_score = 0
first_player = GOES_FIRST
first_player = choose_who_goes_first if GOES_FIRST == 'choose'
current_player = first_player

loop do
  board = initalize_board
  current_player = first_player

  loop do
    display_board(board)
    prompt "player: #{player_score} | computer: #{computer_score}"

    place_piece!(board, current_player)
    display_board board
    current_player = alternate_player(current_player)

    break if someone_won?(board) || board_full?(board)
  end

  winner = detect_winner(board)
  player_score += 1 if winner == 'Player'
  computer_score += 1 if winner == 'Computer'

  if player_score == 5 || computer_score == 5
    prompt "#{detect_winner(board)} won 5 times, and is the overall winner!"

    player_score = 0
    computer_score = 0

    break if %w(n N no No NO).include? play_again?
  elsif someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt 'It\'s a tie!'
  end

  sleep 0.90
end
