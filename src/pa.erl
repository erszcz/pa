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

nullary(Fun, Args) ->
    fun() -> ok end.

unary(Fun, Args) when is_function(Fun, length(Args) + 1) ->
    fun(A) -> erlang:apply(Fun, Args ++ [A]) end.

binary(Fun, Args) ->
    fun() -> ok end.

ternary(Fun, Args) ->
    fun() -> ok end.

nary(N, Fun, Args) ->
    fun() -> ok end.
