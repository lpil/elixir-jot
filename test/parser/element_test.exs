defmodule Jot.Parser.ElementTest do
  use ExUnit.Case, async: true

  alias Jot.Parser
  alias Jot.HTML.Element

  require Record
  import  Record, only: [defrecord: 2, extract: 2]
  defrecord :element, extract(:element, from: "src/jot_records.hrl")
  defrecord :line,    extract(:line,    from: "src/jot_records.hrl")

  defmacro template ~> el do
    quote do
      assert unquote(el) == Parser.Element.parse!(unquote(template), 1, 0)
    end
  end

  test "bare elements" do
    "h1"   ~> %Element{ type: "h1" }
    "head" ~> %Element{ type: "head" }
    "ul"   ~> %Element{ type: "ul" }
  end

  test "bare class" do
    ".btn"  ~> %Element{ type: "div", class: "btn" }
    ".spin" ~> %Element{ type: "div", class: "spin" }
    ".back" ~> %Element{ type: "div", class: "back" }
  end

  test "bare classs" do
    ".what.who.slim-shady"  ~> %Element{ class: "what who slim-shady" }
  end

  test "bare id" do
    "#logo" ~> %Element{ type: "div", id: "logo" }
    "#next" ~> %Element{ type: "div", id: "next" }
    "#old"  ~> %Element{ type: "div", id: "old" }
  end

  test "bare id and classes" do
    "#logo.stylish"   ~> %Element{ id: "logo", class: "stylish" }
    "#logo.super.rad" ~> %Element{ id: "logo", class: "super rad" }
  end

  test "type, id, and classes" do
    "thing#logo.big" ~> %Element{ type: "thing", id: "logo", class: "big" }
  end

  test "elements with content" do
    "p Hi"   ~> %Element{ type: "p",  content: "Hi" }
    "h1  "   ~> %Element{ type: "h1", content: " " }
    "a b c!" ~> %Element{ type: "a",  content: "b c!" }

    text = "The quick brown fox jumped over the lazy dog."
    "blockquote #{text}" ~> %Element{ type: "blockquote", content: text }

    text = ~S(They said "what?". With quotes. "". Like this -> ")
    "#sup #{text}" ~> %Element{ id: "sup", content: text }

    text = " == !=== =:= Huh?"
    ".foo #{text}" ~> %Element{ class: "foo", content: text }
  end

  test "elements with attributes" do
    ~S[a(href="/")]      ~> %Element{ type: "a", attributes: [{"href", "/"}] }
    ~S[div(a="1" b="2")] ~> %Element{ attributes: [{"a", "1"}, {"b", "2"}] }
  end

  test "elements with attributes and content" do
    ~S[div(z="Z") ok] ~>
      %Element{ attributes: [{"z", "Z"}], content: "ok" }

    ~S[div(z="Z" l="p") Hi there!] ~>
      %Element{ attributes: [{"z", "Z"}, {"l", "p"}], content: "Hi there!" }
  end
end
