rows = File.read("06.input").split("\n").map do |line|
  line.chomp.chars
end

columns = rows.transpose
corrected = columns.map do |column|
  column.max_by { |c| column.count(c) }
end

puts "Part 1 - error corrected message: #{corrected.join}"
