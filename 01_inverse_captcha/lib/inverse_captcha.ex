defmodule InverseCaptcha do
  @moduledoc """
  http://adventofcode.com/2017/day/1
  """

  @doc """
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

  @doc """
  ## Examples

      iex> InverseCaptcha.sum2 "1212"
      6
      iex> InverseCaptcha.sum2 "1221"
      0
      iex> InverseCaptcha.sum2 "123425"
      4
      iex> InverseCaptcha.sum2 "12131415"
      4

  """
  def sum2(input) do
    with digits <- digits(input),
         shifted_digits <- shift(digits) do
      digits
      |> Enum.zip(shifted_digits)
      |> Enum.filter(fn {a, b} -> a == b end)
      |> Enum.map(fn {a, _} -> a end)
      |> Enum.sum
    end
  end

  defp digits(str) do
    str
    |> String.codepoints
    |> Enum.map(&String.to_integer/1)
  end

  defp shift(digits) do
    digits
    |> Stream.cycle
    |> Stream.drop(length(digits) / 2)
    |> Enum.take(length digits)
  end
end
