defmodule LHeap do
  @moduledoc """
  Leftist heaps in Elixir.

  For general information about them, see [Wikipedia](https://en.wikipedia.org/wiki/Leftist_tree).

  Leftist heap elements are represented by a three element tuple of the form:

  `{{s-value, value}, left, right}`

  Where:
    * `s-value` is the distance from that node to the nearest leaf of the [extended binary tree representation](http://mathworld.wolfram.com/ExtendedBinaryTree.html)
    * `value`, is the actual value of the node
    * `left` and `right` are other heaps
  """

  @empty {}

  @doc """
  Creates a new, empty heap.

  ## Example

      iex> LHeap.new()
      {}
  """
  def new do
    @empty
  end

  @doc """
  Creates a new heap from a given enumerable.

  ## Example

      iex> LHeap.new([4, 3, 8])
      {{2, 3}, {{1, 4}, {}, {}}, {{1, 8}, {}, {}}}
  """
  def new(enumerable) do
    enumerable
    |> Enum.reduce(@empty, &(put(&2, &1)))
  end

  @doc """
  Puts a new value in a heap.

  ## Example

      iex> LHeap.new() |> LHeap.put(10) |> LHeap.put(1) |> LHeap.put(5) |> LHeap.put(7)
      {{2, 1}, {{1, 10}, {}, {}}, {{1, 5}, {{1, 7}, {}, {}}, {}}}
  """
  def put(lheap, value) do
    merge(build(value), lheap)
  end

  @doc """
  Returns the minimum element of a heap.

  ## Example

      iex> LHeap.new([10, 1, 7]) |> LHeap.min()
      1
  """
  def min(@empty), do: nil
  def min({{_, value}, _, _}), do: value

  @doc """
  Removes the minimum element from a heap.

  ## Example

      iex> LHeap.new([10, 1, 7]) |> LHeap.remove_min()
      {{1, 7}, {{1, 10}, {}, {}}, {}}
  """
  def remove_min(@empty), do: nil
  def remove_min({_, l, r}), do: merge(l, r)

  @doc """
  Merges two heaps.

  ## Example

      iex> heap1 = LHeap.new([2, 4, 6])
      iex> heap2 = LHeap.new([1, 3, 5])
      iex> LHeap.merge(heap1, heap2)
      {{2, 1}, {{2, 2}, {{1, 4}, {}, {}}, {{1, 5}, {{1, 6}, {}, {}}, {}}},
        {{1, 3}, {}, {}}}
  """
  def merge(lheap1, @empty), do: lheap1
  def merge(@empty, lheap2), do: lheap2
  def merge({{_, v1}, left1, right1} = lheap1, {{_, v2}, left2, right2} = lheap2) do
    cond do
      v1 < v2 ->
        build(v1, left1, merge(right1, lheap2))
      true ->
        build(v2, left2, merge(lheap1, right2))
    end
  end

  @doc """
  Sorts the given heap and returns a list.

  ## Example

      iex> heap1 = LHeap.new([2, 4, 6, 8, 10])
      iex> heap2 = LHeap.new([1, 3, 5, 7, 9])
      iex> LHeap.merge(heap1, heap2) |> LHeap.sort()
      [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  """
  def sort(h), do: sort(h, [])
  defp sort(@empty, mins), do: mins |> Enum.reverse()
  defp sort(h, mins) do
    sort(remove_min(h), [min(h) | mins])
  end

  defp s_val(@empty), do: 0
  defp s_val({{s_val, _}, _, _}), do: s_val

  defp build(v), do: build(v, @empty, @empty)
  defp build(v, l, r) do
    cond do
      s_val(l) >= s_val(r) ->
        {{s_val(r) + 1, v}, l, r}
      true ->
        {{s_val(l) + 1, v}, r, l}
    end
  end
end
