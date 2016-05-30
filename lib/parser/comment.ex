defmodule Jot.Parser.Comment do
  @moduledoc false

  @behaviour Jot.Parser

  def parse!(<<"/! "::utf8, t::binary>>, _line, _indent),
    do: html_comment(t)

  def parse!(<<"/!"::utf8, t::binary>>, _line, _indent),
    do: html_comment(t)

  def parse!(_, _, _),
    do: ""


  defp html_comment(content),
    do: "<!-- #{content} -->"
end
