defmodule Jot.Parser do
  @moduledoc false

  @callback parse!(String.t, pos_integer, pos_integer) :: struct()


  alias __MODULE__.Element
  alias __MODULE__.Comment
  alias __MODULE__.Plain

  use Jot.Record, import: [:line]

  @doc """
  Parse a template into fragments.
  """
  def parse_template!(template) when is_binary(template) do
    template
    |> Jot.Line.from_template
    |> Enum.map(&parse_line!/1)
    |> Jot.HTML.expand_lines
  end


  defmacro is_line(r) do
    quote do
      is_tuple(unquote(r)) and elem(unquote(r), 0) == :line
    end
  end

  @doc """
  Takes a line record and parses it using a parser suitable for the content.
  """
  def parse_line!(record) when is_line(record) do
    type = case line(record, :content) do
      <<"|"::utf8, _::binary>> -> Plain
      <<"/"::utf8, _::binary>> -> Comment
      _                        -> Element
    end
    type.parse!(
      line(record, :content),
      line(record, :pos),
      line(record, :indent)
    )
  end
end
