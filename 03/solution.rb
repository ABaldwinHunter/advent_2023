# file = File.read("input.txt")
file = File.read("sample.txt")

rows = file.split("\n") # [ "fsdkflksdjf", "zdfsfsdf"]
grid = rows.map { |row| row.split("") }

# walk the grid, checking if we're on a number, finding the perimeter
# and seeing if any of the perimeter is a symbol
#

row_coord = 0
col_coord = 0

max_row = rows.length - 1
max_col = rows.first.length - 1

numbers = [] # [number, start_cooords, end_coords]

while row_coord <= max_row do

  curr_number_start = nil
  curr_number_end = nil
  curr_number = ''

  while col_coord <= max_col do
    curr_square = grid[row_coord][col_coord]

    if curr_square.match(/\d/)
      if curr_number_start.nil?
        curr_number_start = [row_coord, col_coord]
      end

      curr_number += curr_square

      if (col_coord == max_col)
        curr_number_end = [row_coord, col_coord]
      end
    else
      if curr_number != '' # number ended
        curr_number_end = [row_coord, (col_coord - 1)]
      else
        # do nothing
      end
    end

    if curr_number_end != nil
      numbers << [curr_number.to_i, curr_number_start, curr_number_end]
      curr_number = ''
      curr_number_start = nil
      curr_number_end = nil
    end

    col_coord += 1
  end

  col_coord = 0
  row_coord += 1
end

pp numbers




