defmodule AOC.Day04 do
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

  def check_adjecent(x, y, matrix) do
    adjecents = [{-1, 0}, {1, 0}, {-1, -1}, {0, -1}, {1, -1}, {-1, 1}, {0, 1}, {1, 1}]
    max_y = Vector.length(matrix) - 1
    max_x = Vector.length(matrix[0]) - 1

    Enum.reduce(adjecents, 0, fn {adj_x, adj_y}, acc ->
      {new_x, new_y} = {adj_x + x, adj_y + y}

      has_adjecent =
        if new_x >= 0 and new_y >= 0 and new_x <= max_x and new_y <= max_y do
          # Coords are valid
          if matrix[new_y][new_x] == "@" do
            1
          else
            0
          end
        else
          0
        end

      acc + has_adjecent
    end)
  end

  def part1() do
    paper_shelf =
      parse_input("lib/day04/input.txt")
      |> Enum.map(fn x -> String.graphemes(x) |> Vector.new() end)
      |> Vector.new()

    {_, res} =
      paper_shelf
      |> Enum.reduce({0, 0}, fn paper_row, {index_y, sum} ->
        {_, papers} =
          Enum.reduce(paper_row, {0, 0}, fn x, {index_x, sum} ->
            count =
              if paper_row[index_x] == "@" and check_adjecent(index_x, index_y, paper_shelf) < 4 do
                1
              else
                0
              end

            {index_x + 1, sum + count}
          end)

        {index_y + 1, sum + papers}
      end)

    IO.inspect("Result: #{res}")
  end

  def part2() do
    # paper_shelf =
    #   parse_input("lib/day04/input.txt")
    #   |> Enum.map(fn x -> String.graphemes(x) |> Vector.new() end)
    #   |> Vector.new()

    # {_, res} =
    #   paper_shelf
    #   |> Enum.reduce({0, 0}, fn paper_row, {index_y, sum} ->
    #     {_, papers} =
    #       Enum.reduce(paper_row, {0, 0}, fn x, {index_x, sum} ->
    #         count =
    #           if paper_row[index_x] == "@" and check_adjecent(index_x, index_y, paper_shelf) < 4 do
    #             1
    #           else
    #             0
    #           end

    #         {index_x + 1, sum + count}
    #       end)

    #     {index_y + 1, sum + papers}
    #   end)

    # IO.inspect("Result: #{res}")
  end
end
