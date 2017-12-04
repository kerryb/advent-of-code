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
    ever_increasing_radii()
    |> Stream.map(&distances_for_squares_on_a_side/1)
    |> Stream.flat_map(&repeat_for_four_sides/1)
  end

  defp ever_increasing_radii, do: Stream.iterate 0, &(&1 + 1)

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
end
