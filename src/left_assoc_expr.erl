-module(left_assoc_expr).

-define(S_EXP, "-s").

%% API exports
-export([main/1]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main(Args) ->
    [Str | Opt] = parse_args(Args),
    {ok, Tokens, _} = left_assoc_lexer:string(Str),
    {ok, Result} = left_assoc_parser:parse(Tokens),
    if hd(Opt) =:= ?S_EXP ->
            io:format("~s~n", [sexpr(Result)]);
       true ->
            io:format("~s~n", [expr(Result)])
    end.

%%====================================================================
%% Internal functions
%%====================================================================

-spec parse_args(list()) -> list().
parse_args(Args) ->
    [A | B] = Args,
    if A =:= ?S_EXP andalso B =/= [] ->
            [hd(B), ?S_EXP];
       hd(B) =:= ?S_EXP ->
            [A, ?S_EXP];
       true ->
            [hd(Args)]
    end.

-spec expr(tuple() | list()) -> list().
expr(X) when is_tuple(X) ->
    case element(1, X) of
        combine ->
            A = expr(element(2, X)),
            B = expr(element(3, X)),
            case lists:member(hd("("), A) andalso lists:member(hd(")"), A) of
                true ->
                    "(" ++ A ++ ")" ++ "(" ++ B ++ ")";
                false ->
                    A ++ "(" ++ B ++ ")"
            end;
        paren ->
            expr(element(2, X))
    end;
expr(X) when is_list(X) ->
    X.

-spec sexpr(tuple() | list()) -> list().
sexpr(X) when is_tuple(X) ->
    case element(1, X) of
        combine ->
            "(" ++ sexpr(element(2, X)) ++ " " ++ sexpr(element(3, X)) ++ ")";
        paren ->
            sexpr(element(2, X))
    end;
sexpr(X) when is_list(X) ->
    X.

