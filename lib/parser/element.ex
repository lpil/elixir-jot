defmodule Jot.Parser.Element do
  @moduledoc false

  @behaviour Jot.Parser

  require Record
  import  Record, only: [defrecordp: 2, extract: 2]
  defrecordp :line,    extract(:line,    from: "src/jot_records.hrl")
  defrecordp :element, extract(:element, from: "src/jot_records.hrl")

  @doc """
  Parse a line containing an template HTML element into a data structure.
  """
  def parse!(l) when is_tuple(l) do
    {:ok, el} =
      l
      |> line(:content)
      |> Jot.Lexer.Element.tokenize!()
      |> :jot_element_parser.parse()
    %Jot.HTML.Element{
      type:       element(el, :type),
      attributes: element(el, :attributes),
      content:    element(el, :content),
      class:      element(el, :class),
      id:         element(el, :id),
      indent:     line(l, :indent),
      line:       line(l, :pos),
    }
  end
end
