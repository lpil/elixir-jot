defmodule Jot.Parser.ElementTest do
  use ExUnit.Case, async: true

  alias Jot.Parser.Element

  require Record
  import  Record, only: [defrecord: 2, extract: 2]
  defrecord :element, extract(:element, from: "src/jot_records.hrl")

  defmacro template ~> element do
    quote do
      assert unquote(element) == Element.parse!(unquote(template))
    end
  end

  test "bare elements" do
    "h1"   ~> element(type: "h1")
    "head" ~> element(type: "head")
    "ul"   ~> element(type: "ul")
  end

  test "bare class" do
    ".btn"  ~> element(type: "div", class: "btn")
    ".spin" ~> element(type: "div", class: "spin")
    ".back" ~> element(type: "div", class: "back")
  end

  test "bare classs" do
    ".what.who.slim-shady"  ~> element(class: "what who slim-shady")
  end

  test "bare id" do
    "#logo" ~> element(type: "div", id: "logo")
    "#next" ~> element(type: "div", id: "next")
    "#old"  ~> element(type: "div", id: "old")
  end

  test "bare id and classes" do
    "#logo.stylish"   ~> element(id: "logo", class: "stylish")
    "#logo.super.rad" ~> element(id: "logo", class: "super rad")
  end

  test "type, id, and classes" do
    "thing#logo.big" ~> element(type: "thing", id: "logo", class: "big")
  end

  test "elements with content" do
    "p Hi"   ~> element(type: "p",  content: "Hi")
    "h1  "   ~> element(type: "h1", content: " ")
    "a b c!" ~> element(type: "a",  content: "b c!")

    text = "The quick brown fox jumped over the lazy dog."
    "blockquote #{text}" ~> element(type: "blockquote", content: text)

    text = ~S(They said "what?". With quotes. "". Like this -> ")
    "#sup #{text}" ~> element(id: "sup", content: text)

    text = " == !=== =:= Huh?"
    ".foo #{text}" ~> element(class: "foo", content: text)
  end

  test "elements with attributes" do
    ~S[a(href="/")]      ~> element(type: "a", attributes: [{"href", "/"}])
    ~S[div(a="1" b="2")] ~> element(attributes: [{"a", "1"}, {"b", "2"}])
  end

  test "elements with attributes and content" do
    ~S[div(z="Z") ok] ~>
      element(attributes: [{"z", "Z"}], content: "ok")

    ~S[div(z="Z" l="p") Hi there!] ~>
      element(attributes: [{"z", "Z"}, {"l", "p"}], content: "Hi there!")
  end
end
