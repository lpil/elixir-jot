defmodule Jot.HTML.Doctype do
  @moduledoc false

  defstruct type:       "html",
            line:       1,
            indent:     0
end

defimpl Jot.HTML.Chars, for: Jot.HTML.Doctype do
  def open_fragments(%{ type: type }) do
    [from_type(type)]
  end

  def close_fragments(%{}) do
    []
  end


  defp from_type("html"),
    do: "<!DOCTYPE html>"

  defp from_type("xml"),
    do: ~S(<?xml version="1.0" encoding="utf-8" ?>)

  defp from_type("transitional"),
    do: ~S(<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">)

  defp from_type("strict"),
    do: ~S(<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">)

  defp from_type("frameset"),
    do: ~S(<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">)

  defp from_type("1.1"),
    do: ~S(<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">)

  defp from_type("basic"),
    do: ~S(<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML Basic 1.1//EN" "http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd">)

  defp from_type("mobile"),
    do: ~S(<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">)

  defp from_type(type),
    do: ~s(<!DOCTYPE #{type}>)
end
