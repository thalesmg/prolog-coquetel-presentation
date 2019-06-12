writeN(_, 0).
writeN(Char, N) :-
    N > 0,
    write(Char),
    N_ is N - 1,
    writeN(Char, N_).

formatar_pessoa([A, B, C, D]) :-
    format('| ~s~t~24+| ~s~t~24+| ~s~t~24+| ~d~t~24+|~n',
           [A, B, C, D]).

formatar_solução(Pessoas, Cabeçalhos) :-
    nl, writeN("=", 97), nl,
    format('| ~s~t~24+| ~s~t~24+| ~s~t~24+| ~s~t~24+|~n', Cabeçalhos),
    writeN("=", 97), nl,

    maplist(formatar_pessoa, Pessoas),

    writeN("=", 97), nl, nl.
