def valid?(a, b, c)
  (a + b > c)
end

lines = File.read("03.input").split("\n").map { |line| line.split.map(&:to_i) }

# Part 1
count = lines.map.count { |sides| valid?(*sides.sort) }
puts "Part 1: Number of valid \u25B3 is #{count}"

# Part 2
count = lines.each_slice(3).map { |rows| rows.transpose.count { |sides| valid?(*sides.sort) }}.reduce(:+)
puts "Part 2: Number of valid \u25B3 is #{count}"
