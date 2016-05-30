defmodule Jot.Record do
  @moduledoc false

  require Record
  import  Record, only: [defrecord: 2, extract_all: 1]

  @records extract_all(from: "src/jot_records.hrl")

  for {name, attrs} <- @records do

    defrecord(name, attrs)

    guard = String.to_atom("is_#{name}")
    defmacro unquote(guard)(r) do
      name = unquote(name)
      size = length(unquote(attrs))
      quote do
        is_tuple(unquote(r))
        and elem(unquote(r), 0) == unquote(name)
        and tuple_size(unquote(r)) == unquote(size) + 1
      end
    end
  end

  defmacro __using__([import: imports]) do
    macros = Enum.flat_map(imports, fn name ->
      [{name, 0}, {name, 1}, {name, 2}, {String.to_atom("is_#{name}"), 1}]
    end)
    quote do
      require unquote(__MODULE__)
      import  unquote(__MODULE__), only: unquote(macros)
    end
  end
end
