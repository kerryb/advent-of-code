defmodule Registers do
  @moduledoc """
  http://adventofcode.com/2017/day/8
  """

  @doc ~S'''
  ## Examples

      iex> Registers.largest_value """
      ...> b inc 5 if a > 1
      ...> a inc 1 if b < 5
      ...> c dec -10 if a >= 1
      ...> c inc -20 if c == 10
      ...> """
      1
  '''
  def largest_value(input) do
    input
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&parse/1)
    |> run
  end

  defp parse(line) do
    [target, op, delta, _, source, comparator, compare_with] = String.split line
    %{target: target,
      op: op,
      delta: String.to_integer(delta),
      source: source,
      comparator: comparator,
      compare_with: String.to_integer(compare_with)}
  end

  def run(instructions) do
    instructions
    |> Enum.reduce(%{}, &update/2)
    |> Map.values
    |> Enum.max
  end

  def update(instruction, registers) do
    value = Map.get registers, instruction.source, 0
    if evaluate(value, instruction.comparator, instruction.compare_with) do
      update_register registers, instruction.target, instruction.op, instruction.delta
    else
      registers
    end
  end

  defp evaluate(x, "==", y), do: x == y
  defp evaluate(x, "!=", y), do: x != y
  defp evaluate(x, "<", y), do: x < y
  defp evaluate(x, ">", y), do: x > y
  defp evaluate(x, "<=", y), do: x <= y
  defp evaluate(x, ">=", y), do: x >= y

  defp update_register(registers, key, "inc", delta) do
    registers |> Map.update(key, delta, &(&1 + delta))
  end
  defp update_register(registers, key, "dec", delta) do
    registers |> Map.update(key, -delta, &(&1 - delta))
  end
end
