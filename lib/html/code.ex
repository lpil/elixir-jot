defmodule Jot.HTML.Code do
  @moduledoc false

  defstruct marker:     "",
            line:       1,
            indent:     0,
            content:    ""
end

defimpl Jot.HTML.Chars, for: Jot.HTML.Code do
  def open_fragments(el) do
    el
  end

  def close_fragments(_) do
    []
  end
end
