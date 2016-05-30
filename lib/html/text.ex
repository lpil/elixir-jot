defmodule Jot.HTML.Text do
  @moduledoc false

  defstruct line:       1,
            indent:     0,
            content:    ""
end

defimpl Jot.HTML.Chars, for: Jot.HTML.Text do
  def open_fragments(%{ content: content }) do
    [content]
  end

  def close_fragments(_) do
    []
  end
end

