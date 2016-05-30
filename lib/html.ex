defmodule Jot.HTML do
  @moduledoc false

  alias __MODULE__.Element

  def expand_lines(lines) when is_list(lines) do
    lines |> expand() |> Enum.reverse
  end


  defp expand(lines, open_tags \\ [], current_depth \\ 0, acc \\ [])

  defp expand([h|t], open, depth, acc) when is_binary(h) do
    expand(t, open, depth, [h|acc])
  end

  defp expand([h|t], open, depth, acc) when is_tuple(h) do
    frags = Element.open_fragments(h)
    expand(t, [h|open], depth, frags ++ acc)
  end

  defp expand([], [h|t], depth, acc) when is_tuple(h) do
    frags = Element.close_fragments(h)
    expand([], t, depth, frags ++ acc)
  end

  defp expand([], [], _, acc),
    do: acc
end
