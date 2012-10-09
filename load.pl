%   proledis_configure_globals is det.
%
%   Configures useful globals used throughout the session.

proledis_configure_globals :-
    % For optimized compiles, tests are by default ignored.
    set_test_options([load(always)]).

%   proledis_configure_load_paths is det.
%
%   Configures internal load paths in preparation of use_module calls.

proledis_configure_load_paths :-
    prolog_load_context(directory, Root), % Available only during compilation.
    proledis_configure_path(Root, 'src', redis).

proledis_configure_path(PathPrefix, PathSuffix, Name) :-
    atomic_list_concat([PathPrefix,PathSuffix], '/', Path),
    asserta(user:file_search_path(Name, Path)).

% Set everything up.
:- proledis_configure_globals.
:- proledis_configure_load_paths.

% Simply loading this module claims to speed up phrase, maplist, etc.,
% but I haven't noticed much difference.
% :- use_module(library(apply_macros)).

:- include(redis(include/common)).

proledis_load_project_modules :-
    use_module(library(pldoc), []), % Load first to enable comment processing.
    use_module(redis(redis), []).

proledis_load_project_tests :-
    plunit:load_test_files([]).

%%  proledis_test is det.
%
%   Loads everything and runs the test suite.

proledis_test :-
    proledis_load_project_modules,
    proledis_load_project_tests,
    proledis_run_test_suite.

proledis_run_test_suite :-
    core:format('~n% Run tests ...~n'),
    call_cleanup(
        plunit:run_tests,
        true). % Do cleanup here.

%%  proledis_cov is det.
%
%   Loads everything and runs the test suite with coverage analysis.

proledis_cov :-
    proledis_load_project_modules,
    proledis_load_project_tests,
    proledis_run_test_suite_with_coverage.

proledis_run_test_suite_with_coverage :-
    core:format('~n% Run tests ...~n'),
    call_cleanup(
        plunit:show_coverage(plunit:run_tests),
        true). % Do cleanup here.

%%  proledis_repl is det.
%
%   Loads everything and enters interactive mode.

proledis_repl :-
    proledis_load_project_modules,
    proledis_load_project_tests.
