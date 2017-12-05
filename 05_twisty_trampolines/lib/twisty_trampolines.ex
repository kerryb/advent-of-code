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
    |> parse_input
    |> steps_to_escape(0, 0, &(&1 + 1))
  end

  @doc ~S'''
  ## Examples

      iex> TwistyTrampolines.steps_to_escape2 """
      ...> 0
      ...> 3
      ...> 0
      ...> 1
      ...> -3
      ...> """
      10
  '''
  def steps_to_escape2(input) do
    input
    |> parse_input
    |> steps_to_escape(0, 0, &update_offset/1)
  end

  defp parse_input(input) do
    input
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end

  defp steps_to_escape(_offsets, count, position, _offset_updater) when position < 0, do: count
  defp steps_to_escape(offsets, count, position, _offset_updater) when position >= length(offsets), do: count
  defp steps_to_escape(offsets, count, position, offset_updater) do
    offset = offsets |> Enum.at(position)
    steps_to_escape(offsets |> List.update_at(position, offset_updater), count + 1, position + offset, offset_updater)
  end

  def update_offset(offset) when offset >= 3, do: offset - 1
  def update_offset(offset), do: offset + 1
end
