

things = File.read("input.txt")
matrix = things.split.map{|row| row.split('').map(&:to_i)}

low_points = []
matrix.each_with_index do |row, row_index|
  row.each_with_index do |point, col_index|
    adjacent = []
    begin
      if row_index < (matrix.size - 1)
        adjacent << matrix[row_index + 1][col_index] # down
      end
      if row_index > 0
        adjacent << matrix[row_index - 1][col_index] # up
      end
      if col_index > 0
        adjacent << matrix[row_index][col_index - 1] # left
      end
      if col_index < (row.size - 1)
        adjacent << matrix[row_index][col_index + 1] # right
      end
    
      if adjacent.min > point
        low_points << point
      end
    rescue
      require 'pry'; binding.pry
    end
  end
end
puts "Lows: #{low_points}"
puts "Risk: #{low_points.map{|num| num + 1}.sum}"
# require 'pry'; binding.pry

