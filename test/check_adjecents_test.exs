defmodule CheckAdjecentsTest do
  use Tensor
  use ExUnit.Case
  doctest AOC.Day04

  test "checks adjecents correct" do
    matrix =
      Vector.new([
        Vector.new(String.graphemes(".@.")),
        Vector.new(String.graphemes(".@@")),
        Vector.new(String.graphemes(".@."))
      ])

    assert AOC.Day04.check_adjecent(1, 1, matrix) == 3
    assert AOC.Day04.check_adjecent(1, 0, matrix) == 2
  end
end
