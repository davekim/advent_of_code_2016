def abba?(string_to_check)
  string_to_check.chars.each_cons(4) do |s|
    return true if (s[0] + s[1] == s[3] + s[2]) && (s[3] != s[2])
  end
  return false
end

count = 0
File.readlines("07.input").each do |line|
  outside_with_i, inside_with_i = line.chomp.split(/[\[\]]/).each_with_index.partition { |c, index| index % 2 == 0 }

  outside = outside_with_i.map(&:first)
  inside = inside_with_i.map(&:first)

  if (outside.any? { |word| abba?(word) }) && (inside.none? { |word| abba?(word) })
    count += 1
  end
end

puts "Count #{count}"
