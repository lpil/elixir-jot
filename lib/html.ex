defmodule Jot.HTML do

  defprotocol Chars do
    def open_fragments(line)
    def close_fragments(line)
  end

  @moduledoc false

  def expand_lines(lines) when is_list(lines) do
    lines |> expand() |> List.flatten |> Enum.reverse
  end


  defp expand(lines, open_tags \\ [], acc \\ [])

  defp expand([h|t], open, acc) do
    frags = Chars.open_fragments(h)
    expand(t, [h|open], [frags|acc])
  end

  defp expand([], [h|t], acc) do
    frags = Chars.close_fragments(h)
    expand([], t, [frags|acc])
  end

  defp expand([], [], acc),
    do: acc
end
