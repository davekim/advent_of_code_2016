class Screen

  COLUMNS = 50
  ROWS = 6

  def initialize
    # 2D array where indices are [row][column]
    @screen = (["." * COLUMNS] * ROWS).map(&:chars)
  end

  def rect(column, row)
    column.times do |c|
      row.times do |r|
        @screen[r][c] = "#"
      end
    end
  end

  def rotate_row(r, shift)
    row_before = @screen[r].dup
    COLUMNS.times do |c|
      c_shift_index = (c + shift) % COLUMNS
      @screen[r][c_shift_index] = row_before[c]
    end
  end

  def rotate_column(c, shift)
    col_before = @screen.transpose[c].dup
    ROWS.times do |r|
      r_shift_index = (r + shift) % ROWS
      @screen[r_shift_index][c] = col_before[r]
    end
  end

  def lit_pixels_count
    @screen.map { |row| row.count { |rc| rc == "#" }}.reduce(0, :+)
  end
end

screen = Screen.new

File.readlines("08.input").each do |line|

  tokens = line.split(" ")

  case tokens[0]
  when "rect"
    column, row = tokens[1].split("x").map(&:to_i)
    screen.rect(column, row)
  when "rotate"
    case tokens[1]
    when "row"
      row = tokens[2].split("=")[1].to_i
      num_pixels = tokens[4].to_i
      screen.rotate_row(row, num_pixels)
    when "column"
      col = tokens[2].split("=")[1].to_i
      num_pixels = tokens[4].to_i
      screen.rotate_column(col, num_pixels)
    end
  end
end

puts "Part 1: Number of lit pixels #{screen.lit_pixels_count}"
