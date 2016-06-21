defmodule Jot.HTML.Doctype do
  @moduledoc false

  defstruct type:       "html",
            line:       1,
            indent:     0
end

defimpl Jot.HTML.Chars, for: Jot.HTML.Doctype do
  def open_fragments(%{ type: "html" }) do
    ["<!DOCTYPE html>"]
  end

  def close_fragments(%{ type: type }) do
    []
  end
end
