rows = File.read("06.input").split("\n").map do |line|
  line.chomp.chars
end

columns = rows.transpose
corrected_using_most_common = columns.map do |column|
  column.max_by { |c| column.count(c) }
end

corrected_using_least_common = columns.map do |column|
  column.min_by { |c| column.count(c) }
end

puts "Part 1 - error corrected message: #{corrected_using_most_common.join}"
puts "Part 2 - error corrected message: #{corrected_using_least_common.join}"
