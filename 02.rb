# rubocop:disable all
require "pry"
module Day02

  class << self
    def part_one
      safe_reports = 0
      File.readlines("inputs/02/02.txt").each do |line|
        numbers = line.split.map(&:to_i)
        if all_decreasing?(numbers) || all_increasing?(numbers)
          safe_reports +=1
        end
      end
      puts safe_reports
    end


    def all_increasing?(numbers)
      numbers.each_cons(2).all? {|number1, number2| number2-number1 >=1 && number2-number1 < 4 }
    end

    def all_decreasing?(numbers)
      numbers.each_cons(2).all? {|number1, number2| number1-number2 >=1 && number1-number2 < 4 }
    end

    def part_two
      safe_reports = 0
      File.readlines("inputs/02/02_real.txt").each do |line|
        numbers = line.split.map(&:to_i)
        if all_decreasing?(numbers) || all_increasing?(numbers)
          safe_reports +=1
        else
          # now we need to check all the sub arrays
          # 1...n leave out 0th element
          # 0, 2, 3, 4 leave out first element
          # 0, 1, 3, 4 leave out second element
          # 0, 1, 3, 4 leave out third element
          # 0, 1, 2, 3 leave out forth element

          (0..numbers.size-1).each do |range|
            sub_array = numbers.dup.tap{|i| i.delete_at(range)}
            if all_decreasing?(sub_array) || all_increasing?(sub_array)
              safe_reports +=1
              break
            end
          end
        end
      end
      puts safe_reports
    end
  end
end

Day02.part_two()
