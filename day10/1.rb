openers = ["(", "[", "{", "<"]
closers = [")", "]", "}", ">"]

pairs = {
  "(" => ")",
  "[" => "]",
  "{" => "}",
  "<" => ">"
}

score = []

File.open("input.txt").each do |line|
  open_chunks = []
  chars = line.split('')
  chars.each { |c|
    begin
      if openers.include? c
        open_chunks << c
      elsif closers.include? c
        open_char = open_chunks.pop
        if pairs[open_char] == c
          next
        else
          score << c
          raise "Expected #{pairs[open_char]}, but got a #{c}"
        end
      end
    rescue => e
      puts e
    end
  }
end

points = {
  ")" => 3,
  "]" => 57,
  "}" => 1197,
  ">" => 25137
}
total = 0
score.tally.each do |char,num|
  total += points[char] * num
end

puts total