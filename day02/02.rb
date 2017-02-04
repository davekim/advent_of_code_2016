Vector = Struct.new(:U, :R, :D, :L)

PART_ONE_KEYPAD_VECTORS = {
  1 => Vector.new(nil, 2, 4, nil),
  2 => Vector.new(nil, 3, 5, 1),
  3 => Vector.new(nil, nil, 6, 2),
  4 => Vector.new(1, 5, 7, nil),
  5 => Vector.new(2, 6, 8, 4),
  6 => Vector.new(3, nil, 9, 5),
  7 => Vector.new(4, 8, nil, nil),
  8 => Vector.new(5, 9, nil, 7),
  9 => Vector.new(6, nil, nil, 8)
}

PART_TWO_KEYPAD_VECTORS = {
  1 => Vector.new(nil, nil, 3, nil),
  2 => Vector.new(nil, 3, 6, nil),
  3 => Vector.new(1, 4, 7, 2),
  4 => Vector.new(nil, nil, 8, 3),
  5 => Vector.new(nil, 6, nil, nil),
  6 => Vector.new(2, 7, "A", 5),
  7 => Vector.new(3, 8, "B", 6),
  8 => Vector.new(4, 9, "C", 7),
  9 => Vector.new(nil, nil, nil, 8),
  "A" => Vector.new(6, "B", nil, nil),
  "B" => Vector.new(7, "C", "D", "A"),
  "C" => Vector.new(8, nil, nil, "B"),
  "D" => Vector.new("B", nil, nil, nil)
}

class Keypad
  attr_accessor :current

  def initialize(current, keypad_vectors)
    @current = current
    @keypad_vectors = keypad_vectors
  end

  def press_button(direction)
    next_button = @keypad_vectors[@current].send(direction)
    if next_button
      @current = next_button
    end
  end
end


bathroom_code_part_one = []
bathroom_code_part_two = []

keypad_one = Keypad.new(5, PART_ONE_KEYPAD_VECTORS)
keypad_two = Keypad.new(5, PART_TWO_KEYPAD_VECTORS)

File.read("02.input").split("\n").each do |line|
  line.split("").each do |direction|
    keypad_one.press_button(direction)
    keypad_two.press_button(direction)
  end

  bathroom_code_part_one << keypad_one.current
  bathroom_code_part_two << keypad_two.current
end

puts "Part 1 bathroom code: #{bathroom_code_part_one.join}"
puts "Part 2 bathroom code: #{bathroom_code_part_two.join}"
