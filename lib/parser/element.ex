defmodule Jot.Parser.Element do
  @moduledoc """
  Parse an element string into a data structure.
  """

  def parse!(template) when is_binary(template) do
    {:ok, element} =
      template
      |> Jot.Lexer.Element.tokenize!()
      |> :jot_element_parser.parse()
    element
  end
end
