defmodule Jot.HTML.Element do
  @moduledoc false

  defstruct type:       "div",
            line:       1,
            indent:     0,
            content:    "",
            class:      "",
            id:         "",
            attributes: []

  use Jot.Record, import: [:element]

  def open_fragments(el) do
    type = element(el, :type)
    ["<#{type}>"]
  end

  def close_fragments(el) do
    type = element(el, :type)
    ["</#{type}>"]
  end
end
