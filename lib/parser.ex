defmodule Jot.Parser do
  @moduledoc false

  @callback parse!(tuple()) :: struct()


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
    case line(record, :content) do

      <<"|"::utf8, tail::binary>> ->
        Plain.parse!(record)

      <<"/"::utf8, tail::binary>> ->
        Comment.parse!(record)

      _ ->
        Element.parse!(record)

    end
  end
end
