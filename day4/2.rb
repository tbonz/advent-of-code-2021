
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

catch :take_me_out do
  all_numbers.each do |number|
    picked_numbers << number
    boards.each_with_index do |board, index|
      if board.winner?(picked_numbers)
        boards.delete(board)
      end
      if boards.size == 1
        throw :take_me_out
      end
    end
  end
end

picked_numbers = []
the_last_board = boards.first
catch :take_me_out do
  all_numbers.each do |number|
    picked_numbers << number
    puts picked_numbers.to_s
    if the_last_board.winner?(picked_numbers)
      puts "Score: #{the_last_board.score}"
      throw :take_me_out
    end
  end
end
