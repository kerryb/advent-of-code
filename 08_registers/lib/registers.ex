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
    {registers, _} = input
                     |> String.trim
                     |> String.split("\n")
                     |> Enum.map(&parse/1)
                     |> run
    registers
    |> Map.values
    |> Enum.max
  end

  @doc ~S'''
  ## Examples

      iex> Registers.largest_ever_value """
      ...> b inc 5 if a > 1
      ...> a inc 1 if b < 5
      ...> c dec -10 if a >= 1
      ...> c inc -20 if c == 10
      ...> """
      10
  '''
  def largest_ever_value(input) do
    {_, max} = input
               |> String.trim
               |> String.split("\n")
               |> Enum.map(&parse/1)
               |> run
    max
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
    |> Enum.reduce({%{}, nil}, &update/2)
  end

  def update(instruction, {registers, max}) do
    value = Map.get registers, instruction.source, 0
    if evaluate(value, instruction.comparator, instruction.compare_with) do
      update_register {registers, max}, instruction.target, instruction.op, instruction.delta
    else
      {registers, max}
    end
  end

  defp evaluate(x, "==", y), do: x == y
  defp evaluate(x, "!=", y), do: x != y
  defp evaluate(x, "<", y), do: x < y
  defp evaluate(x, ">", y), do: x > y
  defp evaluate(x, "<=", y), do: x <= y
  defp evaluate(x, ">=", y), do: x >= y

  defp update_register({registers, max}, key, "inc", delta), do: update_register {registers, max}, key, delta
  defp update_register({registers, max}, key, "dec", delta), do: update_register {registers, max}, key, -delta
  defp update_register({registers, max}, key, delta) do
    new_value = Map.get(registers, key, 0) + delta
    new_max = if is_nil(max), do: new_value, else: Enum.max [max, new_value]
    {Map.put(registers, key, new_value), new_max}
  end
end
