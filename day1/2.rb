three_measurement_sums = []

File.read("input.txt").split.each.each_cons(3) do |one, two, three|
  three_measurement_sums << one.to_i + two.to_i + three.to_i
end

increases = 0

three_measurement_sums.each.each_cons(2) do |prev, curr|
  increases += 1 if curr.to_i > prev.to_i
end

puts increases