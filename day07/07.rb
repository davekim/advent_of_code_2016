def abba?(word)
  word.chars.each_cons(4) do |s|
    return true if (s[0] + s[1] == s[3] + s[2]) && (s[3] != s[2])
  end
  return false
end

def find_abas(word)
  abas = []
  word.chars.each_cons(3) do |s|
    if aba?(s)
      abas << s.join
    end
  end
  abas
end

def aba?(s)
  (s[0] == s[2]) && (s[0] != s[1])
end

def bab?(word, abas)
  word.chars.each_cons(3) do |s|
    abas.each do |aba|
      return true if (s[0] == aba[1]) && (s[1] == aba[0]) && (s[2] == aba[1])
    end
  end
  return false
end

tls_count = 0
ssl_count = 0

File.readlines("07.input").each do |line|
  outside_with_i, inside_with_i = line.chomp.split(/[\[\]]/).each_with_index.partition { |c, index| index % 2 == 0 }

  outside = outside_with_i.map(&:first)
  inside = inside_with_i.map(&:first)

  if (outside.any? { |word| abba?(word) }) && (inside.none? { |word| abba?(word) })
    tls_count += 1
  end

  abas = outside.map { |word| find_abas(word) }.flatten
  if inside.any? { |word| bab?(word, abas) }
    ssl_count += 1
  end
end

puts "Part 1: TLS count #{tls_count}"
puts "Part 2: SSL count #{ssl_count}"
