defmodule RecursiveCircus do
  @moduledoc """
  http://adventofcode.com/2017/day/7
  """

  @doc ~S'''
  ## Examples

      iex> RecursiveCircus.bottom """
      ...> pbga (66)
      ...> xhth (57)
      ...> ebii (61)
      ...> havc (66)
      ...> ktlj (57)
      ...> fwft (72) -> ktlj, cntj, xhth
      ...> qoyq (66)
      ...> padx (45) -> pbga, havc, qoyq
      ...> tknk (41) -> ugml, padx, fwft
      ...> jptl (61)
      ...> ugml (68) -> gyxo, ebii, jptl
      ...> gyxo (61)
      ...> cntj (57)
      ...> """
      "tknk"
  '''
  def bottom(input) do
    input
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&parse/1)
    |> find_parents
    |> find_root
  end

  defp parse(line) do
    case Regex.run ~r/^(\S*) \((\d*)\)(?: -> (.*))?/, line, capture: :all_but_first do
      [name, weight, child_str] -> {name, weight, child_str |> String.split(", ")}
      [name, weight] -> {name, weight, []}
    end
  end

  defp find_parents(nodes) do
    nodes
    |> Enum.reduce(%{}, &add_node/2)
  end

  defp add_node({name, _weight, children}, parents_map) do
    children
    |> Enum.reduce(parents_map, fn child, parents_map -> add_or_update_parent parents_map, child, name end)
    |> Map.update(name, nil, & &1)
  end

  defp add_or_update_parent(parents_map, child, parent) do
    parents_map
    |> Map.update(child, parent, fn _ -> parent end)
  end

  defp find_root(nodes) do
    nodes
    |> Enum.find(fn {_, parent} -> is_nil parent end)
    |> extract_name
  end

  defp extract_name({name, _parent}), do: name
end
