:- include(include/common).

:- begin_tests('redis tests').

test('test 1', [true(Got == Expected)]) :-
    Expected = 1,
    lists:member(Got, [1,2,3]),
    !.

:- end_tests('redis tests').
