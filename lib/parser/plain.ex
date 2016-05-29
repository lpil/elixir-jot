defmodule Jot.Parser.Plain do
  @moduledoc false

  @behaviour Jot.Parser

  def parse!(<<" "::utf8, content::binary>>),
    do: [plain: content]

  def parse!(content),
    do: [plain: content]
end
