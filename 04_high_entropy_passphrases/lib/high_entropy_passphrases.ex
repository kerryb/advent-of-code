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
  def count_valid(passphrases), do: count_valid passphrases, &words_all_different?/1

  @doc ~S'''
  ## Examples

  iex> HighEntropyPassphrases.count_valid2 """
  ...> abcde fghij
  ...> abcde xyz ecdab
  ...> """
  1
  iex> HighEntropyPassphrases.count_valid2 "a ab abc abd abf abj"
  1
  iex> HighEntropyPassphrases.count_valid2 "iiii oiii ooii oooi oooo"
  1
  iex> HighEntropyPassphrases.count_valid2 "oiii ioii iioi iiio"
  0
  '''
  def count_valid2(passphrases), do: count_valid passphrases, &no_anagrams?/1

  def count_valid(passphrases, validator) do
    passphrases
    |> String.trim
    |> String.split("\n")
    |> Enum.count(validator)
  end

  defp words_all_different?(passphrase) do
    with words <- passphrase |> String.split do
      words |> Enum.uniq |> Enum.count == words |> Enum.count
    end
  end

  defp no_anagrams?(passphrase) do
    with words <- passphrase |> String.split |> Enum.map(&sort_letters/1) do
      words |> Enum.uniq |> Enum.count == words |> Enum.count
    end
  end

  defp sort_letters(word) do
    word
    |> String.codepoints
    |> Enum.sort
    |> Enum.join
  end

  # defp no_anagrams?(passphrase) when is_binary passphrase do
  #   passphrase
  #   |> String.split
  #   |> no_anagrams?
  # end
  # defp no_anagrams?([_|[]]), do: true
  # defp no_anagrams?([word | words]) do
    
  # end
end
