defmodule Jot.HTMLTest do
  use ExUnit.Case, async: true
  use Jot.Record,  import: [:element]

  alias Jot.HTML.Code
  alias Jot.HTML.Doctype
  alias Jot.HTML.Element
  alias Jot.HTML.Text

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

  test "doctypes" do
    [%Doctype{ type: "html" }] ~> [
      "<!DOCTYPE html>"
    ]
    [%Doctype{ type: "xml" }] ~> [
      ~S(<?xml version="1.0" encoding="utf-8" ?>)
    ]
    [%Doctype{ type: "transitional" }] ~> [
      ~S(<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">)
    ]
    [%Doctype{ type: "strict" }] ~> [
      ~S(<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">)
    ]
    [%Doctype{ type: "frameset" }] ~> [
      ~S(<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">)
    ]
    [%Doctype{ type: "1.1" }] ~> [
      ~S(<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">)
    ]
    [%Doctype{ type: "basic" }] ~> [
      ~S(<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML Basic 1.1//EN" "http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd">)
    ]
    [%Doctype{ type: "mobile" }] ~> [
      ~S(<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">)
    ]
    [%Doctype{ type: "some custom type" }] ~> [
      ~S(<!DOCTYPE some custom type>)
    ]
  end
end
