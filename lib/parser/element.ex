defmodule Jot.Parser.Element do
  @moduledoc false

  @behaviour Jot.Parser

  use Jot.Record, import: [:element, :line]

  @doc """
  Parse a line containing an template HTML element into a data structure.
  """
  def parse!(template, line, indent) when is_binary(template) do
    {:ok, el} =
      template
      |> Jot.Lexer.Element.tokenize!()
      |> :jot_element_parser.parse()
    %Jot.HTML.Element{
      type:       element(el, :type),
      attributes: element(el, :attributes),
      content:    element(el, :content),
      class:      element(el, :class),
      id:         element(el, :id),
      indent:     indent,
      line:       line,
    }
  end
end
