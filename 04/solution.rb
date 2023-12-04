# day 4
#

file = 'input.txt'
cards = File.read(file).split("\n")

def get_hits(card)
  contents = card.split(":").last

  winning, mine = contents.split("|")

  winning_numbers = winning.split(" ").map(&:strip).map(&:to_i)

  my_numbers = mine.split(" ").map(&:strip).map(&:to_i)

  hits = 0

  winning_numbers.each do |number|
    hits += 1 if my_numbers.include?(number)
  end

  hits
end

def points(card)
  hits = get_hits(card)

  if hits == 0
    0
  elsif hits == 1
    1
  else
    1 * 2**(hits - 1)
  end
end

# part 1
#
puts cards.sum { |card| points(card) }

# part 2
#
# winning scratch cards
#
hits_matrix = {}

cards.each.with_index do |card, i|
  hits_matrix[i] = get_hits(card)
end

MATRIX = hits_matrix

def gained_cards(card_number)
  if card_number > 200
    0
  else
    if MATRIX[card_number] == 0
      0
    else
      hits = MATRIX[card_number]

      next_card = card_number + 1
      last = card_number + hits

      hits + (next_card..(last)).sum { |card| gained_cards(card) }
    end
  end
end

total = 201 # to start

MATRIX.keys.each.with_index do |card_number, i|
  total += gained_cards(card_number)
end

puts total

