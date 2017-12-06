defmodule MemoryReallocation do
  @moduledoc """
  http://adventofcode.com/2017/day/6
  """

  @doc """
  ## Examples

      iex> MemoryReallocation.number_of_cycles "0  2  7  0"
      5

  """
  def number_of_cycles(input) do
    input
    |> String.split(~r/\s+/)
    |> Enum.map(&String.to_integer/1)
    |> number_of_cycles(MapSet.new, 0)
  end

  defp number_of_cycles(banks, previous_states, steps) do
    new_banks = redistribute(banks)
    if MapSet.member? previous_states, new_banks do
      steps + 1
    else
      number_of_cycles(new_banks, MapSet.put(previous_states, new_banks), steps + 1)
    end
  end

  @doc """
  ## Examples

      iex> MemoryReallocation.number_of_cycles "0  2  7  0"
      4

  """
  def cycle_length(input) do
    input
    |> String.split(~r/\s+/)
    |> Enum.map(&String.to_integer/1)
    |> cycle_length(MapSet.new, 0)
  end

  defp cycle_length(banks, previous_states, steps) do
    new_banks = redistribute(banks)
    if MapSet.member? previous_states, new_banks do
      number_of_cycles(new_banks, MapSet.new, 0) - 1
    else
      cycle_length(new_banks, MapSet.put(previous_states, new_banks), steps + 1)
    end
  end

  defp redistribute(banks) do
    {new_banks, removed, removed_from_index} = remove_biggest(banks)
    redistribute new_banks, removed, Integer.mod(removed_from_index + 1, length(banks))
  end
  defp redistribute(banks, 0, _), do: banks
  defp redistribute(banks, remaining, next_index) do
    new_banks = List.update_at banks, next_index, &(&1 + 1)
    redistribute new_banks, remaining - 1, Integer.mod(next_index + 1, length(banks))
  end

  defp remove_biggest(banks) do
    {biggest, index} = banks
                       |> Enum.with_index
                       |> Enum.max_by(fn {elem, _index} -> elem end)
    {List.replace_at(banks, index, 0), biggest, index}
  end
end
