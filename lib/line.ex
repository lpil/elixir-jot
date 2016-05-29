defmodule Jot.Line do
  @moduledoc """
  Responsible for splitting a Jot template into lines for parsing.
  """

  require Record
  import  Record, only: [defrecordp: 2, extract: 2]
  defrecordp :line, extract(:line, from: "src/jot_records.hrl")

  @doc """
  Split a template into lines for parsing.
  """
  def from_template(template) when is_binary(template) do
    template
    |> split()
    |> Enum.reverse()
  end

  defp split(template) do
    parse_indent(template, line(), [])
  end


  defp parse_indent(<< " "::utf8, t::binary >>, l, ls) do
    l = line(l, indent: line(l, :indent) + 1)
    parse_indent(t, l, ls)
  end

  defp parse_indent("", l, ls) do
    parse_content("", l, ls)
  end

  defp parse_indent(content, l, ls) do
    parse_content(content, l, ls)
  end


  defp parse_content(<< "\n"::utf8, t::binary >>, l, ls) do
    n = line(pos: line(l, :pos) + 1)
    parse_indent(t, n, ls |> add(l))
  end

  defp parse_content("", l, ls) do
    ls |> add(l)
  end

  defp parse_content(<< h::utf8, t::binary >>, l, ls) do
    c = line(l, :content) <> <<h>>
    l = line(l, content: c)
    parse_content(t, l, ls)
  end


  defp add(ls, l) do
    case line(l, :content) do
      "" -> ls
      _  -> [l|ls]
    end
  end
end
