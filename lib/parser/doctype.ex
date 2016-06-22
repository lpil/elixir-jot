defmodule Jot.Parser.Doctype do
  @moduledoc false
  @behaviour Jot.Parser

  alias Jot.HTML.Doctype

  @types [
    "html",
    "xml",
    "transitional",
    "strict",
    "frameset",
    "1.1",
    "basic",
    "mobile",
  ]

  def parse!(<<"doctype "::utf8, type::binary>>, line, indent)
  when type in @types
  do
    %Doctype{ type: type, line: line, indent: indent }
  end

end
