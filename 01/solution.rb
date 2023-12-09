# day 1 part 1

rows = File.read("input.txt").split("\n")

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

  pair.map { |num| num.to_s }.join('').to_i
end

sum = rows.sum { |row| get_number(row, /\d/) }

puts sum

NUMBER_AND_WORD_REGEX = /\d|\one|\two|\three|\four|\five|\six|\seven|\eight|\nine|\zero/

# part 2
#

part_two_sum = rows.sum { |row| get_number(row, NUMBER_AND_WORD_REGEX) }

puts part_two_sum
