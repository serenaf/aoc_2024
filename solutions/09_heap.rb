require_relative "min_heap"

module Day09Heap

  class FileSegment

    attr_accessor :startIndex, :length, :fileNum

    def initialize(startIndex, length, fileNum)
      @startIndex = startIndex
      @length = length
      @fileNum = fileNum
    end
  end

  class << self
    def part_two
      input_path = File.join(__dir__, "..", "inputs", "09", "evil_09.txt")
      blocks = getHeapsAndFiles(File.read(input_path))
      heaps = blocks[0]
      files = blocks[1]
      compactedFiles = performFileCompaction(heaps, files)
      puts calculateUpdatedChecksum(compactedFiles)
    end

    # this will return 9 min heaps, each representing the starting index of free space
    # a list of files, each item representing file length, file starting index and its number
    def getHeapsAndFiles(input)
      heaps = []
      files = []
      for i in 0..9 do
        heaps << MinHeap.new
      end

      index = 0
      input.chars.each_with_index do |char, i|
        num = char.to_i
        next if num == 0

        if i.even?
          files << Day09Heap::FileSegment.new(index, num, i / 2 )
        else
          heap = heaps[num]
          heap.push(index)
        end
        index += num
      end
      [heaps, files]
    end

    def performFileCompaction(heaps, files)
      i = files.length - 1
      while i >= 0 do
        file = files[i]
        best_heap_index = -1
        best_space_index = Float::INFINITY

        # Try each heap that's big enough to hold our file
        for heap_size in file.length..9 do
          current_heap = heaps[heap_size]
          next if current_heap.size == 0

          # Get the earliest available space from this heap
          space_index = current_heap.pop

          # If this space is either:
          # 1. Before the current file and earlier than our best space, or
          # 2. After the current file but earlier than our best space
          # Then use it as our new best space
          if space_index < file.startIndex

            # If we had a previous best space, put it back in its heap
            if best_heap_index != -1
              heaps[best_heap_index].push(best_space_index)
            end

            best_space_index = space_index
            best_heap_index = heap_size
          else
            # If this space isn't better, put it in a smaller heap
            if heap_size > file.length
              heaps[heap_size - 1].push(space_index)
            else
              current_heap.push(space_index)
            end
          end
        end

        # If we found a better position, move the file there
        if best_heap_index != -1
          file.startIndex = best_space_index

          # If we used a larger space than needed, add the remainder to appropriate heap
          remaining_space = best_heap_index - file.length
          if remaining_space > 0
            heaps[remaining_space].push(best_space_index + file.length)
          end
        end

        i -= 1
      end
      files
    end

    def calculateUpdatedChecksum(files)
      sum = 0
      files.each do |file|
        for i in 0..file.length - 1 do
          sum += (file.startIndex+i) * file.fileNum
        end
      end
      sum
    end
  end
end

Day09Heap::part_two
