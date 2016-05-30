defmodule Jot.Fragment do
  @moduledoc false

  alias Jot.HTML.Text, as: T

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

  defp consolidate([%T{} = first | [%T{} = second | tail]], acc) do
    head = %T{ content: first.content <> second.content }
    consolidate([head|tail], acc)
  end

  defp consolidate([h|t], acc) do
    consolidate(t, [h|acc])
  end

end
