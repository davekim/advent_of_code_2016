module Triangle
  def self.valid?(a, b, c)
    (a + b > c) && (a + c > b) && (b + c > a)
  end
end

count = 0
File.read("03.input").split("\n").each do |line|
  a, b, c = line.split
  if Triangle.valid?(a.to_i, b.to_i, c.to_i)
    count += 1
  end
end

puts "Number of valid triangles is: #{count}"
