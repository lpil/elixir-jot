defmodule ParserTest do
  use ExUnit.Case, async: true

  require Record
  import  Record, only: [defrecordp: 2, extract: 2]
  defrecordp :line,    extract(:line,    from: "src/jot_records.hrl")
  defrecordp :element, extract(:element, from: "src/jot_records.hrl")

  defmacro template >>> value when is_binary(template) do
    quote do
      assert unquote(value) == Jot.Parser.parse_template!(unquote(template))
    end
  end

  defmacro line ~> value do
    quote do
      assert unquote(value) == Jot.Parser.parse_line!(unquote(line))
    end
  end

  def l(content) do
    line(content: content)
  end

  @tag :skip
  test "template parsing" do
    """
    p
      | Here is some text
    """ >>> [
      "<p>Here is some text</p>"
    ]
  end


  test "element parsing" do
    line(content: "h1 Hi") ~> element(type: "h1", content: "Hi")
  end

  test "plain parsing" do
    l("| some plain value") ~> "some plain value"
    l("|No space here")     ~> "No space here"
    l("|   Spaces!")        ~> "  Spaces!"
  end

  test "comment parsing" do
    l("/ This is a comment") ~> nil
    l("// Still a comment")  ~> nil
  end

  test "HTML comment parsing" do
    l("/! Hello!") ~> "<!-- Hello! -->"
  end
end
