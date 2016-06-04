defmodule Jot do
  @moduledoc ~S"""
  Jot is a fast and minimal template engine influenced by Pug and Slim.<br>
  It's also slightly more fun than HTML.

  Here's what it looks like.

      html(lang="en")
        head
          title Jot
        body
          h1#question Why?
          .col
            p Because this is slightly more fun than HTML.

  And here's how you might use it.

      iex> defmodule View do
      ...>   require Jot
      ...>   Jot.function_from_string :def, :sample, "h1 Hello, world!", []
      ...> end
      ...> View.sample()
      "<h1>Hello, world!</h1>"

  For full documentation of the Jot syntax see the project README.

  ## API


  This module provides 3 main APIs for you to use:

    1. Evaluate a string (`eval_string`) or a file (`eval_file`)
       directly. This is the simplest API to use but also the
       slowest, since the code is evaluated and not compiled before.
       This should not be used in production.

    2. Define a function from a string (`function_from_string`)
       or a file (`function_from_file`). This allows you to embed
       the template as a function inside a module which will then
       be compiled. This is the preferred API if you have access
       to the template at compilation time.

    3. Compile a string (`compile_string`) or a file (`compile_file`)
       into Elixir syntax tree. This is the API used by both functions
       above and is available to you if you want to provide your own
       ways of handling the compiled template.

  ## Options

    All functions in this module accept EEx-related options.
    They are:

    TODO
      * `:line` - the line to be used as the template start. Defaults to 1.
    TODO
      * `:file` - the file to be used in the template. Defaults to the given
        file the template is read from or to "nofile" when compiling from a
        string.

  ### Macros

  By default Jot makes use of the `EEx.SmartEngine`, which adds some macros to
  your template. An example is the `@` macro which allows easy data access in a
  template:

      iex> Jot.eval_string("= @foo", assigns: [foo: 1])
      "1"

  In other words, ` @foo` translates to:

      {:ok, v} = Access.fetch(assigns, :foo);
      v

  The `assigns` extension is useful when the number of variables
  required by the template is not specified at compilation time.
  """


  @doc """
  Generates a function definition from the file contents.

  The kind (`:def` or `:defp`) must be given, the
  function name, its arguments and the compilation options.

  This function is useful in case you have templates but
  you want to precompile inside a module for speed.

  ## Examples

      iex> # sample.eex
      ...> # <%= a + b %>
      ...> defmodule SampleA do
      ...>   require Jot
      ...>   Jot.function_from_file :def, :sample, "lib/sample.jot", [:a, :b]
      ...> end
      ...> SampleA.sample(1, 2)
      "3"

  """
  defmacro function_from_file(kind, name, file, args \\ [], options \\ []) do
    quote bind_quoted: binding do
      info = Keyword.merge options, [file: file, line: 1]
      args = Enum.map(args, fn arg -> {arg, [line: 1], nil} end)
      compiled = Jot.compile_file(file, info)
      @external_resource file
      @file file
      case kind do
        :def  -> def(unquote(name)(unquote_splicing(args)), do: unquote(compiled))
        :defp -> defp(unquote(name)(unquote_splicing(args)), do: unquote(compiled))
      end
    end
  end


  @doc """
  Generates a function definition from the string.

  The kind (`:def` or `:defp`) must be given, the
  function name, its arguments and the compilation options.

  ## Examples

      iex> defmodule SampleB do
      ...>   require Jot
      ...>   Jot.function_from_string :def, :sample, "= a + b", [:a, :b]
      ...> end
      iex> SampleB.sample(1, 2)
      "3"

  """
  defmacro function_from_string(
    kind, name, source, args \\ [], options \\ []
  ) do
    quote bind_quoted: binding do
      info = Keyword.merge([file: __ENV__.file, line: __ENV__.line], options)
      args = Enum.map(args, fn(arg) -> {arg, [line: info[:line]], nil} end)
      compiled = Jot.compile_string(source, info)
      case kind do
        :def  ->
          def(unquote(name)(unquote_splicing(args)), do: unquote(compiled))
        :defp ->
          defp(unquote(name)(unquote_splicing(args)), do: unquote(compiled))
      end
    end
  end


  @doc """
  Takes a Jot template string and returns a quoted expression
  that can be evaluated by Elixir, or compiled to a function.

  ## Examples

      iex> expr = Jot.compile_string("= a + b")
      ...> Jot.eval_quoted(expr, [a: 1, b: 2])
      "3"
  """
  def compile_string(template, opts \\ []) when is_binary(template) do
    Jot.Compiler.compile(template, opts)
  end


  @doc """
  Takes a `path` to a Jot template file and generate a quoted
  expression that can be evaluated by Elixir or compiled to a function.
  """
  def compile_file(path, options \\ []) do
    options = Keyword.merge(options, [file: path, line: 1])
    compile_string(File.read!(path), options)
  end


  @doc """
  Takes a Jot template string and evaluate it using the `bindings`.

  This function compiles the template with every call, making it considerably
  slower than functions generated with `function_from_string/5` and
  `function_from_file/5`.

  ## Examples

      iex> Jot.eval_string("= bar", [bar: "baz"])
      "baz"
  """
  def eval_string(template, bindings \\ [], opts \\ []) do
    template
    |> compile_string(opts)
    |> eval_quoted(bindings)
  end


  @doc """
  Takes a Jot quoted expression and call it using the `bindings` given.
  """
  def eval_quoted(expr, bindings \\ []) do
    {html, _} = Code.eval_quoted(expr, bindings)
    html
  end
end
