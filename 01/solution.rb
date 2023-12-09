# day 1 part 1

rows = File.read("input.txt").split("\n")

NUMBER_REGEX = /\d/

def get_number(row)
  number = row.scan(/\d/).join('')

  puts "initial match number is #{number}"

  num = if number.length == 2
          number.to_i
        elsif number.length < 2
          (number * 2).to_i
        else
          (number[0] + number[-1]).to_i
        end

  puts "number is #{num}"
  num
end

sum = rows.sum { |row| get_number(row) }

puts sum
