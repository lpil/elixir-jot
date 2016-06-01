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
    attributes = build_attributes(el)
    fragments  = ["<#{el.type}"| attributes] ++ [">", el.content]
    Jot.Fragment.consolidate_literals(fragments)
  end

  def close_fragments(%{ type: type }) do
    ["</#{type}>"]
  end


  defp build_attributes(el) do
    [{"id", el.id}| el.attributes]
    |> do_build_attributes(el.class)
    |> Enum.reverse
  end


  defp do_build_attributes(attrs, class, acc \\ [])

  defp do_build_attributes([], nil, acc) do
    acc
  end

  defp do_build_attributes([], class, acc) do
    [format_attribute({"class", class}) | acc]
  end

  defp do_build_attributes([{"class", c2}|t], c1, acc)
  when c1 !== nil
  do
    attr = format_attribute({"class", "#{c1} #{c2}"})
    acc  = [attr|acc]
    do_build_attributes(t, nil, acc)
  end

  defp do_build_attributes([h|t], class, acc) do
    acc = [format_attribute(h)|acc]
    do_build_attributes(t, class, acc)
  end


  defp format_attribute({_name, nil}),
    do: ""

  defp format_attribute({name, value}),
    do: ~s( #{name}="#{value}")
end
