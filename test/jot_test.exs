defmodule JotTest do
  use ExUnit.Case
  doctest Jot

  defmacro template >>> output do
    quote do
      html     = unquote(template) |> Jot.eval_string
      expected = unquote(output) |> String.replace("\n", "")
      assert html == expected
    end
  end

  test "eval_string/3" do
    """
    - x = " world!"
    #greeting(class="big") Hello
      i
        = x
    """ >>> """
    <div id="greeting" class="big">Hello<i> world!</i></div>
    """
  end
end
