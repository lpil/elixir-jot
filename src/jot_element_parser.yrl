Nonterminals
element names id class classes text any content
attributes attribute attributeList.

Terminals
'(' ')' name word dot hash string eq ws.

Rootsymbol element.

element -> names :
  #element{
    type  = '$1'#names.type,
    class = '$1'#names.class,
    id    = '$1'#names.id
  }.
element -> names attributeList :
  #element{
    type       = '$1'#names.type,
    class      = '$1'#names.class,
    id         = '$1'#names.id,
    attributes = '$2'
  }.
element -> names attributeList content :
  #element{
    type       = '$1'#names.type,
    class      = '$1'#names.class,
    id         = '$1'#names.id,
    attributes = '$2',
    content    = '$3'
  }.
element -> names content :
  #element{
    type    = '$1'#names.type,
    class   = '$1'#names.class,
    id      = '$1'#names.id,
    content = '$2'
  }.

names -> classes
         : #names{ class = '$1' }.
names -> name
         : #names{ type  = binV('$1') }.
names -> id
         : #names{ id    = binV('$1') }.
names -> id classes
         : #names{ id    = binV('$1'), class = '$2' }.
names -> name id classes
         : #names{ type  = binV('$1'), class = '$3', id = binV('$2') }.

classes -> class         : binV('$1').
classes -> class classes : binCat(binV('$1'), <<" ">>, '$2').

class -> dot name : '$2'.
class -> dot word : '$2'.

id -> hash name : '$2'.
id -> hash word : '$2'.

attributeList -> '(' attributes ')' : '$2'.

attributes -> attribute            : ['$1'].
attributes -> attribute attributes : ['$1'|'$2'].

attribute  -> name eq string    : {binV('$1'), binV('$3')}.
attribute  -> ws name eq string : {binV('$2'), binV('$4')}.

content -> ws      : list_to_binary(tl(v('$1'))).
content -> ws text : binCat(list_to_binary(tl(v('$1'))), '$2').

text -> any      : '$1'.
text -> any text : binCat('$1', '$2').

any -> name   : binV('$1').
any -> word   : binV('$1').
any -> dot    : binV('$1').
any -> hash   : binV('$1').
any -> eq     : binV('$1').
any -> ws     : binV('$1').
any -> string : binCat(<<"\"">>, binV('$1'), <<"\"">>).


Erlang code.

-include("jot_records.hrl").

v({_, V}) ->
  V.

binV(V) ->
  list_to_binary(v(V)).

binCat(A, B) ->
  <<A/binary, B/binary>>.

binCat(A, B, C) ->
  <<A/binary, B/binary, C/binary>>.
