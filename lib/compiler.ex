defmodule Jot.Compiler do
  @moduledoc false

  def compile(template, _opts) do
    template
    |> Jot.Line.from_template
    |> Enum.map(&Jot.Parser.parse/1)
  end
end
