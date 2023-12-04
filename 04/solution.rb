# day 4
#

file = 'input.txt'
cards = File.read(file).split("\n")

def points(card)
  contents = card.split(":").last

  winning, mine = contents.split("|")

  winning_numbers = winning.split(" ").map(&:strip).map(&:to_i)

  my_numbers = mine.split(" ").map(&:strip).map(&:to_i)

  hits = 0

  winning_numbers.each do |number|
    hits += 1 if my_numbers.include?(number)
  end

  if hits == 0
    0
  elsif hits == 1
    1
  else
    1 * 2**(hits - 1)
  end
end

puts cards.sum { |card| points(card) }

