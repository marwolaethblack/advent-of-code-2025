defmodule DSU do
  def init(sets) do
    sets
    |> Enum.reduce(%{}, fn set, map ->
      Map.put(map, set, set)
    end)
  end

  def find(dsu, x) do
    case Map.get(dsu, x) do
      nil ->
        {Map.put(dsu, x, x), x}

      ^x ->
        {dsu, x}

      y ->
        {dsu2, p} = find(dsu, y)
        {Map.put(dsu2, x, p), p}
    end
  end

  def union(%{} = dsu, x, y) do
    {dsu, a} = find(dsu, x)
    {dsu, b} = find(dsu, y)

    if a == b do
      dsu
    else
      [a, b] = Enum.sort([a, b])
      {dsu, c} = find(dsu, a)
      Map.put(dsu, b, c)
    end
  end
end
