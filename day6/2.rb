init = File.read('input.txt')
fish = init.split(",").map(&:to_i)
0.upto(256).each do |day|
  puts "Day#{day}: Size => #{fish.size}"
  day += 1
  fish.map! do |f|
    if f == 0
      fish << 9
      f = 7
    end
    f -= 1
  end
end
