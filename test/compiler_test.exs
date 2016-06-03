defmodule Jot.CompilerTest do
  use ExUnit.Case, async: true

  test "compile/2" do
    {result, _} =
      """
      - x = " world!"
      h1 Hello
        = x
      """
      |> Jot.Compiler.compile
      |> Code.eval_quoted
    assert result == "<h1>Hello world!</h1>"
  end
end
