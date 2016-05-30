defmodule Jot.FragmentTest do
  use ExUnit.Case, async: true

  alias Jot.Fragment
  alias Jot.HTML.Text
  alias Jot.HTML.Element

  test "consolidate_literals/1" do
    assert Fragment.consolidate_literals([
      %Text{ content: "a" },
      %Text{ content: "b" },
      %Element{},
      %Text{ content: "c" },
      %Text{ content: "d" },
      %Text{ content: "e" },
      %Element{},
      %Element{},
      %Text{ content: "f" },
    ]) == [
      %Text{ content: "ab" },
      %Element{},
      %Text{ content: "cde" },
      %Element{},
      %Element{},
      %Text{ content: "f" },
    ]
  end
end
