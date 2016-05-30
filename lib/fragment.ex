defmodule Jot.Fragment do
  @moduledoc false

  @doc """
  Take a list of HTML fragments and concat adjacent text components together.
  """
  def consolidate_literals(fragments) do
    fragments |> consolidate() |> Enum.reverse
  end

  defp consolidate(fragments, acc \\ [])

  defp consolidate([], acc) do
    acc
  end

  defp consolidate([first|[second|tail]], acc)
  when is_binary(first)
  and is_binary(second)
  do
    head = first <> second
    consolidate([head|tail], acc)
  end

  defp consolidate([h|t], acc) do
    consolidate(t, [h|acc])
  end

end
