defmodule Jot.Parser.Comment do
  @moduledoc false
  @behaviour Jot.Parser

  alias Jot.HTML.Text

  def parse!(<<"/! "::utf8, t::binary>>, line, indent) do
    %Text{ content: html_comment(t), line: line, indent: indent }
  end

  def parse!(<<"/!"::utf8, t::binary>>, line, indent) do
    %Text{ content: html_comment(t), line: line, indent: indent }
  end

  def parse!(_, line, indent) do
    %Text{ content: "", line: line, indent: indent }
  end


  defp html_comment(content),
    do: "<!-- #{content} -->"
end
