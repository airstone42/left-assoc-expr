Definitions.

TERM = [A-Z][0-9a-z_]*
WS  = [\s\t]
LB  = \n|\r\n|\r

Rules.
{TERM}   : {token, {term, TokenLine, TokenChars}}.
\[      : {token, {lparen, TokenLine}}.
\]      : {token, {rparen, TokenLine}}.
\(      : {token, {lparen, TokenLine}}.
\)      : {token, {rparen, TokenLine}}.
{WS}    : skip_token.
{LB}    : skip_token.

Erlang code.
