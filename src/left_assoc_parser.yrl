Nonterminals
stmt expr.

Terminals
lparen rparen term.

Rootsymbol stmt.

stmt -> stmt expr: {combine, '$1', '$2'}.
stmt -> expr: '$1'.

expr -> term: value_of('$1').
expr -> lparen stmt rparen: {paren, '$2'}.

Erlang code.

value_of(Token) ->
    element(3, Token).
