defmodule CorruptionChecksum do
  @moduledoc """
  http://adventofcode.com/2017/day/2
  """

  @doc ~S'''
  ## Examples

  iex> CorruptionChecksum.checksum """
  ...> 5 1 9 5
  ...> 7 5 3
  ...> 2 4 6 8
  ...> """
  18
  '''

  def checksum(spreadsheet) do
    spreadsheet
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(&checksum_row/1)
    |> Enum.sum
  end

  defp checksum_row(row) do
    numbers = row |> Enum.map(&String.to_integer/1)
    abs(Enum.min(numbers) - Enum.max(numbers))
  end
end
