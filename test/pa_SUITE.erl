-module(pa_SUITE).
-compile([export_all]).

-include_lib("common_test/include/ct.hrl").
-include_lib("proper/include/proper.hrl").
-include_lib("eunit/include/eunit.hrl").

-define(eq(Expected, Actual), ?assertEqual(Expected, Actual)).

all() ->
    [].

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

%%
%% Generators
%%

%%
%% Helpers
%%
