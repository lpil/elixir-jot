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

  @tag :skip
  test "type, id, and classes" do

  end

  @tag :skip
  test "text with double quotes" do
    text = 'They said "what?". With quotes. "". Like this -> "'
    "h1 #{text}" ~> nil
  end

  @tag :skip
  test "text with =" do
    text = ' == !=== =:= Huh?'
    "h1 #{text}" ~> nil
  end
end
