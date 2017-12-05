defmodule TwistyTrampolines do
  @moduledoc """
  http://adventofcode.com/2017/day/5
  """

  @doc ~S'''
  ## Examples

      iex> TwistyTrampolines.steps_to_escape """
      ...> 0
      ...> 3
      ...> 0
      ...> 1
      ...> -3
      ...> """
      5
  '''
  def steps_to_escape(input) do
    input
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> steps_to_escape(0, 0)
  end

  defp steps_to_escape(_offsets, count, position) when position < 0, do: count
  defp steps_to_escape(offsets, count, position) when position >= length(offsets), do: count
  defp steps_to_escape(offsets, count, position) do
    offset = offsets |> Enum.at(position)
    steps_to_escape(offsets |> List.update_at(position, &(&1 + 1)), count + 1, position + offset)
  end
end
