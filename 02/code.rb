# only 12 red cubes, 13 green cubes, and 14 blue cubes
#
# which games possible
#
# file = 'sample.txt'
# file = "input.txt"

games = File.read("input.txt").split("\n")

def game_possible?(game)
  results = game.split(": ").last

  throws = results.split("; ")

  throws.all? { |throw| throw_possible?(throw) }
end

def throw_possible?(throw)
  infos = throw.split(", ")

  infos.each do |number_and_color|
    parts = number_and_color.split(" ")

    number = parts.first.to_i
    color = parts.last

    if !['green', 'red', 'blue'].include? color
      return false
    end

    case color
    when 'green'
      return false if number > 13
    when 'blue'
      return false if number > 14
    when 'red'
      return false if number > 12
    end
  end
end

games =  games.select { |game| game_possible?(game) }

ids = games.map { |game| game.split(":").first.split("Game ").last.to_i }

puts ids.sum


# Part 2 find the power
#
#

def get_power(game)
  results = game.split(": ").last
  throws = results.split("; ")

  minima = { 'red' => 0, 'green' => 0, 'blue' => 0}

  throws.each do |throw|
    infos = throw.split(", ")

    infos.each do |number_and_color|
      parts = number_and_color.split(" ")

      number = parts.first.to_i
      color = parts.last

      if number > minima[color]
        minima[color] = number
      end
    end
  end

  puts minima

  power = minima['red'] * minima['blue'] * minima['green']
end

powers = games.map { |game| get_power(game) }

puts powers.sum

