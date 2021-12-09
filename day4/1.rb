
class BingoBoard
  attr_reader :score

  def initialize(board)
    @board = board
    @score  = 0
  end

  def winner?(picked_numbers)
    @board.each do |row|
      if (row - picked_numbers).empty?
        @score = (@board - [row]).flatten.reject{|val| picked_numbers.include?(val)}.sum * picked_numbers.last
        return true
      end
    end
    @board.transpose.each do |col|
      if (col - picked_numbers).empty?
        @score = (@board - [col]).flatten.reject{|val| picked_numbers.include?(val)}.sum * picked_numbers.last
        return true
      end
    end
    false
  end

  def to_s
    "board: #{@board.to_s}"
  end
end

numbers = []
boards = []

all_numbers = File.open('input.txt') {|f| f.readline}.split(",").map(&:to_i)

File.open("input.txt").drop(1).each_slice(6).with_index do |board,index|
  bingo_board = board.map{|row| row.split(" ")}.reject(&:empty?)
                     .map{|row| row.map(&:to_i)}
  boards << BingoBoard.new(bingo_board)
end

puts "numbers: #{numbers.to_s}"

picked_numbers = []
winning_board_index = nil

catch :take_me_out do
  all_numbers.each do |number|
    picked_numbers << number
    puts picked_numbers.to_s
    boards.each_with_index do |board, index|
      if board.winner?(picked_numbers)
        winning_board_index = index
        throw :take_me_out
      end
      if boards.size == 1
        require 'pry';binding.pry
      end
    end
  end
end

puts "Score: #{boards[winning_board_index].score}"
