
# METHODS
# =======
# Takes a board as a string in the format
# you see in the puzzle file. Returns
# something representing a board after
# your solver has tried to solve it.
# How you represent your board is up to you!
def make_board(board_string)
  board = []
  board_string.split('').each_slice(9) {|row| board << row}
  return board
end

board_string = File.readlines('sudoku_puzzles.txt').first.chomp
sudoku_board = make_board(board_string)
# p sudoku_board

def make_columns(board)
  board.dup.transpose
end

sudoku_columns = make_columns(sudoku_board)
#p sudoku_columns

def make_blocks(board)
  blocks = []
  iterators = (0...board.length).to_a.each_slice(3).to_a
  iterators.each do |a|
    iterators.each do |b|
      a.each do |x|
        b.each do |y|
          blocks << board[x][y]
        end
      end
    end
  end
  block = blocks.each_slice(9).to_a
end

sudoku_blocks = make_blocks(sudoku_board)
#p sudoku_blocks

def solve(board_string)
end

# Returns a boolean indicating whether
# or not the provided board is solved.
# The input board will be in whatever
# form `solve` returns.
def solved?(board)
  # This will be true if all the elements in the board array are integers. This means that in our possibility array, if we flatten it, it should be completely empty.
end

# Takes in a board in some form and
# returns a _String_ that's well formatted
# for output to the screen. No `puts` here!
# The input board will be in whatever
# form `solve` returns.
def pretty_board(board)
end

=begin
board = [
["1", "-" , "5", "8", "-", "2", "-", "-", "-"],
["-", "9", "-", "-", "7", "6", "4", "-", "5"],
["2", "-", "-", "4", "-", "-", "8", "1", "9"],
["-", "1", "9", "-", "-", "7", "3", "-", "6"],
["7", "6", "2", "-", "8", "3", "-", "9", "-"],
["-", "-", "-", "-", "6", "1", "-", "5", "-"],
["-", "-", "7", "6", "-", "-", "-", "3", "-"],
["4", "3", "-", "-", "2", "-", "5", "-", "1"],
["6", "-", "-", "3", "-", "8", "9", "-", "-"]]

columns = [
["1", "-", "2", "-", "7", "-", "-", "4", "6"],
["-", "9", "-", "1", "6", "-", "-", "3", "-"],
["5", "-", "-", "9", "2", "-", "7", "-", "-"],
["8", "-", "4", "-", "-", "-", "6", "-", "3"],
["-", "7", "-", "-", "8", "6", "-", "2", "-"],
["2", "6", "-", "7", "3", "1", "-", "-", "8"],
["-", "4", "8", "3", "-", "-", "-", "5", "9"],
["-", "-", "1", "-", "9", "5", "3", "-", "-"],
["-", "5", "9", "6", "-", "-", "-", "1", "-"]]

blocks = [
["1", "-", "5", "-", "9", "-", "2", "-", "-"],
["8", "-", "2", "-", "7", "6", "4", "-", "-"],
["-", "-", "-", "4", "-", "5", "8", "1", "9"],
["-", "1", "9", "7", "6", "2", "-", "-", "-"],
["-", "-", "7", "-", "8", "3", "-", "6", "1"],
["3", "-", "6", "-", "9", "-", "-", "5", "-"],
["-", "-", "7", "4", "3", "-", "6", "-", "-"],
["6", "-", "-", "-", "2", "-", "3", "-", "8"],
["-", "3", "-", "5", "-", "1", "9", "-", "-"]]
=end

numbers = ["1","2","3","4","5","6","7","8","9"]
possible_valuesx = []

def evaluate(board, columns, block, numbers, possible_values)
  i = 0
  possible_values = board.dup
  while i < 20 do
  element_counter = 0
  row_counter = 0
  block_setter = 0
    board.each_with_index do |row, index_x|
      row.each_with_index do |element, index_y|
        #puts "Element is #{element}"
        # This 'block-loop counter makes sure that the correct block is used (it cuts off by three instead of going over the whole row)

        if element_counter == 3
          if row_counter == 3
            block_setter += 1
            row_counter = 0
          end
          row_counter +=1
          element_counter = 0
        end
        element_counter += 1

        #puts "The setter is: #{block_setter}"
        if element == "-"
          possibilities = numbers.dup
          #puts "block index is: #{block_setter}"
          #puts "The current block is: #{block[block_setter]}"
          block[block_setter].each do |number|
            possibilities.reject!{|x| x == number}
          end
          board[index_x].each do |number|
            possibilities.reject!{|x| x == number}
          end
          columns[index_y].each do |number|
            possibilities.reject!{|x| x == number}
          end
         if possibilities.length == 1
           board[index_x][index_y] = possibilities[0]
           #possible_values[index_x][index_y] = possibilities[0]
          else
            board[index_x][index_y] = "-"
            #possible_values[index_x][index_y] = possibilities
         end
        end
      end
    end
    p board
    #p possible_values
    i += 1
  end
end
p sudoku_board
evaluate(sudoku_board, sudoku_columns, sudoku_blocks, numbers, possible_valuesx)

# # RESULTS
# # ============

=begin
Original
[["1", "-", "5", "8", "-", "2", "-", "-", "-"], 5 empty
["-", "9", "-", "-", "7", "6", "4", "-", "5"],  4 empty
["2", "-", "-", "4", "-", "-", "8", "1", "9"],  4 empty
["-", "1", "9", "-", "-", "7", "3", "-", "6"],  4 empty
["7", "6", "2", "-", "8", "3", "-", "9", "-"],  3 empty
["-", "-", "-", "-", "6", "1", "-", "5", "-"],  6 empty
["-", "-", "7", "6", "-", "-", "-", "3", "-"],  6 empty
["4", "3", "-", "-", "2", "-", "5", "-", "1"],  4 empty
["6", "-", "-", "3", "-", "8", "9", "-", "-"]]  5 empty

1 Iteration
[["1", "-", "5", "8", "-", "2", "-", "-", "-"], 5 empty
["-", "9", "-", "1", "7", "6", "4", "-", "5"],  3 empty - Min 1
["2", "5", "3", "4", "-", "-", "8", "1", "9"],  2 empty - Min 2
["-", "1", "9", "5", "4", "7", "3", "8", "6"],  1 empty - Min 3
["7", "6", "2", "5", "8", "3", "-", "9", "4"],  1 empty - Min 2
["9", "-", "4", "-", "6", "1", "-", "5", "-"],  4 empty - Min 2
["8", "-", "7", "6", "-", "-", "-", "3", "2"],  4 empty - Min 2
["4", "3", "8", "-", "2", "9", "5", "7", "1"],  1 empty - Min 3
["6", "-", "-", "3", "4", "8", "9", "-", "-"]]  4 empty - Min 1

5 Iterations
[["1", "-", "5", "8", "-", "2", "-", "-", "-"], 5 empty - N/A
["-", "9", "-", "1", "7", "6", "4", "-", "5"],  3 empty - N/A
["2", "5", "3", "4", "-", "-", "8", "1", "9"],  2 empty = N/A
["-", "1", "9", "5", "4", "7", "3", "8", "6"],  1 empty - N/A
["7", "6", "2", "5", "8", "3", "-", "9", "4"],  1 empty - N/A
["9", "2", "4", "7", "6", "1", "-", "5", "8"],  1 empty - Min 3
["8", "4", "7", "6", "-", "-", "1", "3", "2"],  2 empty - Min 2
["4", "3", "8", "-", "2", "9", "5", "7", "1"],  1 empty - N/A
["6", "-", "1", "3", "4", "8", "9", "-", "-"]]  3 empty - Min 1

20 Iterations
[["1", "-", "5", "8", "-", "2", "-", "-", "-"], 5 empty
["-", "9", "-", "1", "7", "6", "4", "-", "5"],  3
["2", "5", "3", "4", "-", "-", "8", "1", "9"],  2
["-", "1", "9", "5", "4", "7", "3", "8", "6"],  1
["7", "6", "2", "5", "8", "3", "-", "9", "4"],  1
["9", "2", "4", "7", "6", "1", "-", "5", "8"],  1
["8", "4", "7", "6", "-", "-", "1", "3", "2"],  2
["4", "3", "8", "-", "2", "9", "5", "7", "1"],  1
["6", "-", "1", "3", "4", "8", "9", "-", "-"]]  3
=end
