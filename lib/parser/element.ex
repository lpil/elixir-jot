defmodule Jot.Parser.Element do
  @moduledoc false

  @behaviour Jot.Parser

  @doc """
  Parse a line containing an template HTML element into a data structure.
  """
  def parse!(template) when is_binary(template) do
    {:ok, element} =
      template
      |> Jot.Lexer.Element.tokenize!()
      |> :jot_element_parser.parse()
    element
  end
end
