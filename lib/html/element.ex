defmodule Jot.HTML.Element do
  @moduledoc false

  defstruct type:       "div",
            line:       1,
            indent:     0,
            content:    "",
            class:      "",
            id:         "",
            attributes: []

  require Record
  import  Record, only: [defrecordp: 2, extract: 2]
  defrecordp :element, extract(:element, from: "src/jot_records.hrl")

  def open_fragments(el) do
    type = element(el, :type)
    ["<#{type}>"]
  end

  def close_fragments(el) do
    type = element(el, :type)
    ["</#{type}>"]
  end
end
