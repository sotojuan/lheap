defmodule LHeap do
  @moduledoc false

  @empty {}

  def new do
    @empty
  end

  def new(enumerable) do
    enumerable
    |> Enum.reduce(@empty, &(put(&2, &1)))
  end

  def put(lheap, value) do
    merge(build(value), lheap)
  end

  def min(@empty), do: nil
  def min({{_, value}, _, _}), do: value

  def remove_min(@empty), do: nil
  def remove_min({_, l, r}), do: merge(l, r)

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

  def length_right_spine(@empty), do: 0
  def length_right_spine({_, _, r}), do: 1 + length_right_spine(r)
end
