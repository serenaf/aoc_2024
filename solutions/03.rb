# rubocop:disable all
module Day03
  class << self
    def part_one
      text = File.read("inputs/03/03_real.txt")
      sum = 0
      occurences = text.scan(/mul\(\d{1,3},\d{1,3}\)/)
      occurences.each do |occurence|
        numbers = occurence.scan(/\d+/).map(&:to_i)
        sum += numbers[0] * numbers[1]
      end
      puts sum
    end

    def part_two
      text = File.read("inputs/03/03_real.txt")
      sum = 0
      enabled = true
      disabled = false
      occurences = text.scan(/mul\(\d{1,3},\d{1,3}\)|do\(\)|don\'t\(\)/)
      occurences.each do |occurence|
        if occurence.match?(/do/)
          puts "setting to enabled"
          disabled = false
          enabled = true
        end
        if occurence.match?(/don\'t/)
          puts "setting to disabled"
          disabled = true
          enabled = false
        end
        if occurence.match?(/\d+/)
          "found number #{disabled} #{enabled}"
          numbers = occurence.scan(/\d+/).map(&:to_i)
          sum += numbers[0] * numbers[1] if enabled
        end
      end
      puts sum
    end
  end
end

Day03.part_two
