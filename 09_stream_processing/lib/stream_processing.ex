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
    {score, _garbage} = score groups, 0, 0, 1, :valid
    score
  end

  @doc ~S'''
  ## Examples

      iex> StreamProcessing.garbage "<>"
      0
      iex> StreamProcessing.garbage "<random characters>"
      17
      iex> StreamProcessing.garbage "<<<<>"
      3
      iex> StreamProcessing.garbage "<{!>}>"
      2
      iex> StreamProcessing.garbage "<!!>"
      0
      iex> StreamProcessing.garbage "<!!!>>"
      0
      iex> StreamProcessing.garbage ~s{<{o"i!a,<{i<a>}
      10

  '''
  def garbage(groups) do
    {_score, garbage} = score groups, 0, 0, 1, :valid
    garbage
  end

  defp score("", score, garbage, _, _), do: {score, garbage}
  defp score(<<"{", rest::binary>>, score, garbage, level, :valid) do
    score rest, score + level, garbage, level + 1, :valid
  end
  defp score(<<"}", rest::binary>>, score, garbage, level, :valid) do
    score rest, score, garbage, level - 1, :valid
  end
  defp score(<<"<", rest::binary>>, score, garbage, level, :valid) do
    score rest, score, garbage, level, :garbage
  end
  defp score(<<">", rest::binary>>, score, garbage, level, :garbage) do
    score rest, score, garbage, level, :valid
  end
  defp score(<<"!", _::binary-size(1), rest::binary>>, score, garbage, level, :garbage) do
    score rest, score, garbage, level, :garbage
  end
  defp score(<<_::binary-size(1), rest::binary>>, score, garbage, level, :garbage) do
    score rest, score, garbage + 1, level, :garbage
  end
  defp score(<<_::binary-size(1), rest::binary>>, score, garbage, level, :valid) do
    score rest, score, garbage, level, :valid
  end
end
