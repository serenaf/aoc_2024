# rubocop:disable all
require "pry"
module Day01
  class << self

    def part_one
      left_list = []
      right_list = []
      sum_distances = 0
      File.readlines("inputs/01/01_real.txt").each do |line|
        num1, num2 = line.split.map(&:to_i)
        left_list << num1
        right_list << num2
      end
      ordered_left_list = left_list.sort
      ordered_right_list = right_list.sort

      ordered_left_list.each_with_index do |num, index|
        distance = (num - ordered_right_list[index]).abs
        sum_distances += distance
      end
      puts sum_distances
    end

    def part_two
      left_list = []
      right_list = []
      similarity_score = 0
      File.readlines("inputs/01/01_real.txt").each do |line|
        num1, num2 = line.split.map(&:to_i)
        left_list << num1
        right_list << num2
      end

      occurence_hash = {}
      right_list.each do |number|
        if occurence_hash[number]
            occurence_hash[number]+=1
        else
          occurence_hash[number] = 1
        end
      end

      left_list.each do |number|
        mult_factor = 0
        if occurence_hash[number]
          mult_factor = occurence_hash[number]
        end
        similarity_score +=(number * mult_factor)
      end
      puts similarity_score
    end
  end
end

Day01.part_two()
