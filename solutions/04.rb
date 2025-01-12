module Day04
  class << self

    def is_valid?(x, y, char, grid)
      return true if grid[x][y] == char
    end


    def part_one
      line_count = 0
      grid = Hash.new { |h, k| h[k] = {} }
      File.readlines("inputs/04/04_real.txt").each do |line|
        char_count = 0
        line.strip.each_char do |char|
          grid[line_count][char_count] = char
          char_count +=1
        end
        line_count+=1
      end
      # find the positions of x in the grid
      candidate_x_positions = []
      grid.each do |row_num, row|
        row.each do |col_num, char|
          if char == 'X'
            candidate_x_positions << [row_num, col_num]
          end
        end
      end

     xmas_count = 0
     candidate_x_positions.each do |x_position|
      words = []
      x = x_position[0]
      y = x_position[1]
      8.times do |i|
        words[i] = 'X'
      end
      # get the positions of the next 3 characters
      3.times do |i|
        index = i + 1
        words[0] << grid[x-index][y] unless grid[x-index][y].nil?
        words[1] << grid[x+index][y] unless grid[x+index][y].nil?
        words[2] << grid[x][y-index] unless grid[x][y-index].nil?
        words[3] << grid[x][y+index] unless grid[x][y+index].nil?
        words[4] << grid[x+index][y+index] unless grid[x+index][y+index].nil?
        words[5] << grid[x-index][y-index] unless grid[x-index][y-index].nil?
        words[6] << grid[x+index][y-index] unless grid[x+index][y-index].nil?
        words[7] << grid[x-index][y+index] unless grid[x-index][y+index].nil?
      end
      xmas_count += words.select {|words| words == "XMAS"}.size
     end
     puts xmas_count
    end


  def part_two
    line_count = 0
    grid = Hash.new { |h, k| h[k] = {} }
    File.readlines("inputs/04/04_real.txt").each do |line|
      char_count = 0
      line.strip.each_char do |char|
        grid[line_count][char_count] = char
        char_count +=1
      end
      line_count+=1
    end

     # find the positions of A in the grid
     candidate_a_positions = []
     grid.each do |row_num, row|
       row.each do |col_num, char|
         if char == 'A'
           candidate_a_positions << [row_num, col_num]
         end
       end
     end
     words = 0
     candidate_a_positions.each do |x_position|
      x = x_position[0]
      y = x_position[1]

      char_1 = grid[x-1][y-1]
      char_2 = grid[x-1][y+1]
      char_3 = grid[x+1][y-1]
      char_4 = grid[x+1][y+1]

      word_1 = char_1 + 'A' + char_4 unless char_1.nil? || char_4.nil?
      word_2 = char_3 + 'A' + char_2 unless char_3.nil? || char_2.nil?

      if word_1 !=nil && word_2 != nil
        words +=1 if word_1.chars.sort.join == word_2.chars.sort.join && word_1.chars.sort.join == 'AMS'
      end
    end
     puts words
  end
end
end

Day04.part_two
