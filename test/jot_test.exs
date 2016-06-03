defmodule JotTest do
  use ExUnit.Case
  doctest Jot

  defmacro template >>> output do
    quote do
      html     = unquote(template) |> Jot.eval_string
      expected =
        unquote(output)
        |> String.replace(~r/^[ ]+/m, "")
        |> String.replace("\n", "")
      assert html == expected
    end
  end

  test "big messy integration template" do
    """
    - x = " world!"
    #greeting(class="big") Hello
      i
        = x
    div
      p This is all very
        = " "
        = :cool
    """ >>> """
    <div id="greeting" class="big">Hello<i> world!</i></div>
    <div>
      <p>This is all very cool</p>
    </div>
    """
  end
end
