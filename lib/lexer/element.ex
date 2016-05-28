defmodule Jot.Lexer.Element do
  @moduledoc """
  Tokenizes an element template.
  """

  def tokenize!(template) when is_binary(template) do
    template |> to_char_list |> tokenize!
  end

  def tokenize!(template) when is_list(template) do
    {:ok, tokens, _} = template |> :jot_element_lexer.string
    tokens
  end
end
