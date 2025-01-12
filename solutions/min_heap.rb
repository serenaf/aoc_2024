class MinHeap
  def initialize
    @heap = []
  end

  def push(val)
    @heap << val
    sift_up(@heap.size - 1)
  end

  def pop
    return @heap.pop if @heap.size <= 1
    min = @heap.first
    @heap[0] = @heap.pop
    sift_down(0)
    min
  end

  def size
    @heap.length
  end

  private

  def sift_up(index)
    return if index <= 0
    parent_index = (index - 1) / 2
    return if @heap[parent_index] <= @heap[index]

    @heap[parent_index], @heap[index] = @heap[index], @heap[parent_index]
    sift_up(parent_index)
  end

  def sift_down(index)
    left_child_index = 2 * index + 1
    right_child_index = 2 * index + 2
    min_index = index

    if left_child_index < @heap.size && @heap[left_child_index] < @heap[min_index]
      min_index = left_child_index
    end

    if right_child_index < @heap.size && @heap[right_child_index] < @heap[min_index]
      min_index = right_child_index
    end

    if min_index != index
      @heap[index], @heap[min_index] = @heap[min_index], @heap[index]
      sift_down(min_index)
    end
  end
end
