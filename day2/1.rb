depth = 0
horizontal = 0

File.open("puzzle-1-input.txt").each_line do |line|
  cmd, val = line.split(" ")

  case cmd
  when "forward"
    horizontal += val.to_i
  when "down"
    depth += val.to_i
  when "up"
    depth -= val.to_i
  end
end

puts "depth: #{depth}"
puts "horizontal: #{horizontal}"

puts "answer: #{depth * horizontal}"depth = 0
horizontal = 0

File.open("puzzle-1-input.txt").each_line do |line|
  cmd, val = line.split(" ")

  case cmd
  when "forward"
    horizontal += val.to_i
  when "down"
    depth += val.to_i
  when "up"
    depth -= val.to_i
  end
end

puts "depth: #{depth}"
puts "horizontal: #{horizontal}"

puts "answer: #{depth * horizontal}"