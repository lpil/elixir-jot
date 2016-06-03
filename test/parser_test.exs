defmodule ParserTest do
  use ExUnit.Case, async: true

  alias Jot.HTML.Element
  alias Jot.HTML.Text
  alias Jot.HTML.Code

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

  test "template parsing" do
    """
    p Here is
      | some text
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
    l("| some plain value") ~> %Text{ content: " some plain value" }
    l("|No space here")     ~> %Text{ content: "No space here" }
    l("|   Spaces!")        ~> %Text{ content: "   Spaces!" }
  end

  test "comment parsing" do
    l("/ This is a comment") ~> %Text{ content: "" }
    l("// Still a comment")  ~> %Text{ content: "" }
  end

  test "HTML comment parsing" do
    l("/! Hello!") ~> %Text{ content: "<!-- Hello! -->" }
  end

  test "Elixir expression parsing" do
    line(
      content: "= Enum.join([1, 2])", pos: 2, indent: 3
    ) ~> %Code{
      marker:  "=",
      line:    2,
      indent:  3,
      content: "Enum.join([1, 2])",
    }
    l("=1")  ~> %Code{ marker: "=", content: "1" }
    l("= 1") ~> %Code{ marker: "=", content: "1" }
  end

  test "Elixir statement parsing" do
    line(
      content: "- IO.puts :foo", pos: 8, indent: 4
    ) ~> %Code{
      marker:  "",
      line:    8,
      indent:  4,
      content: "IO.puts :foo",
    }
    l("-1")  ~> %Code{ marker: "", content: "1" }
    l("- 1") ~> %Code{ marker: "", content: "1" }
  end
end
