file = File.read("input.txt")
# file = File.read("sample.txt")

rows = file.split("\n") # [ "fsdkflksdjf", "zdfsfsdf"]
grid = rows.map { |row| row.split("") }

# walk the grid, checking if we're on a number, finding the perimeter
# and seeing if any of the perimeter is a symbol
#

row_coord = 0
col_coord = 0

MAX_ROW = rows.length - 1
MAX_COL = rows.first.length - 1

numbers = [] # [number, start_cooords, end_coords]

while row_coord <= MAX_ROW do

  curr_number_start = nil
  curr_number_end = nil
  curr_number = ''

  while col_coord <= MAX_COL do
    curr_square = grid[row_coord][col_coord]

    if curr_square.match(/\d/)
      if curr_number_start.nil?
        curr_number_start = [row_coord, col_coord]
      end

      curr_number += curr_square

      if (col_coord == MAX_COL)
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

# pp numbers
#

# then, iterate through the numbers and select any with symbols adjacent
#

def get_adjacent_squares(number_with_data)
  number = number_with_data.first
  start_coords = number_with_data[1] # row, col
  end_coords = number_with_data[2]

  row = start_coords[0]
  cols = [start_coords[1], end_coords[1]]

  positions_to_check = []

  # one to the left
  positions_to_check << [row, (start_coords[1] - 1)] unless start_coords[1] == 0
  # one to the right
  positions_to_check << [row, (end_coords[1] + 1)] unless end_coords[1] == MAX_COL

  cols = Range.new(start_coords[1], end_coords[1]).to_a

  # above
  above = cols.map { |col| [(row - 1), col] }
  positions_to_check += above if row != 0
  # below
  below = cols.map { |col| [(row + 1), col] }
  positions_to_check += below if row != MAX_ROW

  # diagonal - 4

  diags = [
    [(row - 1), start_coords[1] - 1],
    [(row - 1), end_coords[1] + 1],
    [(row + 1), start_coords[1] - 1],
    [(row + 1), end_coords[1] + 1],
  ]

  cleaned_diags = diags.reject { |pair| pair.first < 0 || pair.first > MAX_ROW || pair.last < 0 || pair.last > MAX_COL }

  positions_to_check += cleaned_diags
end

sum = 0

numbers.each do |number_with_data|
  adjacent_coords = get_adjacent_squares(number_with_data)

  hit = adjacent_coords.detect do |coords|

    square = grid[coords.first][coords.last]

    square != '.' && !['123456789'].include?(square) # then special char
  end

  sum += number_with_data.first if hit
end

puts sum

# first attempt 527252 - too high (meanwhile the sample is correct!)
#
# second attempt 525181 - correct! (problem was no filtering out diags with the reject)
#

# part two - gear ratio
#
# first get all of the stars
#
# then see how many numbers each touches
#

stars = []

col_coord = 0
row_coord = 0

while row_coord <= MAX_ROW do
  while col_coord <= MAX_COL do
    if grid[row_coord][col_coord] == '*'
      stars << [row_coord, col_coord]
    end

    col_coord += 1
  end

  col_coord = 0
  row_coord += 1
end

numbers_touching_stars = {} # star_coords => [number 1, number 2 ...]

numbers.each do |number_with_data|
  adjacent_coords = get_adjacent_squares(number_with_data)

  adjacent_coords.each do |coords|
    square = grid[coords.first][coords.last]

    if square == '*'
      numbers_touching_stars[coords] ||= []
      numbers_touching_stars[coords] << number_with_data.first
    end
  end
end

gears = numbers_touching_stars.select { |star_coord, adjacent_numbers| adjacent_numbers.length == 2 }

total = gears.map { |coords, numbers| numbers.first * numbers.last }.sum

puts total
