defmodule AOC.Day09 do
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

  def part1(text \\ parse_input("lib/day09/input.txt")) do
    res =
      text
      |> String.split("\n")
      |> Enum.filter(fn x -> x !== "" end)
      |> Enum.map(fn x ->
        String.split(x, ",")
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)

    diagonal_points =
      res
      |> Utils.Coordinates.coordinate_pairs()

    largest =
      diagonal_points
      |> Enum.map(fn {coord1, coord2} ->
        {x1, y1} = coord1
        {x2, y2} = coord2

        sideA = Utils.Coordinates.coordinate_distance({x1, y2, 1}, {x1, y1, 1}) + 1
        sideB = Utils.Coordinates.coordinate_distance({x1, y2, 1}, {x2, y2, 1}) + 1

        sideA * sideB
      end)
      |> Enum.sort(:desc)
      |> List.first()

    IO.puts("Result: #{largest}}")

    largest
  end

  def part2() do
  end
end
