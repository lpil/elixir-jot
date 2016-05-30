defmodule Jot.HTML.Element do
  @moduledoc false

  defstruct type:       "div",
            line:       1,
            indent:     0,
            content:    "",
            class:      "",
            id:         "",
            attributes: []
end

defimpl Jot.HTML.Chars, for: Jot.HTML.Element do
  def open_fragments(%{ type: type, content: content }) do
    ["<#{type}>#{content}"]
  end

  def close_fragments(%{ type: type }) do
    ["</#{type}>"]
  end
end
