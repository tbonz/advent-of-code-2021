class LineSegment
  attr_reader :coordinates
  def initialize(segment)
    @first = segment.split(" -> ").first
    @last = segment.split(" -> ").last
    @coordinates = []
    generate_coordinates
  end

  def x1
    @first.split(",").first.to_i
  end

  def y1
    @first.split(",").last.to_i
  end

  def x2
    @last.split(",").first.to_i
  end

  def y2
    @last.split(",").last.to_i
  end

  def is_vertical?
    x1 == x2
  end

  def is_horizontal?
    y1 == y2
  end

  def generate_coordinates
    if is_horizontal?
      start = x1
      stop = x2
      if x1 > x2
        start = x2
        stop = x1
      end
      start.upto(stop).each do |val|
        @coordinates << [val.to_i,y1.to_i]
      end
    elsif is_vertical?
      start = y1
      stop = y2
      if y1 > y2
        start = y2
        stop = y1
      end
      start.upto(stop).each do |val|
        @coordinates << [x1.to_i,val.to_i]
      end
    else
      # this must be a 45
      
    end
  end
end

# read file
lines = File.read('input.txt')
coordinate_set = lines.split("\n")

# set up all line segments
line_segments = []
coordinate_set.each do |segment|
  line = LineSegment.new(segment)
  line_segments << line if line.is_horizontal? || line.is_vertical?
end

hash = Hash.new

line_segments.map(&:coordinates).each do |segment|
  segment.each do |point|
    if hash[point]
      hash[point] += 1
    else
      hash[point] = 1
    end
  end
end

puts "How many points overlap at least twice: #{hash.filter{|k,v| v >= 2}.count}"
