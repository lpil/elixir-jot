Nonterminals
element names id class classes.


Terminals
name word dot hash.
% string eq ws.


Rootsymbol element.

element -> names :
  #element{
    type  = '$1'#names.type,
    class = '$1'#names.class,
    id    = '$1'#names.id
  }.

names -> name       : #names{type  = binV('$1')}.
names -> id         : #names{id    = binV('$1')}.
names -> id classes : #names{id    = binV('$1'), class = '$2'}.
names -> classes    : #names{class = '$1'}.

classes -> class         : binV('$1').
classes -> class classes : binJoin(binV('$1'), '$2').

class -> dot name : '$2'.
class -> dot word : '$2'.

id -> hash name : '$2'.
id -> hash word : '$2'.


Erlang code.

-include("jot_records.hrl").

v({_, V}) ->
  V.

binV(V) ->
  list_to_binary(v(V)).

binJoin(A, B) ->
  <<A/binary, <<" ">>/binary, B/binary>>.
