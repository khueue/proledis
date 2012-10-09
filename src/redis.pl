/** <module> Redis driver.
 *
 *  Redis driver for Prolog.
 *
 *  @see <http://redis.io/>
 */

:- module(_,
    [
        version/1
        % And see reexports below.
    ]).

:- reexport(
    [
    ]).

:- include(include/common).

% Internal modules.
% :- use_module(redis_some_internal_only_stuff, []).

%%  version(?Version) is semidet.
%
%   True if Version is a list representing the major, minor
%   and patch version numbers of this library.

version([0,0,0]).
