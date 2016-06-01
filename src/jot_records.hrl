-record(
   line,
   {
    indent  = 0,
    pos     = 1,
    content = <<"">>
   }
  ).

-record(
   element,
   {
    type       = <<"div">>,
    id         = nil,
    class      = nil,
    line       = 1,
    attributes = [],
    content    = <<"">>
   }
  ).

-record(
   names,
   {
    type  = <<"div">>,
    id    = nil,
    class = nil
   }
  ).
