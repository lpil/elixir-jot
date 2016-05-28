defmodule Jot.Lexer.ElementTest do
  use ExUnit.Case, async: true

  alias Jot.Lexer.Element
  doctest Element

  defmacro template ~> tokens do
    quote do
      assert unquote(tokens) == Element.tokenize!(unquote(template))
    end
  end

  test "tags" do
    "h1" ~> [
      name: 'h1',
    ]
  end

  test "ids" do
    "#foo" ~> [
      hash: '#',
      name: 'foo',
    ]
    "#xx#yy" ~> [
      hash: '#',
      name: 'xx',
      hash: '#',
      name: 'yy',
    ]
    "#who-what_slimSHADY" ~> [
      hash: '#',
      name: 'who-what_slimSHADY',
    ]
  end

  test "class literal" do
    ".bar" ~> [
      dot: '.',
      name: 'bar',
    ]
    ".x.y" ~> [
      dot:  '.',
      name: 'x',
      dot:  '.',
      name: 'y',
    ]
    ".WHAT-where__when" ~> [
      dot:  '.',
      name: 'WHAT-where__when',
    ]
  end

  test "tags with text content" do
    "div Hello, world!" ~> [
      name: 'div',
      ws:   ' ',
      word: 'Hello,',
      ws:   ' ',
      word: 'world!',
    ]
    "div I'm spartacus" ~> [
      name: 'div',
      ws:   ' ',
      word: 'I\'m',
      ws:   ' ',
      name: 'spartacus',
    ]
  end

  test "whitespace" do
    "div   \t Hi\t \t" ~> [
      name: 'div',
      ws:   '   \t ',
      name: 'Hi',
      ws:   '\t \t',
    ]
  end

  test "attrs" do
    ~s[a(href="foo")] ~> [
      name:   'a',
      "(":    '(',
      name:   'href',
      eq:     '=',
      string: 'foo',
      ")":    ')',
    ]
    ~s[a(class="button" href="/beep") Clicky] ~> [
      name:   'a',
      "(":    '(',
      name:   'class',
      eq:     '=',
      string: 'button',
      ws:     ' ',
      name:   'href',
      eq:     '=',
      string: '/beep',
      ")":    ')',
      ws:     ' ',
      name:   'Clicky'
    ]
  end
end
