defmodule Jot.Parser.Comment do
  @moduledoc false

  @behaviour Jot.Parser

  def parse!(<<"! "::utf8, t::binary>>),
    do: html_comment(t)

  def parse!(<<"!"::utf8, t::binary>>),
    do: html_comment(t)

  def parse!(_), do: nil


  defp html_comment(content) do
    "<!-- #{content} -->"
  end
end
