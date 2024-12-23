module Day05
  class << self
    def part_one
      dependencies = Hash.new { |h, k| h[k] = [] }
      File.readlines("inputs/05/05_dependencies.txt").each do |line|
        number1, number2 = line.split("|").map(&:to_i)
        if dependencies[number1]
          dependencies[number1] << number2
        else
          dependencies[number1] = [number2]
        end
      end
      valid_lines = []
      File.readlines("inputs/05/05_numbers.txt").each do |line|
        valid = true
        numbers = line.strip.split(",").map(&:to_i)
        numbers.each_with_index do |number, index|
          break unless valid
          for i in index+1..numbers.length-1
            break unless valid
            if dependencies[numbers[index]].include?(numbers[i])
              valid = true
            else
              valid = false
            end
          end
        end
        valid_lines << line if valid
        puts valid_lines
      end
      result = valid_lines.map { |line| Day05.find_middle_number(line.strip.split(",").map(&:to_i)) }.sum
      puts result
    end

    def part_two
      dependencies = Hash.new { |h, k| h[k] = [] }
      File.readlines("inputs/05/05_dependencies_real.txt").each do |line|
        number1, number2 = line.split("|").map(&:to_i)
        if dependencies[number1]
          dependencies[number1] << number2
        else
          dependencies[number1] = [number2]
        end
      end
      valid_lines = []
      File.readlines("inputs/05/05_numbers_real.txt").each do |line|
        valid = true
        numbers = line.strip.split(",").map(&:to_i)
        numbers.each_with_index do |number, index|
          break unless valid
          for i in index+1..numbers.length-1
            break unless valid
            if dependencies[numbers[index]].include?(numbers[i])
              valid = true
            else
              valid = false
            end
          end
        end
        valid_lines << line if valid
      end
      invalid_lines = File.readlines("inputs/05/05_numbers_real.txt") - valid_lines
      sum = 0
      invalid_lines.each do |line|
        numbers = line.strip.split(",").map(&:to_i)
        sorted_numbers = numbers.sort { |a, b| sort_numbers(a, b, dependencies) }
        sum += find_middle_number(sorted_numbers)
      end
      puts sum
    end

    def sort_numbers(a, b, rules)
      if rules[a].include?(b)
        -1
      elsif rules[b].include?(a)
        1
      else
        0
      end
    end
    def find_middle_number(numbers)
      return 0 if numbers.length == 0
      l = numbers.length
      return numbers[l/2]
    end
  end

end
Day05.part_two
