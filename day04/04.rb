def checksum_by_occurrences(string)
  string
    .each_char
    .with_object(Hash.new(0)) { |c, h| h.key?(c) ? h[c] += 1 : h[c] = 1 }
    .sort_by { |k, v| [-v, k] }
    .take(5)
    .map(&:first)
    .join
end

Room = Struct.new(:encrypted_name, :sector_id, :checksum)

rooms = File.readlines("04.input").map { |line|
  tokens = line.split(/[-\[\]\n]/)
  encrypted_name = tokens.slice(0..-3).join
  sector_id = tokens.slice(-2).to_i
  checksum = tokens.slice(-1)
  Room.new(encrypted_name, sector_id, checksum)
}

# Part 1
real_rooms = rooms.select { |r| checksum_by_occurrences(r.encrypted_name) == r.checksum }
sum = real_rooms.map(&:sector_id).reduce(:+)
puts "Part 1: sum of sector IDs of the real rooms: #{sum}"

# Part 2
DecryptedRoom = Struct.new(:decrypted_name, :sector_id)
class ShiftCipher
  def self.decrypt(letters, sector_id)
    DecryptedRoom.new(_rotate(letters, sector_id), sector_id)
  end

  def self._rotate(letters, times)
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    letters.tr(alphabet, alphabet.chars.rotate(times % 26).join)
  end
end

decrypted_rooms = real_rooms.map { |r| ShiftCipher.decrypt(r.encrypted_name, r.sector_id.to_i) }
north_pole_room = decrypted_rooms.select { |r| r.decrypted_name.include?("north") }.first
puts "Part 2: decrypted room's sector_id with north pole presents #{north_pole_room.sector_id}"

