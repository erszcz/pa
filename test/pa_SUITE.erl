-module(pa_SUITE).
-compile([export_all]).

-include_lib("common_test/include/ct.hrl").
-include_lib("proper/include/proper.hrl").
-include_lib("eunit/include/eunit.hrl").

-define(eq(Expected, Actual), ?assertEqual(Expected, Actual)).

all() ->
    [unary].

init_per_suite(Config) ->
    Config.

end_per_suite(_Config) ->
    ok.

init_per_testcase(_TestCase, Config) ->
    Config.

end_per_testcase(_TestCase, _Config) ->
    ok.

%%
%% Tests
%%

unary(_) ->
    property(unary, ?FORALL({{_,Fun}, Args}, fun_args(1),
                            is_function(pa:unary(Fun, Args), 1))).

%%
%% Generators
%%

-define(MAX_FUN_ARITY, 10).

%% Partially applying Fun to Args should give a fun of arity N.
fun_args(N) when 0 =< N, N =< ?MAX_FUN_ARITY ->
    ?SUCHTHAT({{Arity, _Fun}, Args}, {function(), args()},
              Arity - length(Args) == N).

function() ->
    ?LET(Arity, fun_arity(), function(Arity)).

fun_arity() -> integer(0, ?MAX_FUN_ARITY).

function(0) -> {0, fun () -> 0 end};
function(1) -> {1, fun (_) -> 1 end};
function(2) -> {2, fun (_,_) -> 2 end};
function(3) -> {3, fun (_,_,_) -> 3 end};
function(4) -> {4, fun (_,_,_,_) -> 4 end};
function(5) -> {5, fun (_,_,_,_,_) -> 5 end};
function(6) -> {6, fun (_,_,_,_,_,_) -> 6 end};
function(7) -> {7, fun (_,_,_,_,_,_,_) -> 7 end};
function(8) -> {8, fun (_,_,_,_,_,_,_,_) -> 8 end};
function(9) -> {9, fun (_,_,_,_,_,_,_,_,_) -> 9 end};
function(10) -> {10, fun (_,_,_,_,_,_,_,_,_,_) -> 10 end}.

args() ->
    ?LET(Arity, fun_arity(), lists:seq(1, Arity)).

%%
%% Helpers
%%

property(Name, Prop) ->
    Props = proper:conjunction([{Name, Prop}]),
    ?assert(proper:quickcheck(Props, [verbose, long_result,
                                      {numtests, 100},
                                      {constraint_tries, 200}])).
