defmodule Jot.Parser do
  @moduledoc false

  @callback parse!(String.t) :: tuple()


  alias __MODULE__.Element
  alias __MODULE__.Comment
  alias __MODULE__.Plain

  require Record
  import  Record, only: [defrecordp: 2, extract: 2]
  defrecordp :line, extract(:line, from: "src/jot_records.hrl")

  @doc """
  Parse a template into fragments.
  """
  def parse_template!(template) when is_binary(template) do
    template
    |> Jot.Line.from_template
    |> Enum.map(&parse_line!/1)
    |> Jot.HTML.expand_lines
  end

  @doc """
  Takes a line record and parses it using a parser suitable for the content.
  """
  def parse_line!(record) when is_tuple(record) and elem(record, 0) == :line do
    record
    |> line(:content)
    |> parse_content()
  end


  defp parse_content(<<"|"::utf8, tail::binary>>),
    do: Plain.parse!(tail)

  defp parse_content(<<"/"::utf8, tail::binary>>),
    do: Comment.parse!(tail)

  defp parse_content(content),
    do: Element.parse!(content)
end
