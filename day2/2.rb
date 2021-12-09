depth = 0
horizontal = 0
aim = 0

File.open("puzzle-1-input.txt").each_line do |line|
  cmd, val = line.split(" ")

  case cmd
  when "forward"
    horizontal += val.to_i
    depth += (aim * val.to_i)
  when "down"
    aim += val.to_i
  when "up"
    aim -= val.to_i
  end
end

puts "depth: #{depth}"
puts "horizontal: #{horizontal}"
puts "aim: #{aim}"

puts "answer: #{depth * horizontal}"