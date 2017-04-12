# lheap

> [Leftist heap](https://en.wikipedia.org/wiki/Leftist_tree) in Elixir

## Install

In your `mix.exs`:

```elixir
defp deps do
  [
    {:lheap, "~> 1.0.0"}
  ]
end
```

Then run `mix deps.get`.

## API

Documentation is available in [HexDocs](https://hexdocs.pm/lheap).

### `LHeap.new/0`, `LHeap.new/1`

Creates a new empty heap. When given an enumerable, it will populate the new heap with it.

### `LHeap.put/2`

Puts a new value in a heap.

### `LHeap.min/1`

Returns the minimum element of a heap.

### `LHeap.remove_min/1`

Removes the minimum element from a heap.

### `LHeap.merge/2`

Merges two heaps.

### `LHeap.sort/1`

Sorts the given heap and returns a list.

## License

MIT © [Juan Soto](https://juansoto.me)
