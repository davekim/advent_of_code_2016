Vector = Struct.new(:U, :R, :D, :L)

KEYPAD_VECTORS = {
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

class Button
  attr_reader :current

  def initialize(current: 5)
    @current = current
  end

  def press(direction)
    next_button = KEYPAD_VECTORS[@current].send(direction)
    if next_button
      @current = next_button
    end
  end
end


bathroom_code = []
button = Button.new(current: 5)

File.read("02.input").split("\n").each do |line|
  line.split("").each do |direction|
    button.press(direction)
  end

  bathroom_code << button.current
  button = Button.new(current: button.current)
end

puts bathroom_code.join
