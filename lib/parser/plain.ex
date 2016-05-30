defmodule Jot.Parser.Plain do
  @moduledoc false

  @behaviour Jot.Parser

  alias Jot.HTML.Text

  def parse!(<<"| "::utf8, content::binary>>, line, indent),
    do: %Text{ line: line, indent: indent, content: content }

  def parse!(<<"|"::utf8, content::binary>>, line, indent),
    do: %Text{ line: line, indent: indent, content: content }
end
