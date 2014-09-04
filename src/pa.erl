%-module(partial).
-module(pa).

-export([nullary/2,
         unary/2,
         binary/2,
         ternary/2,
         nary/3]).

%% Usage examples:
%%
%%   pa:unary(fun mymod:myfun/4, [1,2,3])
%%   pa:binary(fun mymod:myfun/4, [1,2])
%%   pa:nary(4, fun mymod:myfun/7, [1,2,3])
%%

nullary(Fun, Args) -> nary(0, Fun, Args).

unary(Fun, Args) -> nary(1, Fun, Args).

binary(Fun, Args) -> nary(2, Fun, Args).

ternary(Fun, Args) -> nary(3, Fun, Args).

nary(0 = N, Fun, Args) when is_function(Fun, length(Args) + N) ->
    fun() -> erlang:apply(Fun, Args) end;
nary(1 = N, Fun, Args) when is_function(Fun, length(Args) + N) ->
    fun(A1) -> erlang:apply(Fun, Args ++ [A1]) end;
nary(2 = N, Fun, Args) when is_function(Fun, length(Args) + N) ->
    fun(A1, A2) -> erlang:apply(Fun, Args ++ [A1, A2]) end;
nary(3 = N, Fun, Args) when is_function(Fun, length(Args) + N) ->
    fun(A1, A2, A3) -> erlang:apply(Fun, Args ++ [A1, A2, A3]) end.
