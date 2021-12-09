class BasinRover
  def initialize(low_point, matrix)
    @matrix = matrix
    @low_point = low_point
    @basin = [low_point]
    @points_to_rove = [low_point]
  end

  def run
    while @points_to_rove.size > 0
      valid_points = find_points(@points_to_rove.pop)
      @basin = @basin + valid_points
      @points_to_rove = @points_to_rove + valid_points
    end
    # require 'pry';binding.pry
    return @basin.uniq
  end
  
  def find_points(point_to_inspect)
    response = []
    begin
      coordinate, value = point_to_inspect.split(":")
      x, y = coordinate.split(',').map(&:to_i)
      if x > 0 # look up
        response << "#{x-1},#{y}:#{@matrix[x-1][y]}" if @matrix[x-1][y] > value.to_i && @matrix[x-1][y] < 9
      end
      if x < (@matrix.size - 1) #look down
        response << "#{x+1},#{y}:#{@matrix[x+1][y]}" if @matrix[x+1][y] > value.to_i && @matrix[x+1][y] < 9
      end
      if y > 0 # look left
        response << "#{x},#{y-1}:#{@matrix[x][y-1]}" if @matrix[x][y-1] > value.to_i && @matrix[x][y-1] < 9
      end
      if y < (@matrix[0].size - 1) # look right
        response << "#{x},#{y+1}:#{@matrix[x][y+1]}" if @matrix[x][y+1] > value.to_i && @matrix[x][y+1] < 9
      end
      return response
    rescue
      require 'pry'; binding.pry
    end
  end
end

things = File.read("input.txt")
matrix = things.split.map{|row| row.split('').map(&:to_i)}

low_points = []
matrix.each_with_index do |row, row_index|
  row.each_with_index do |point, col_index|
    adjacent = []

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
      low_points << "#{row_index},#{col_index}:#{point}"
    end

  end
end

puts "Low pts: #{low_points}"
basins = []
low_points.each do |low_point|
  rover = BasinRover.new(low_point, matrix)
  basins << rover.run
end
puts "Basin product: #{basins.map{|b| b.size}.sort.last(3).reduce(&:*)}"
