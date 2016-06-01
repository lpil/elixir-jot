defmodule Jot.HTML.Element do
  @moduledoc false

  defstruct type:       "div",
            line:       1,
            indent:     0,
            content:    "",
            class:      nil,
            id:         nil,
            attributes: []
end

defimpl Jot.HTML.Chars, for: Jot.HTML.Element do
  def open_fragments(el) do
    attributes = format_attributes(el)
    fragments  = ["<#{el.type}"| attributes] ++ [">", el.content]
    Jot.Fragment.consolidate_literals(fragments)
  end

  def close_fragments(%{ type: type }) do
    ["</#{type}>"]
  end


  defp format_attributes(el) do
    attrs = [{"id", el.id}| el.attributes]
    attrs |> Enum.map(&format_attribute/1)
  end


  defp format_attribute({_name, nil}),
    do: ""

  defp format_attribute({name, value}),
    do: ~s( #{name}="#{value}")
end
