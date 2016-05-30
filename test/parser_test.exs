defmodule ParserTest do
  use ExUnit.Case, async: true

  alias Jot.HTML.Element

  use Jot.Record, import: [:element, :line]

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
    line(
      content: ~s[h1(style="") Hi], pos: 5, indent: 3
    ) ~> %Element{
      type:    "h1",
      line:    5,
      indent:  3,
      content: "Hi",
      attributes: [{"style", ""}],
    }
  end

  test "plain parsing" do
    l("| some plain value") ~> "some plain value"
    l("|No space here")     ~> "No space here"
    l("|   Spaces!")        ~> "  Spaces!"
  end

  test "comment parsing" do
    l("/ This is a comment") ~> ""
    l("// Still a comment")  ~> ""
  end

  test "HTML comment parsing" do
    l("/! Hello!") ~> "<!-- Hello! -->"
  end
end
