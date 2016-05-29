defmodule Jot.LinesTest do
  use ExUnit.Case, async: true
  doctest Jot.Lines
  require Jot.Lines
  import  Jot.Lines, only: [from_template: 1]

  require Record
  import  Record, only: [defrecordp: 2, extract: 2]
  defrecordp :line, extract(:line, from: "src/jot_records.hrl")

  test "empty template" do
    assert from_template("") == []
  end

  test "template of newlines" do
    assert from_template("\n\n\n") == []
  end

  test "one line" do
    assert from_template("Hello world!") == [
      line(indent: 0, pos: 1, content: "Hello world!"),
    ]
  end

  test "one line with indent" do
    assert from_template("    Hello world!") == [
      line(indent: 4, pos: 1, content: "Hello world!"),
    ]
  end

  test "multiple lines with indents" do
    assert """
        What?
    who?
             Slim Shady.
    """ |> from_template == [
      line(indent: 4, pos: 1, content: "What?"),
      line(indent: 0, pos: 2, content: "who?"),
      line(indent: 9, pos: 3, content: "Slim Shady."),
    ]
  end
end
