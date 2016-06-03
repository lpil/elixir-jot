defmodule Jot.HTMLTest do
  use ExUnit.Case, async: true
  use Jot.Record,  import: [:element]

  alias Jot.HTML.Element
  alias Jot.HTML.Text
  alias Jot.HTML.Code

  defmacro lines ~> fragments do
    quote do
      assert unquote(fragments) == Jot.HTML.expand_lines(unquote(lines))
    end
  end


  test "text is reduced to content" do
    [
      %Text{ content: "hello " },
      %Text{ content: "world!" },
    ] ~> [
      "hello world!",
    ]
  end

  test "plain tag" do
    [
      %Element{ type: "h1" },
    ] ~> [
      "<h1></h1>",
    ]
  end

  test "id" do
    [
      %Element{ id: "main" },
    ] ~> [
      ~S(<div id="main"></div>),
    ]
    [
      %Element{ attributes: [{"id", "main"}] },
    ] ~> [
      ~S(<div id="main"></div>),
    ]
  end

  test "classes" do
    [
      %Element{ class: "wide" },
    ] ~> [
      ~S(<div class="wide"></div>),
    ]
    [
      %Element{ class: "wide", attributes: [{"class", "big small"}] },
    ] ~> [
      ~S(<div class="wide big small"></div>),
    ]
    [
      %Element{ attributes: [{"class", "big small"}] },
    ] ~> [
      ~S(<div class="big small"></div>),
    ]
  end

  test "attributes" do
    [
      %Element{
        type: "h1",
        attributes: [{"name", "Angus"}, {"class", "bold"}]
      },
    ] ~> [~S(<h1 name="Angus" class="bold"></h1>)]
    [
      %Element{
        type: "a",
        class: "b",
        id: "z",
        attributes: [{"href", "/"}, {"class", "c"}]
      },
    ] ~> [~S(<a id="z" href="/" class="b c"></a>)]
  end

  test "content" do
    [
      %Element{ type: "small", content: "ATTENTION!" },
      %Element{ type: "blockquote", content: "huh?" },
    ] ~> [
      "<small>ATTENTION!</small><blockquote>huh?</blockquote>",
    ]
  end

  test "adjacent tags" do
    [
      %Element{ type: "h1" },
      %Element{ type: "h2" },
      %Element{ type: "h3" },
    ] ~> [
      "<h1></h1><h2></h2><h3></h3>",
    ]
  end

  test "nesting" do
    [
      %Element{ type: "h1", indent: 0, content: " " },
      %Element{ type: "h2", indent: 1 },
      %Text{ indent: 2, content: "Nice nesting" },
      %Element{ type: "div", indent: 0 },
    ] ~> [
      "<h1> <h2>Nice nesting</h2></h1><div></div>",
    ]
  end

  test "code" do
    [
      %Element{ type: "h1", indent: 0, },
      %Code{ marker: "=", indent: 2, content: "get_title()" },
    ] ~> [
      "<h1>",
      %Code{ marker: "=", indent: 2, content: "get_title()" },
      "</h1>",
    ]
  end
end
