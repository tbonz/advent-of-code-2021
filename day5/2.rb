class LineSegment
  attr_reader :coordinates
  def initialize(segment)
    @point_a = segment.split(" -> ").first
    @point_b = segment.split(" -> ").last
    @coordinates = []
  end

  def x1
    @point_a.split(",").first.to_i
  end

  def y1
    @point_a.split(",").last.to_i
  end

  def x2
    @point_b.split(",").first.to_i
  end

  def y2
    @point_b.split(",").last.to_i
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
        @coordinates << [val,y1]
      end
    elsif is_vertical?
      start = y1
      stop = y2
      if y1 > y2
        start = y2
        stop = y1
      end
      start.upto(stop).each do |val|
        @coordinates << [x1,val]
      end
    else
      # this is a 45 (ie. 6,4 -> 2,0)
      x_step = x1 > x2 ? -1 : 1
      y_step = y1 > y2 ? -1 : 1
      x = x1
      y = y1
      while x != x2
        @coordinates << [x, y]
        x += x_step
        y += y_step
      end
      @coordinates << [x, y]
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
  line.generate_coordinates
  line_segments << line #if line.is_horizontal? || line.is_vertical?
end
require 'pry';binding.pry
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

puts "How many points overlap?: #{hash.filter{|k,v| v >= 2}.count}"
#17787