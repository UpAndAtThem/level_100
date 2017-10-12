require "pry"

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def display_board(brd)
  system "clear"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end

def initalize_board
  new_board = {}
  (1..9).each {|num| new_board[num] = INITIAL_MARKER}
  new_board
end

def empty_squares(brd)
  brd.keys.select{|num| brd[num] == INITIAL_MARKER}
end

def prompt(message)
  puts "=> #{message}"
end

def player_places_piece(brd)
  square = ""
  loop do 
    prompt "Choose a square (1-9)"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, thats not a valid choice"
  end
  brd[square] = PLAYER_MARKER
  display_board brd
end

def computer_places_piece(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
  display_board brd
end

def board_full?(brd)
  empty_squares(brd) == []
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  winning_lines = [[1,2,3],[4,5,6],[7,8,9]] + #rows
                  [[1,4,7],[2,5,8],[3,6,9]] + #cols
                  [[1,5,9],[3,5,7]]           #diagnals
  winning_lines.each do |line|
    if brd[line[0]] == PLAYER_MARKER &&
       brd[line[1]] == PLAYER_MARKER &&
       brd[line[2]] == PLAYER_MARKER
       return 'Player'
    elsif brd[line[0]] == PLAYER_MARKER &&
       brd[line[1]] == PLAYER_MARKER &&
       brd[line[2]] == PLAYER_MARKER
      return 'Computer'
    end
  end
  nil
end 

def play_again?
 play_again = ''
 loop do
    prompt "Would you like to play again? (Y/N)"
    play_again = gets.chomp.downcase
    if ['y', 'n'].include?(play_again)
      play_again = play_again == 'y' ? true : false
    end
    break
  end
  return play_again
end


loop do
  board = initalize_board
  loop do
    display_board(board)
    player_places_piece(board)
    break if someone_won?(board) || board_full?(board)
    display_board(board)
    computer_places_piece(board)
    break if someone_won?(board) || board_full?(board)
  end

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt "It's a tie!"
  end
  break if play_again? == false
end






