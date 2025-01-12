module Day06
  class << self
    DIRECTIONS = {
      '>' => [0, 1],
      '<' => [0, -1],
      '^' => [-1, 0],
      'v' => [1, 0]
    }

    def part_one

      grid = Hash.new { |h, k| h[k] = {} }
      start_position = nil
      direction = nil
      direction_char = ''
      # first we have to build the grid up from the input
      line_count = 0
      input_path = File.join(__dir__, "..", "inputs", "06", "06_real.txt")
      File.readlines(input_path).each do |line|
        line.strip.each_char.with_index do |char, char_count|
          grid[line_count][char_count] = char
          if char == '^' || char == 'v' || char == '>' || char == '<'
            direction_char = char
            start_position = [line_count, char_count]
            direction = DIRECTIONS[char]
          end
        end
        line_count += 1
      end

      current_position = start_position
      grid[start_position[0]][start_position[1]] = 'X'
      new_position = [current_position[0] + direction[0], current_position[1] + direction[1]]

      while in_bounds?(grid, new_position)
        if grid[new_position[0]][new_position[1]] == "#"
          puts "hitting an obstacle at #{new_position}, current position: #{current_position}"
          # we need to turn right 90 degrees, i.e change the direction
          direction_char = determine_direction_char(direction_char)
          direction = DIRECTIONS[direction_char]
          puts "turning right 90 degrees, new direction: #{direction_char}, with direction: #{direction}"
          new_position = [current_position[0] + direction[0], current_position[1] + direction[1]]
        else
          # mark the current position as visited
          grid[new_position[0]][new_position[1]] = 'X'
          current_position = new_position
          new_position = [new_position[0] + direction[0], new_position[1] + direction[1]]
        end
      end
      visited = 0
      grid.each do |row_num, columns|
        columns.each do |col_num, value|
          if value == "X"
            visited += 1
          end
        end
      end
      puts visited
    end


    def in_bounds?(grid, position)
      # check whether x is within bounds
      return false if position[0] >= grid[0].size || position[0] < 0
      # check whether y is within bounds
      return false if position[1] >= grid[1].size || position[1] < 0
      return true
    end

    def determine_direction_char(direction_char)
      case direction_char
      when '^'
        '>'
      when 'v'
        '<'
      when '>'
        'v'
      when '<'
        '^'
      end
    end
  end
end

Day06.part_one
