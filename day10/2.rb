openers = ["(", "[", "{", "<"]
closers = [")", "]", "}", ">"]

pairs = {
  "(" => ")",
  "[" => "]",
  "{" => "}",
  "<" => ">"
}

points = {
  ")" => 1,
  "]" => 2,
  "}" => 3,
  ">" => 4
}

total_scores = []

File.open("input.txt").each do |line|
  discarded = false
  open_chunks = []
  chars = line.split('')
  chars.each_with_index { |c, i|
    if openers.include? c
      open_chunks << c
    elsif closers.include? c
      open_char = open_chunks.pop
      if pairs[open_char] == c
        next
      else
        discarded = true
        break
      end
    end
  }
  if discarded == false
    # This line is incomplete, so work on finding the chars to close it up and add the score to total_scores.
    total = 0
    closing_chars = []
    while open_chunks.any? do
      closing_chars << pairs[open_chunks.pop]
    end
    closing_chars.each do |c|
      total = (total * 5 + points[c])
    end
    total_scores << total    
  end
end

puts "Score: #{total_scores.sort.slice(total_scores.size / 2)}"

