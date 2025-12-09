defmodule Day09Test do
  use ExUnit.Case
  doctest AOC.Day09

  test "day 8 part 1" do
    test_data =
      """
      7,1
      11,1
      11,7
      9,7
      9,5
      2,5
      2,3
      7,3
      """

    assert AOC.Day09.part1(test_data) == 50
  end
end
