defmodule ParserTest do
  use ExUnit.Case, async: true

  require Record
  import  Record, only: [defrecordp: 2, extract: 2]
  defrecordp :line,    extract(:line,    from: "src/jot_records.hrl")
  defrecordp :element, extract(:element, from: "src/jot_records.hrl")

  defmacro template ~> value do
    quote do
      assert unquote(value) == Jot.Parser.parse!(unquote(template))
    end
  end

  def l(content) do
    line(content: content)
  end


  test "element parsing" do
    line(content: "h1 Hi") ~> element(type: "h1", content: "Hi")
  end

  test "plain parsing" do
    l("| some plain value") ~> [plain: "some plain value"]
    l("|No space here")     ~> [plain: "No space here"]
    l("|   Spaces!")        ~> [plain: "  Spaces!"]
  end

  test "comment parsing" do
    l("/ This is a comment") ~> nil
    l("// Still a comment")  ~> nil
  end
end
