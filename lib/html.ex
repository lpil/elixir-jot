defmodule Jot.HTML do
  @moduledoc false

  alias Jot.HTML.Chars
  alias Jot.Fragment

  def expand_lines(lines) when is_list(lines) do
    lines
    |> expand()
    |> List.flatten
    |> Enum.reverse
    |> Fragment.consolidate_literals
  end


  defp expand(lines, open_tags \\ [], acc \\ [])

  defp expand([next|_] = lines, [prev|_] = open, acc) do
    if next.indent > prev.indent do
      push_open(lines, open, acc)
    else
      pop_open(lines, open, acc)
    end
  end

  defp expand([_|_] = lines, [], acc),
    do: push_open(lines, [], acc)

  defp expand([], [_|_] = open, acc),
    do: pop_open([], open, acc)

  defp expand([], [],acc),
    do: acc


  defp push_open(lines, open, acc)

  defp push_open([h|t], open, acc) do
    frags = Chars.open_fragments(h)
    expand(t, [h|open], [frags|acc])
  end

  defp pop_open(lines, [h|t], acc) do
    frags = Chars.close_fragments(h)
    expand(lines, t, [frags|acc])
  end
end
