defmodule Jot.Parser.Plain do
  @moduledoc false

  @behaviour Jot.Parser

  def parse!(<<" "::utf8, content::binary>>),
    do: content

  def parse!(content),
    do: content
end
