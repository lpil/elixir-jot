defmodule Jot.Parser.Plain do
  @moduledoc false

  @behaviour Jot.Parser

  def parse!(<<"| "::utf8, content::binary>>, _line, _indent),
    do: content

  def parse!(<<"|"::utf8, content::binary>>, _line, _indent),
    do: content
end
