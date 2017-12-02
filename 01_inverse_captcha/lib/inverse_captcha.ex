defmodule InverseCaptcha do
  @moduledoc """
  http://adventofcode.com/2017/day/1
  """

  @doc """
  Hello world.

  ## Examples

      iex> InverseCaptcha.sum "1122"
      3
      iex> InverseCaptcha.sum "1111"
      4
      iex> InverseCaptcha.sum "1234"
      0
      iex> InverseCaptcha.sum "91212129"
      9

  """
  def sum(digits) do
    digits
    |> String.codepoints
    |> Enum.map(&String.to_integer/1)
    |> copy_first_to_end
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.filter(fn [a, b] -> a == b end)
    |> Enum.map(&List.first/1)
    |> Enum.sum
  end

  defp copy_first_to_end([h|t]), do: [h|t] ++ [h]
end
