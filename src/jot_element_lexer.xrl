Definitions.

Name   = [A-Za-z][A-Za-z0-9_-]*
Dot    = \.
String = "([^\\""]|\\.)*"
Hash   = #
EQ     = =
WS     = [\s\t]+
Word   = [^\(\)\t\s\n\.#=]+
OpenP  = \(
CloseP = \)

Rules.

{String} : {token, {string, strValue(TokenChars)}}.
{Name}   : {token, {name, TokenChars}}.
{Word}   : {token, {word, TokenChars}}.
{Hash}   : {token, {hash, TokenChars}}.
{Dot}    : {token, {dot,  TokenChars}}.
{EQ}     : {token, {eq,   TokenChars}}.
{WS}     : {token, {ws,   TokenChars}}.
{OpenP}  : {token, {'(',  TokenChars}}.
{CloseP} : {token, {')',  TokenChars}}.

Erlang code.

strValue(S) when is_list(S) ->
  Contents  = tl(lists:droplast(S)),
  deescape(Contents).

deescape(S) when is_list(S) ->
  deescape(S, []).

deescape([$\\, C|Tail], Acc) ->
  deescape(Tail, [C|Acc]);
deescape([C|Tail], Acc) ->
  deescape(Tail, [C|Acc]);
deescape([], Acc) ->
  lists:reverse(Acc).
