defmodule AOC.Day08 do
  require Integer
  use Tensor

  def parse_input(filename) do
    case File.cwd!() |> Path.join(filename) |> File.read() do
      {:ok, contents} ->
        String.trim(contents)

      {:error, :enoent} ->
        []
    end
  end

  def coordinate_distance({x1, y1, z1}, {x2, y2, z2}) do
    (:math.pow(x2 - x1, 2) + :math.pow(y2 - y1, 2) + :math.pow(z2 - z1, 2)) |> :math.sqrt()
  end

  def coordinate_pairs(coordinates_list) do
    if length(coordinates_list) == 1 do
      []
    else
      [first | rest] = coordinates_list
      Enum.map(rest, fn r -> {first, r} end) ++ coordinate_pairs(rest)
    end
  end

  def part1(text \\ parse_input("lib/day08/input.txt"), result_num \\ 1000) do
    coordinates_list =
      text
      |> String.split("\n")
      |> Enum.filter(fn x -> x != "" end)
      |> Enum.map(fn x ->
        x
        |> String.trim()
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)

    pairs =
      coordinate_pairs(coordinates_list)
      |> Enum.map(fn {coord1, coord2} ->
        distance = coordinate_distance(coord1, coord2)

        {coord1, coord2, distance}
      end)
      |> Enum.sort_by(fn {_, _, distance} -> distance end, :asc)

    closest_coord_pairs =
      pairs
      |> Enum.slice(0..result_num)
      |> Enum.map(fn {{x1, y1, z1}, {x2, y2, z2}, _} ->
        coord1 = "#{x1},#{y1},#{z1}"
        coord2 = "#{x2},#{y2},#{z2}"
        [coord1, coord2]
      end)

    dsu =
      closest_coord_pairs
      |> List.flatten()
      |> Enum.uniq()
      |> DSU.init()

    dsu =
      closest_coord_pairs
      |> Enum.reduce(dsu, fn [p1, p2], acc ->
        DSU.union(acc, p1, p2)
      end)

    sorted_circuit_lengths =
      dsu
      |> Enum.reduce(%{}, fn {key, _}, acc ->
        # Find the final root of the set
        {_dsu_new, final_root} = DSU.find(dsu, key)
        Map.put(acc, final_root, Map.get(acc, final_root, 0) + 1)
      end)
      |> Map.values()
      |> Enum.sort(:desc)

    [first, second, third | _] = sorted_circuit_lengths

    IO.puts("Result #{first * second * third}")
    first * second * third
  end

  def part2() do
  end
end
