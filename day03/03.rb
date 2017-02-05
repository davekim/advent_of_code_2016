module Triangle
  def self.valid?(a, b, c)
    (a + b > c) && (a + c > b) && (b + c > a)
  end

  def self.valid_from_array?(sides)
    valid?(sides[0].to_i, sides[1].to_i, sides[2].to_i)
  end
end

# Part 1
count = 0
File.read("03.input").split("\n").each do |line|
  a, b, c = line.split
  if Triangle.valid?(a.to_i, b.to_i, c.to_i)
    count += 1
  end
end

puts "Part 1: Number of valid \u25B3 is #{count}"

# Part 2
count = 0
t1 = []
t2 = []
t3 = []
File.read("03.input").split("\n").each.with_index(1) do |line, index|
  a, b, c = line.split

  t1 << a
  t2 << b
  t3 << c

  if (index % 3) == 0
    if Triangle.valid_from_array?(t1)
      count += 1
    end

    if Triangle.valid_from_array?(t2)
      count += 1
    end

    if Triangle.valid_from_array?(t3)
      count += 1
    end

    t1.clear
    t2.clear
    t3.clear
  end
end

puts "Part 2: Number of valid \u25B3 is #{count}"
