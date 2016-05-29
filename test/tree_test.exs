defmodule Jot.TreeTest do
  use ExUnit.Case, async: true

  doctest Jot.Tree

  require Record
  import  Record, only: [defrecordp: 2, extract: 2]
  defrecordp :line, extract(:line, from: "src/jot_records.hrl")
  defrecordp :tree, extract(:tree, from: "src/jot_records.hrl")

  defmacro lines ~> tree do
    quote do
      assert unquote(tree) == Jot.Tree.from_lines(unquote(lines))
    end
  end

  test "empty tree" do
    [] ~> []
  end

  test "flat tree" do
    [
      line(indent: 0, content: "a"),
      line(indent: 0, content: "b"),
      line(indent: 0, content: "c"),
    ] ~> [
      tree(value: line(indent: 0, content: "a")),
      tree(value: line(indent: 0, content: "b")),
      tree(value: line(indent: 0, content: "c")),
    ]
  end

  test "nesting" do
    [
      line(indent: 0, content: "a"),
      line(indent: 1, content: "b"),
    ] ~> [
      tree(
        value: line(indent: 0, content: "a"),
        children: [
          tree(value: line(indent: 1, content: "b")),
        ]
      ),
    ]
  end

  test "deep nesting" do
    [
      line(indent: 0, content: "a"),
      line(indent: 1, content: "b"),
      line(indent: 4, content: "c"),
    ] ~> [
      tree(
        value: line(indent: 0, content: "a"),
        children: [
          tree(
            value: line(indent: 1, content: "b"),
            children: [
              tree(value: line(indent: 4, content: "c")),
            ]
         ),
        ]
      ),
    ]
  end

  test "nesting then not" do
    [
      line(indent: 0, content: "a"),
      line(indent: 1, content: "b"),
      line(indent: 1, content: "c"),
      line(indent: 0, content: "d"),
    ] ~> [
      tree(
        value: line(indent: 0, content: "a"),
        children: [
          tree(value: line(indent: 1, content: "b")),
          tree(value: line(indent: 1, content: "c")),
        ]
      ),
      tree(value: line(indent: 0, content: "d")),
    ]
  end
end
