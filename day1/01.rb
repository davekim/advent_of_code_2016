require 'set'

class Direction
  def initialize
    @direction = ["N", "E", "S", "W"]
  end

  def turn(lr)
    case lr
    when "R"
      @direction = @direction.rotate
    when "L"
      @direction = @direction.rotate(-1)
    end
  end

  def current
    @direction.first
  end
end

Point = Struct.new(:x, :y) do
  def distance
    x.abs + y.abs
  end
end

module Location
  def self.change(direction, lr)
    case direction.current
    when "N"
      case lr
      when "R" then Point.new(1, 0)
      when "L" then Point.new(-1, 0)
      end
    when "E"
      case lr
      when "R" then Point.new(0, -1)
      when "L" then Point.new(0, 1)
      end
    when "S"
      case lr
      when "R" then Point.new(-1, 0)
      when "L" then Point.new(1, 0)
      end
    when "W"
      case lr
      when "R" then Point.new(0, 1)
      when "L" then Point.new(0, -1)
      end
    end
  end
end

class Traveler
  def initialize
    @direction = Direction.new
    @visited = Set.new
    @current = Point.new(0, 0)
  end

  def turn(blocks, lr)
    location = Location.change(@direction, lr)
    @direction.turn(lr)

    blocks.times do
      @current.x += location.x
      @current.y += location.y
      unless @visited.add?(@current)
        puts "Hmmm...I've been here before: #{@current}, distance: #{@current.distance}"
      end
    end
  end

  def blocks_away
    @current.distance
  end
end

traveler = Traveler.new
File.read("01.input").split(", ").each do |step|
  lr = step[0]
  blocks = step[1..-1].to_i
  traveler.turn(blocks, lr)
end

puts "Final distance #{traveler.blocks_away}"
