def checksum_by_occurrences(string)
  string
    .each_char
    .with_object(Hash.new(0)) { |c, h| h.key?(c) ? h[c] += 1 : h[c] = 1 }
    .sort_by { |k, v| [-v, k] }
    .take(5)
    .map(&:first)
    .join
end

result = 0
File.readlines("04.input").each do |line|
  tokens = line.split(/[-\[\]\n]/)
  encrypted_names = tokens.slice(0..-3).join
  sector_id = tokens.slice(-2).to_i
  checksum = tokens.slice(-1)

  if checksum_by_occurrences(encrypted_names) == checksum
    result += sector_id
  end
end

puts "Sum of sector IDs of the real rooms: #{result}"
