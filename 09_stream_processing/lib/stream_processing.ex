defmodule StreamProcessing do
  @moduledoc """
  http://adventofcode.com/2017/day/9
  """

  @doc ~S'''
  ## Examples

      iex> StreamProcessing.score "{}"
      1
      iex> StreamProcessing.score "{{{}}}"
      6
      iex> StreamProcessing.score "{{},{}}"
      5
      iex> StreamProcessing.score "{{{},{},{{}}}}"
      16
      iex> StreamProcessing.score "{<a>,<a>,<a>,<a>}"
      1
      iex> StreamProcessing.score "{{<ab>},{<ab>},{<ab>},{<ab>}}"
      9
      iex> StreamProcessing.score "{{<!!>},{<!!>},{<!!>},{<!!>}}"
      9
      iex> StreamProcessing.score "{{<a!>},{<a!>},{<a!>},{<ab>}}"
      3

  '''
  def score(groups) do
    score groups, 0, 1, :valid
  end

  defp score("", score, _, _), do: score
  defp score(<<"{", rest::binary>>, score, level, :valid), do: score rest, score + level, level + 1, :valid
  defp score(<<"}", rest::binary>>, score, level, :valid), do: score rest, score, level - 1, :valid
  defp score(<<"<", rest::binary>>, score, level, :valid), do: score rest, score, level, :garbage
  defp score(<<">", rest::binary>>, score, level, :garbage), do: score rest, score, level, :valid
  defp score(<<"!", _::binary-size(1), rest::binary>>, score, level, :garbage), do: score rest, score, level, :garbage
  defp score(<<_::binary-size(1), rest::binary>>, score, level, state), do: score rest, score, level, state
end
