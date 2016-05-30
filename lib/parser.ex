defmodule Jot.Parser do
  @moduledoc false

  @callback parse!(String.t, pos_integer, pos_integer) :: struct()


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
    type = case line(record, :content) do
      <<"|"::utf8, tail::binary>> -> Plain
      <<"/"::utf8, tail::binary>> -> Comment
      _                           -> Element
    end
    type.parse!(
      line(record, :content),
      line(record, :pos),
      line(record, :indent)
    )
  end
end
