defmodule Jot.Parser do
  @moduledoc false

  @callback parse!(String.t) :: tuple()


  alias __MODULE__.Element
  alias __MODULE__.Plain

  require Record
  import  Record, only: [defrecordp: 2, extract: 2]
  defrecordp :line, extract(:line, from: "src/jot_records.hrl")

  @doc """
  Takes a line record and parses it using a parser suitable for the content.
  """
  def parse!(record) when is_tuple(record) and elem(record, 0) == :line do
    record
    |> line(:content)
    |> parse_content()
  end


  defp parse_content(<<"|"::utf8, tail::binary>>),
    do: Plain.parse!(tail)

  defp parse_content(<<"/"::utf8, _::binary>>),
    do: nil

  defp parse_content(content),
    do: Element.parse!(content)
end
