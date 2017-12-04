defmodule HighEntropyPassphrases do
  @moduledoc """
  http://adventofcode.com/2017/day/4
  """

  @doc ~S'''
  ## Examples

  iex> HighEntropyPassphrases.count_valid """
  ...> aa bb cc dd ee
  ...> aa bb cc dd aa
  ...> aa bb cc dd aaa
  ...> """
  2

  '''
  def count_valid(passphrases) do
    passphrases
    |> String.trim
    |> String.split("\n")
    |> Enum.count(&valid?/1)
  end

  defp valid?(passphrase) do
    with words <- passphrase |> String.split do
      words |> Enum.uniq |> Enum.count == words |> Enum.count
    end
  end
end
