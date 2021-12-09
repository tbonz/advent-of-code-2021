crabs = File.read('input.txt').split(',').map(&:to_i)
 
optimal_position = crabs.min
min_fuel = 1_000_000_000

crabs.min.upto(crabs.max).each do |position|
  fuel = 0
  crabs.each do |crab|
    fuel += (crab - position).abs
  end
  if fuel < min_fuel
    optimal_position = position
    min_fuel = fuel
  end
end

puts "Fuel: #{min_fuel}"
puts "Position: #{optimal_position}"