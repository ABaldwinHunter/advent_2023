# day 1 part 1


# file = 'sample.txt'
file = 'input.txt'
rows = File.read(file).split("\n")

WORD_TO_NUMBER = {
  'one' => 1,
  'two' => 2,
  'three' => 3,
  'four' => 4,
  'five' => 5,
  'six' => 6,
  'seven' => 7,
  'eight' => 8,
  'nine' => 9,
  'zero' => 0,
}

def extract_number(str)
  if str.length > 1
    WORD_TO_NUMBER[str]
  else
    str.to_i
  end
end

def get_number(row, matcher)
  numbers = row.scan(matcher)

  pair = [numbers.first, numbers.last]

  pair.map { |num| extract_number(num).to_s }.join('').to_i
end

def get_number_part_two(row)
  first_num  = row.match(NUMBER_AND_WORD_REGEX)[0]

  last_num = row.reverse.match(NUMBER_AND_WORD_REGEX_REVERSE)[0]

  if last_num.length > 1
    last_num = last_num.reverse
  end

  pair = [first_num, last_num]

  pair.map { |num| extract_number(num).to_s }.join('').to_i
end

# sum = rows.sum { |row| get_number(row, /\d/) }

# puts sum

NUMBER_AND_WORD_REGEX = /\d|one|two|three|four|five|six|seven|eight|nine/
NUMBER_AND_WORD_REGEX_REVERSE = /\d|eno|owt|eerht|ruof|evif|xis|neves|thgie|enin/

# part 2
#

part_two_sum = rows.sum { |row| get_number_part_two(row) }

puts part_two_sum

# 53866
