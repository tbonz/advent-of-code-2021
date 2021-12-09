output_values = []
File.foreach('input.txt') do |line|
  signal_patterns, output_value = line.split(" | ").map(&:strip)
  output_values << output_value
end

unique_segments = []
output_values.each do |val|
  segments = val.split(" ")
  segments.each{|s| unique_segments << s if [2,3,4,7].include?(s.size)}
end

puts unique_segments.size
puts unique_segments.to_s
