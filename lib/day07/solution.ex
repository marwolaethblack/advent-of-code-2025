defmodule AOC.Day07 do
  require Integer
  use Tensor

  def parse_input(filename) do
    case File.cwd!() |> Path.join(filename) |> File.read() do
      {:ok, contents} ->
        String.trim(contents) |> String.split("\n")

      {:error, :enoent} ->
        []
    end
  end

  def part1() do
    parsed_input = parse_input("lib/day07/input.txt")

    matrix =
      parsed_input |> Enum.map(fn x -> String.graphemes(x) |> Vector.new() end)

    [first | rest] = matrix

    start_index = first |> Enum.find_index(fn x -> x == "S" end)

    {_, res} =
      Vector.new(rest)
      |> Enum.reduce({[start_index], 0}, fn row, {beam_indexes, sum} ->
        laser_path =
          beam_indexes |> Enum.map(fn beam_indexes -> row[beam_indexes] end) |> Vector.new()

        new_beam_indexes =
          beam_indexes
          |> Stream.with_index()
          |> Enum.map(fn {v, k} ->
            if laser_path[k] == "^" do
              [v - 1, v + 1]
            else
              [v]
            end
          end)
          |> List.flatten()
          |> Enum.uniq()

        {new_beam_indexes, sum + (laser_path |> Enum.count(fn x -> x == "^" end))}
      end)

    IO.puts("Result #{res}")
  end

  def part2() do
  end
end
