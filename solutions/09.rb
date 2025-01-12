module Day09
  class << self
    def part_one
      input_path = File.join(__dir__, "..", "inputs", "09", "09_real.txt")
      block_representation = block_representation(File.read(input_path))
      compacted_representation = compact(block_representation)
      puts checksum(compacted_representation)
    end

    def part_two
      input_path = File.join(__dir__, "..", "inputs", "09", "evil_09.txt")
      block_representation = block_representation(File.read(input_path))
      compacted_representation = compact_part_two(block_representation)
      puts checksum(compacted_representation)
    end

    def block_representation(string)
      block_representation = []
      counter = 0
      string.chars.map(&:to_i).each_with_index do |char, index|
        if index.even?
          for i in 1..char  do
            block_representation << counter
          end
          counter +=1
        else
          for i in 1..char do
            block_representation << -1
          end
        end
      end
      block_representation
    end


    def compact(block_representation)
      start_index = 0
      end_index = block_representation.length - 1

      while start_index < end_index do
        # we have found a free space where we can fit the file
        if block_representation[start_index] == -1 && block_representation[end_index] != -1
          block_representation[start_index] = block_representation[end_index]
          block_representation[end_index] = -1
          start_index += 1
          end_index -= 1
        end

        if block_representation[start_index] != -1
          start_index +=1
        end

        if block_representation[end_index] == -1
          end_index -= 1
        end
      end
      block_representation
    end


    # this is the function which allows us to move a file to a new location that has length free space
    def moveFile(blockRepresentation, fileLength, fileIndex)
      freeSpaceCount = 0
      freeSpaceIndex = -1

      for i in 1..fileIndex do
        if blockRepresentation[i-1] == -1 && blockRepresentation[i] != -1
          # we might have found a potential free space
          if freeSpaceCount >= fileLength
            for j in 0..(fileLength-1) do
              blockRepresentation[freeSpaceIndex + j] = blockRepresentation[fileIndex]
            end

            for n in 0..(fileLength-1) do
              blockRepresentation[fileIndex+n] = -1
            end
          end
          freeSpaceCount = 0
          freeSpaceIndex = -1
        end

        if blockRepresentation[i] == -1
          freeSpaceCount += 1
          freeSpaceIndex = i unless freeSpaceIndex != -1
        end
      end
    end

    def compact_part_two(blockRepresentation)
      currentFile = -1
      currentFileLength = 0

      for i in (blockRepresentation.length - 1).downto(1) do
        if blockRepresentation[i] != -1
          currentFileLength +=1
          currentFile = i
          if blockRepresentation[i] != blockRepresentation[i-1]
            if currentFileLength > 0
              moveFile(blockRepresentation, currentFileLength, currentFile)
              currentFileLength = 0
            end
          end
        else
          if currentFileLength > 0
              moveFile(blockRepresentation, currentFileLength, currentFile)
              currentFileLength = 0
          end
        end
      end
      blockRepresentation
    end


    def checksum(compacted_representation)
      sum = 0
      compacted_representation.each_with_index do |block, index|
        sum += block.to_i * index unless block == -1
      end
      sum
    end



  end
end
Day09.part_two
