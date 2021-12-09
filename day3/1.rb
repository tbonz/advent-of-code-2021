matrix = []

File.open("input.txt").each_line do |number|
  matrix << number.strip.split("").map(&:to_i)
end

number_of_bits = matrix.first.size

gamma_rate = []
epsilon_rate = []

0.upto(number_of_bits - 1) do |index|
  one_bits = 0
  zero_bits = 0
  matrix.each do |arr|
    arr[index] == 1 ? one_bits += 1 : zero_bits += 1
  end
  if one_bits > zero_bits
    gamma_rate << 1
    epsilon_rate << 0
  else
    gamma_rate << 0
    epsilon_rate << 1
  end
end

puts "gamma_rate #{gamma_rate} #{gamma_rate.join.to_i(2)}"
puts "gamma_rate #{epsilon_rate} #{epsilon_rate.join.to_i(2)}"

puts "power_consumption #{gamma_rate.join.to_i(2) * epsilon_rate.join.to_i(2)}"