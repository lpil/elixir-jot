defmodule Jot.HTMLTest do
  use ExUnit.Case, async: true

  defmacro lines ~> fragments do
    quote do
      assert unquote(fragments) == Jot.HTML.expand_lines(unquote(lines))
    end
  end

  use Jot.Record, import: [:element]

  test "strings are not expanded" do
    ["hello", "world"] ~> ["hello", "world"]
  end

  test "plain tag" do
    [
      element(type: "h1"),
    ] ~> [
      "<h1>", "</h1>",
    ]
  end

  @tag :skip
  test "multiple plain tags" do
    [
      element(type: "h1"),
      element(type: "h2"),
      element(type: "h3"),
    ] ~> [
      "<h1>", "</h1>",
      "<h2>", "</h2>",
      "<h3>", "</h3>",
    ]
  end
end
