require 'csv'

module Direction

  NEXT_DIRECTION_AND_SIGN = {
    "N:R" => ["E", 1],
    "N:L" => ["W", -1],
    "E:R" => ["S", -1],
    "E:L" => ["N", 1],
    "S:R" => ["W", -1],
    "S:L" => ["E", 1],
    "W:R" => ["N", 1],
    "W:L" => ["S", -1],
  }

  def self.next(direction, turn)
    NEXT_DIRECTION_AND_SIGN.fetch("#{direction}:#{turn}").first
  end

  def self.sign(direction, turn)
    NEXT_DIRECTION_AND_SIGN.fetch("#{direction}:#{turn}").last
  end
end

class Traveler

  attr_reader :blocks_away

  def initialize
    @direction = "N"
    @blocks_away = 0
  end

  def turn_right(blocks)
    _turn(blocks, "R")
  end

  def turn_left(blocks)
    _turn(blocks, "L")
  end

  def _turn(blocks, turn)
    @blocks_away += blocks * Direction.sign(@direction, turn)
    @direction = Direction.next(@direction, turn)
  end
end

traveler = Traveler.new
File.read("01.input").split(", ").each do |step|
  direction = step[0]
  blocks = step[1..-1].to_i

  if direction == "R"
    traveler.turn_right(blocks)
  elsif direction == "L"
    traveler.turn_left(blocks)
  else
    raise "Invalid row in input #{row}"
  end
end

puts traveler.blocks_away
