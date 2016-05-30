defmodule Jot.HTML do
  @moduledoc false

  def expand_lines(lines) when is_list(lines) do
    lines |> expand() |> Enum.reverse
  end


  defp expand(lines, open_tags \\ [], current_depth \\ 0, acc \\ [])


  defp expand([h|t], open, depth, acc) when is_binary(h) do
    expand(t, open, depth, [h|acc])
  end

  defp expand([], [], _, acc),
    do: acc
end
