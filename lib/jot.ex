defmodule Jot do
  @moduledoc ~S"""
  Jot is a fast and minimal template engine influenced by Pug and Slim. It's
  also slightly more fun than HTML.

  Here's an example.

      html(lang="en")
        head
          title Jot
        body
          h1#question Why?
          .col
            p Because this is slightly more fun than HTML.


      iex> Jot.eval_string("h1 Hello, world!")
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


  def compile_string(template, opts \\ []) when is_binary(template) do
    Jot.Compiler.compile(template, opts)
  end

  def eval_string(template, bindings \\ [], opts \\ []) do
    template
    |> compile_string(opts)
    |> Code.eval_quoted(bindings)
    |> elem(0)
  end
end
