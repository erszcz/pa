%-module(partial).
-module(pa).

-export([nullary/2,
         unary/2,
         binary/2,
         ternary/2,
         nary/3]).

%% Usage examples:
%%
%%   partial:unary(fun mymod:myfun/4, [1,2,3])
%%   partial:binary(fun mymod:myfun/4, [1,2])
%%   partial:nary(4, fun mymod:myfun/7, [1,2,3])
%%
%%   pa:unary(fun mymod:myfun/4, [1,2,3])
%%   pa:binary(fun mymod:myfun/4, [1,2])
%%   pa:nary(4, fun mymod:myfun/7, [1,2,3])
%%
