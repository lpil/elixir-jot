defmodule Jot.Parser.Plain do
  @moduledoc false

  @behaviour Jot.Parser

  require Record
  import  Record, only: [defrecordp: 2, extract: 2]
  defrecordp :line, extract(:line, from: "src/jot_records.hrl")

  def parse!(record) when is_tuple(record) do
    record |> line(:content) |> parse!()
  end

  def parse!(<<"| "::utf8, content::binary>>),
    do: content

  def parse!(<<"|"::utf8, content::binary>>),
    do: content
end
