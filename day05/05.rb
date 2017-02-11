require 'digest/md5'

door_id = File.read("05.input").strip

first_password = ""
second_password = []
index = 0

loop do
  guess = Digest::MD5.hexdigest("#{door_id}#{index}")

  if guess.start_with?("00000")
    puts "Part 1 found index: #{index}, guess: #{guess}"
    first_password << guess[5]

    if "01234567".include?(guess[5]) && second_password[guess[5].to_i].nil?
      puts "Part 2 found index: #{guess[5]}, letter: #{guess[6]}"
      second_password[guess[5].to_i] = guess[6]
    end
  end

  index += 1
  break if (first_password.length >= 8 && second_password.compact.length == 8)
end

puts "Part 1 password: #{first_password[0..7]}"
puts "Part 2 password: #{second_password.join}"





