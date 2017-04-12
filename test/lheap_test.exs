defmodule LHeapTest do
  use ExUnit.Case, async: true
  use ExCheck

  property "create new heap with sort" do
    for_all xs in list(int()) do
      heap = LHeap.new(xs)

      LHeap.sort(heap) == Enum.sort(xs)
    end
  end

  property "put and length of right spine" do
    for_all xs in list(int()) do
      heap = LHeap.new(xs)
      spine_length = LHeap.length_right_spine(heap)

      max_spine_length = :math.log2(length(xs) + 1)
      spine_length <= max_spine_length
    end
  end

  property "merge two heaps" do
    for_all {xs, ys} in {list(int()), list(int())} do
      x = LHeap.new(xs)
      y = LHeap.new(ys)
      heap = LHeap.merge(x, y)

      LHeap.sort(heap) == Enum.sort(xs ++ ys)
    end
  end
end
