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
  def checksum(spreadsheet), do: checksum spreadsheet, &checksum_row/1

  @doc ~S'''
  ## Examples

  iex> CorruptionChecksum.checksum2 """
  ...> 5 9 2 8
  ...> 9 4 7 3
  ...> 3 8 6 5
  ...> """
  9
  '''
  def checksum2(spreadsheet), do: checksum spreadsheet, &checksum_row2/1

  def checksum(spreadsheet, row_fn) do
    spreadsheet
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(row_fn)
    |> Enum.sum
  end

  defp checksum_row(row) do
    numbers = row |> Enum.map(&String.to_integer/1)
    abs(Enum.min(numbers) - Enum.max(numbers))
  end

  defp checksum_row2(row) do
    row
    |> Enum.map(&String.to_integer/1)
    |> find_divisible_pair
    |> pair_quotient
  end

  defp find_divisible_pair([head|tail]) do
    cond do
      val = Enum.find(tail, fn(x) -> Integer.mod(x, head) == 0 end) -> {val, head}
      val = Enum.find(tail, fn(x) -> Integer.mod(head, x) == 0 end) -> {head, val}
      true -> find_divisible_pair tail
    end
  end

  def pair_quotient({a, b}), do: Integer.floor_div a, b
end
