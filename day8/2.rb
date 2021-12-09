class Decoder
  def initialize(signal_patterns)
    @signal_patterns = signal_patterns
    @mappings = Hash.new
    @output_value = ""
  end

  def find_output_value(values)
    values.split(" ").each do |value|
      array = value.split('')
      answer = @mappings.keys.find{|key| key.sort == array.sort}
      @output_value += @mappings[answer]
    end
    @output_value
  end

  def decode_signals
    @mappings[number_one] =   "1"
    @mappings[number_four] =  "4"
    @mappings[number_seven] = "7"
    @mappings[number_eight] = "8"
    @mappings[number_six] =   "6"
    @mappings[number_nine] =  "9"
    @mappings[number_zero] =  "0"
    @mappings[number_three] = "3"
    @mappings[number_two] =   "2"
    @mappings[number_five] =  "5"
  end

  def number_one
    @signal_patterns.find{|s| s.size == 2}
  end

  def number_four
    @signal_patterns.find{|s| s.size == 4}
  end

  def number_seven
    @signal_patterns.find{|s| s.size == 3}
  end

  def number_eight
    @signal_patterns.find{|s| s.size == 7}
  end

  def number_three
    numbers_with_size_five.find{|s| (s - number_one).size == 3 }
  end

  def number_six
    numbers_with_size_six.find{|s| (number_one - s).size == 1 }
  end

  def number_nine
    numbers_for_nine_and_zero.find{|s| (number_four + s).uniq.size == 6 }
  end

  def number_zero
    numbers_for_nine_and_zero.find{|s| (number_four + s).uniq.size == 7 }
  end

  def number_two
    numbers_for_two_and_five.find{|s| (number_four + s).uniq.size == 7 }
  end

  def number_five
    numbers_for_two_and_five.find{|s| (number_four + s).uniq.size == 6 }
  end

  def numbers_with_size_six
    @signal_patterns.filter{|s| s.size == 6}
  end

  def numbers_with_size_five
    @signal_patterns.filter{|s| s.size == 5}
  end

  def numbers_for_nine_and_zero
    numbers_with_size_six.filter{|s| s != number_six}
  end

  def numbers_for_two_and_five
    numbers_with_size_five.filter{|s| s != number_three}
  end

end

output_values = []

File.foreach('input.txt') do |line|
  signal_pattern, output_value = line.split(" | ").map(&:strip)
  decoder = Decoder.new(signal_pattern.split(" ").map{|s| s.split('')})
  decoder.decode_signals
  output_values << decoder.find_output_value(output_value)
end

puts output_values.map(&:to_i).sum
