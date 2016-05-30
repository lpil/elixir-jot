defmodule Jot.HTMLTest do
  use   ExUnit.Case, async: true
  use   Jot.Record,  import: [:element]

  alias Jot.HTML.Element
  alias Jot.HTML.Text

  defmacro lines ~> fragments do
    quote do
      assert unquote(fragments) == Jot.HTML.expand_lines(unquote(lines))
    end
  end


  test "text is reduced to content" do
    [
      %Text{ content: "hello" },
      %Text{ content: "world" },
    ] ~> [
      "hello",
      "world",
    ]
  end

  test "plain tag" do
    [
      %Element{ type: "h1" },
    ] ~> [
      "<h1>", "</h1>",
    ]
  end

  test "adjacent plain tags" do
    [
      %Element{ type: "h1" },
      %Element{ type: "h2" },
      %Element{ type: "h3" },
    ] ~> [
      "<h1>", "</h1>",
      "<h2>", "</h2>",
      "<h3>", "</h3>",
    ]
  end
end
