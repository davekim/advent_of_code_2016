# input = "(3x3)XYZ"
# input = "X(8x2)(3x3)ABCY"
# input = "(27x12)(20x12)(13x14)(7x10)(1x12)A"
# input = "(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN"
input = File.read("09.input")

class Day9
  def self.decompress(input, deep)
    marker = ""
    capture_marker = false

    length = 0
    times = 0
    chars_to_repeat = ""

    decompressed_file = ""

    input.each_char do |c|
      next if c == "\n"

      if c == "(" && length == 0
        capture_marker = true
      elsif c != ")" && capture_marker
        marker << c
      elsif c == ")" && length == 0
        length, times = marker.split("x").map(&:to_i)

        # reset
        capture_marker = false
        marker = ""
      elsif length > 0
        chars_to_repeat << c
        length -= 1
        if length == 0
          if deep && chars_to_repeat.include?("(")
            decompressed_file << decompress(chars_to_repeat, true) * times
          else
            decompressed_file << (chars_to_repeat * times)
          end

          # reset
          chars_to_repeat = ""
          times = 0
        end
      else
        decompressed_file << c
      end
    end

    decompressed_file
  end
end

def shallow_decompress(input)
  Day9.decompress(input, false)
end

def deep_decompress(input)
  Day9.decompress(input, true)
end

# 70186
puts "Part 1: shallow decompressed file length: #{shallow_decompress(input).size}"

# 10915059201
puts "Part 2: deep decompressed file length: #{deep_decompress(input).size}"
