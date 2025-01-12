module Day07
  class << self
    def part_one
      testing = []
      input_path = File.join(__dir__, "..", "inputs", "07", "07_real.txt")
      File.readlines(input_path).each do |line|
        desired_result, numbers = line.strip.split(":")
        numbers = numbers.split(" ").map(&:to_i)
        testing << {
          desired_result: desired_result.to_i,
          numbers: numbers
        }
      end
      sum = 0
      testing.each do |test|
        sum += test[:desired_result] if test[:desired_result] == calculate(test[:numbers], test[:desired_result], -1)
      end
      puts sum
    end

    def part_two
      testing = []
      input_path = File.join(__dir__, "..", "inputs", "07", "07_real.txt")
      File.readlines(input_path).each do |line|
        desired_result, numbers = line.strip.split(":")
        numbers = numbers.split(" ").map(&:to_i)
        testing << {
          desired_result: desired_result.to_i,
          numbers: numbers
        }
      end
      sum = 0
      testing.each do |test|
        sum += test[:desired_result] if test[:desired_result] == calculate_part_two(test[:numbers], test[:desired_result], -1)
      end
      puts sum
    end

    def calculate_part_two(numbers, desired_result, value)

      return value if numbers.empty? || value > desired_result

      value = numbers.shift if value == -1
      new_value = numbers.shift

      int1 = calculate_part_two(numbers.clone, desired_result, value + new_value)
      int2 = calculate_part_two(numbers.clone, desired_result, value * new_value)
      int3 = calculate_part_two(numbers.clone, desired_result, "#{value}#{new_value}".to_i)

      return int1 if int1 == desired_result
      return int2 if int2 == desired_result
      return int3 if int3 == desired_result

      0
    end

    def calculate(numbers, desired_result, value)

      return value if numbers.empty? || value > desired_result

      value = numbers.shift if value == -1
      new_value = numbers.shift

      int1 = calculate(numbers.clone, desired_result, value + new_value)
      int2 = calculate(numbers.clone, desired_result, value * new_value)

      return int1 if int1 == desired_result
      return int2 if int2 == desired_result

      0
    end
  end
end

Day07.part_two



