defmodule Jot.Compiler do
  @moduledoc false

  alias Jot.HTML

  @engine EEx.SmartEngine

  @doc """
  Convert a Jot binary string template into Elixir AST.
  """
  def compile(template, _opts \\ []) do
    template
    |> Jot.Parser.parse_template!
    |> to_ast(@engine)
  end

  defp to_ast(fragments, engine) do
    fragments
    |> Enum.reduce("", fn

      (fragment, buffer) when is_binary(fragment) ->
        engine.handle_text(buffer, fragment)

      (fragment = %HTML.Code{}, buffer) ->
        expression = Code.string_to_quoted!(fragment.content)
        engine.handle_expr(buffer, fragment.marker, expression)
    end)
  end
end
