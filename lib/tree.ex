defmodule Jot.Tree do
  @moduledoc """
  Manipulating syntax trees.
  """

  require Record
  import  Record, only: [defrecordp: 2, extract: 2]
  defrecordp :line, extract(:line, from: "src/jot_records.hrl")
  defrecordp :tree, extract(:tree, from: "src/jot_records.hrl")

  @doc """
  Build a tree from lines based upon indentation.
  """
  def from_lines([]) do
    []
  end
  def from_lines([h|_] = lines) do
    indent = line(h, :indent)
    lines
    |> from_lines([], indent)
  end

  defp from_lines([h|t], acc, indent) do
    {c, t}   = extract_children(t, indent)
    children = from_lines(c)
    tree     = tree(value: h, children: children)
    from_lines(t, [tree|acc], indent)
  end

  defp from_lines([], acc, _indent) do
    Enum.reverse(acc)
  end


  defp extract_children(lines, indent) when is_list(lines) do
    lines |> Enum.split_while(
      fn x -> line(x, :indent) > indent
    end)
  end
end
