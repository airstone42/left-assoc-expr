left-assoc-expr
=====

An escript for expressing left-associative combinators.

Example
-------

- Input
    1. SKK
    2. KI(SK)(SK)
    3. WI(B(SI)(WI))

- Output
    1. (S(K))(K)
    2. ((K(I))(S(K)))(SK)
    3. (W(I))((B(S(I))(W(I)))

- Output (S-expression)
    1. ((S K) K)
    2. (((K I) (S K))(S K))
    3. ((W I)((B (S I))(W I))

Build
-----

    $ rebar3 escriptize

Run
---

    $ _build/default/bin/left_assoc_expr
