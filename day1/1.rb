increase = 0
decrease = 0
previous_val = nil
STDIN.each_with_index do |line|
  current_val = line
  if previous_val.nil?
    previous_val = current_val
  else
    puts "prev: #{previous_val.class}"
    puts "curr: #{current_val.class}"
    if current_val.to_i < previous_val.to_i
      decrease += 1
    elsif current_val.to_i > previous_val.to_i
      increase += 1
    end
    previous_val = current_val
  end
end

puts "increases: #{increase}"
puts "descreases: #{decrease}"