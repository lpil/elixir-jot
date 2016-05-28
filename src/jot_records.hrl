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
    type    = <<"div">>,
    id      = <<>>,
    class   = <<>>,
    line    = 1,
    content = ""
   }
  ).

-record(
   names,
   {
    type  = <<"div">>,
    id    = <<>>,
    class = <<>>
   }
  ).
