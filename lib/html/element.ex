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
  def open_fragments(el) do
    attributes = format_attributes(el.attributes)
    ["<#{el.type}#{attributes}>#{el.content}"]
  end

  def close_fragments(%{ type: type }) do
    ["</#{type}>"]
  end


  defp format_attributes(attrs) do
    Enum.map(attrs, &format_attribute/1)
  end

  defp format_attribute({name, value}) do
    ~s( #{name}="#{value}")
  end
end
