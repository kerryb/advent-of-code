defmodule SpiralMemory do
  @moduledoc """
  http://adventofcode.com/2017/day/3
  """

  @doc """
  ## Examples

      iex> SpiralMemory.distance 1
      0
      iex> SpiralMemory.distance 12
      3
      iex> SpiralMemory.distance 23
      2
      iex> SpiralMemory.distance 1024
      31

  """
  def distance(square) do
    square_distances()
    |> Stream.take(square)
    |> Stream.drop(square - 1)
    |> Enum.at(0)
  end

  defp square_distances do
    ever_increasing_numbers()
    |> Stream.map(&distances_for_squares_on_a_side/1)
    |> Stream.flat_map(&repeat_for_four_sides/1)
  end

  defp ever_increasing_numbers, do: Stream.iterate 0, &(&1 + 1)

  defp distances_for_squares_on_a_side(0),  do: [0]
  defp distances_for_squares_on_a_side(radius) do
    Enum.to_list(2 * radius - 1 .. radius) ++ Enum.to_list(radius + 1 .. 2 * radius)
  end

  defp repeat_for_four_sides([0]), do: [0]
  defp repeat_for_four_sides(distances) do
    distances
    |> List.duplicate(4)
    |> List.flatten
  end

  # ===== PART TWO =====

  @doc """
  ## Examples

      iex> SpiralMemory.first_value_larger_than 1
      2
      iex> SpiralMemory.first_value_larger_than 5
      10
      iex> SpiralMemory.first_value_larger_than 100
      122
  """
  def first_value_larger_than(limit) do
    nil
    |> Stream.iterate(&(&1))
    |> Stream.scan({1, {0, 0}, %{{0, 0} => 1}}, &add_to_grid/2)
    |> Stream.drop_while(fn {value, _, _} -> value <= limit end)
    |> Enum.take(1)
    |> extract_value
  end

  defp add_to_grid(_, {_last_value, last_position, grid}) do
    position = next_position last_position, grid
    value = sum_of_neighbours position, grid
    new_grid = Map.put(grid, position, value)
    {value, position, new_grid}
  end

  defp next_position({x, y}, grid) do
    n = is_nil grid[{x, y + 1}]
    e = is_nil grid[{x + 1, y}]
    s = is_nil grid[{x, y - 1}]
    w = is_nil grid[{x - 1, y}]
    case [n, e, s, w] do
      [true, true, _, false] -> {x, y + 1}
      [true, _, false, true] -> {x - 1, y}
      [_, false, true, true] -> {x, y - 1}
      [_, true, true, _] -> {x + 1, y}
    end
  end

  defp sum_of_neighbours({x, y}, grid) do
    for xx <- [x - 1, x, x + 1], yy <- [y - 1, y, y + 1] do
      Map.get grid, {xx, yy}, 0
    end
    |> Enum.sum
  end

  defp extract_value([{value, _, _}]), do: value
end
