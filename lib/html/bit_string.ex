defimpl Jot.HTML.Chars, for: BitString do
  def open_fragments(string) do
    [string]
  end

  def close_fragments(_) do
    []
  end
end
