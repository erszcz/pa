-module(pa_SUITE).
-compile([export_all]).

-include_lib("common_test/include/ct.hrl").
-include_lib("proper/include/proper.hrl").
-include_lib("eunit/include/eunit.hrl").

-define(eq(Expected, Actual), ?assertEqual(Expected, Actual)).

all() ->
    [nullary,
     unary,
     invalid_unary].

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

nullary(Config) -> nary(Config, nullary, 0).

%% Partial application whose result is a unary function.
unary(Config) -> nary(Config, unary, 1).

nary(_, Property, Arity) ->
    property(Property, ?FORALL({{_, Fun}, Args}, fun_args(Arity),
                               is_function(pa:Property(Fun, Args), Arity))).

%% Error when the input function arity or number of args make it impossible
%% to get a unary function.
invalid_unary(_) ->
    property(invalid_unary, ?FORALL({{_, Fun}, Args}, invalid_fun_args(1),
                                    is_function_clause(catch pa:unary(Fun, Args)))).

%%
%% Generators
%%

-define(MAX_FUN_ARITY, 10).

%% Partially applying Fun to Args should give a fun of arity N.
fun_args(N) when 0 =< N, N =< ?MAX_FUN_ARITY ->
    ?SUCHTHAT({{Arity, _Fun}, Args}, {function(), args()},
              Arity - length(Args) == N).

invalid_fun_args(N) when 0 =< N, N =< ?MAX_FUN_ARITY ->
    ?SUCHTHAT({{Arity, _Fun}, Args}, {function(), args()},
              Arity - length(Args) /= N).

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

is_function_clause({'EXIT', {function_clause, [{pa, nary, _, _} | _]}}) -> true;
is_function_clause(_) -> false.
