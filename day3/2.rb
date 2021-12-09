matrix = []

File.open("input.txt").each_line do |number|
  matrix << number.strip.split("").map(&:to_i)
end
number_of_bits = matrix.first.size

gamma_rate = []
epsilon_rate = []

o2_rating = matrix


index = 0
while o2_rating.size > 1 do
  one_bits = 0
  zero_bits = 0
  o2_rating.each do |arr|
    arr[index] == 1 ? one_bits += 1 : zero_bits += 1
  end
  if one_bits > zero_bits
    o2_rating = o2_rating.select{|arr| arr[index] == 1}
  elsif zero_bits > one_bits
    o2_rating = o2_rating.select{|arr| arr[index] == 0}
  else
    o2_rating = o2_rating.select{|arr| arr[index] == 1}
  end
  index +=1
end



scrubber_rating = matrix
index = 0
while scrubber_rating.size > 1 do
  one_bits = 0
  zero_bits = 0
  scrubber_rating.each do |arr|
    arr[index] == 1 ? one_bits += 1 : zero_bits += 1
  end
  if one_bits < zero_bits
    scrubber_rating = scrubber_rating.select{|arr| arr[index] == 1}
  elsif zero_bits < one_bits
    scrubber_rating = scrubber_rating.select{|arr| arr[index] == 0}
  else
    scrubber_rating = scrubber_rating.select{|arr| arr[index] == 0}
  end
  index +=1
end

puts "o2 rating: #{o2_rating.to_s}"
puts "scrubber: #{scrubber_rating.to_s}"

puts "power_consumption #{o2_rating.join.to_i(2) * scrubber_rating.join.to_i(2)}"