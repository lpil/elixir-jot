defmodule Jot.FragmentTest do
  use ExUnit.Case, async: true

  alias Jot.Fragment

  test "consolidate_literals/1" do
    assert Fragment.consolidate_literals([
      "a", "b",
      {},
      "c", "d", "e",
      [],
      %{},
      "f",
    ]) == [
      "ab",
      {},
      "cde",
      [],
      %{},
      "f",
    ]
  end
end
