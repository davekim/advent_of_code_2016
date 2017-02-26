decompressed_file = ""
File.open("09.input") do |file|

  marker = ""
  capture_marker = false

  length = 0
  times = 0
  chars_to_repeat = ""

  file.each_char do |c|
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
        decompressed_file << (chars_to_repeat * times)

        # reset
        chars_to_repeat = ""
        times = 0
      end
    else
      decompressed_file << c
    end
  end
end

puts "Part 1: decompressed file length: #{decompressed_file.size}"
