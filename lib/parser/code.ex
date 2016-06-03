defmodule Jot.Parser.Code do
  @moduledoc false
  @behaviour Jot.Parser

  alias Jot.HTML.Code

  def parse!(<<"= "::utf8, t::binary>>, line, indent) do
    %Code{ content: t, marker: "=", line: line, indent: indent }
  end

  def parse!(<<"="::utf8, t::binary>>, line, indent) do
    %Code{ content: t, marker: "=", line: line, indent: indent }
  end

  def parse!(<<"- "::utf8, t::binary>>, line, indent) do
    %Code{ content: t, marker: "", line: line, indent: indent }
  end

  def parse!(<<"-"::utf8, t::binary>>, line, indent) do
    %Code{ content: t, marker: "", line: line, indent: indent }
  end
end
