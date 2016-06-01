defmodule Jot.Line do
  @moduledoc false

  use Jot.Record, import: [:line]

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


  defp parse_indent(content, line, acc)

  defp parse_indent(<< " "::utf8, t::binary >>, line, acc) do
    indent = line(line, :indent) + 1
    line   = line(line, indent: indent)
    parse_indent(t, line, acc)
  end

  defp parse_indent("", line, acc) do
    parse_content("", line, acc)
  end

  defp parse_indent(content, line, acc) do
    parse_content(content, line, acc)
  end


  defp parse_content(content, line, acc)

  defp parse_content(<< "\n"::utf8, t::binary >>, line, acc) do
    n   = line(pos: line(line, :pos) + 1)
    acc = add(acc, line)
    parse_indent(t, n, acc)
  end

  defp parse_content("", line, acc) do
    add(acc, line)
  end

  defp parse_content(<< h::utf8, t::binary >>, line, acc) do
    content  = line(line, :content) <> <<h>>
    new_line = line(line, content: content)
    parse_content(t, new_line, acc)
  end


  defp add(acc, line) do
    case line(line, :content) do
      "" -> acc
      _  -> [line|acc]
    end
  end
end
