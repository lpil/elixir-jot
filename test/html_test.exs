defmodule Jot.HTMLTest do
  use ExUnit.Case, async: true

  defmacro lines ~> fragments do
    quote do
      assert unquote(fragments) == Jot.HTML.expand_lines(unquote(lines))
    end
  end

  test "strings are not expended" do
    ["hello", "world"] ~> ["hello", "world"]
  end
end
