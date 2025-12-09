defmodule Utils.Coordinates do
  def coordinate_pairs(coordinates_list) do
    if length(coordinates_list) == 1 do
      []
    else
      [first | rest] = coordinates_list
      Enum.map(rest, fn r -> {first, r} end) ++ coordinate_pairs(rest)
    end
  end

  def coordinate_distance({x1, y1, z1}, {x2, y2, z2}) do
    (:math.pow(x2 - x1, 2) + :math.pow(y2 - y1, 2) + :math.pow(z2 - z1, 2)) |> :math.sqrt()
  end

  def are_points_diagonal({x1, y1}, {x2, y2}) do
    abs(x1 - x2) == abs(y1 - y2)
  end
end
