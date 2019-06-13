%% -*- mode: prolog; -*-
:- use_module(library(clpfd)).
:- consult(comum).

length_(L, Ls) :- length(Ls, L).

alldif([]).
alldif([X|Xs]) :-
    maplist(dif(X), Xs),
    alldif(Xs).

is_permutation(Xs, Ys) :-
    msort(Xs, Sorted),
    msort(Ys, Sorted).

resolver(Ps) :-
    length(Ps, 5),
    maplist(length_(4), Ps),
    transpose(Ps, Attrs),
    Attrs = [_Ns, Fs, Os, Ds],
    maplist(length_(5), Attrs),

    permutation([1, 2, 3, 4, 5], Ds),
    permutation([touro, casablanca, semprejovem, starwars, bandidos], Fs),
    permutation([favorito, amigo, quebrado, filho, esposa], Os),

    Ps = [C, E, I, N, R],
    C = [caio, _, _, _],
    E = [eduardo, _, _, _],
    I = [ivan, _, _, _],
    N = [nicole, _, _, _],
    R = [renata, _, _, _],

    %% dica 1. Renata alugou o DVD Sempre Jovem.
    member([renata, semprejovem, _, _], Ps),
    %% dica 2. Caio alugou 1 DVD a mais do que Nicole, que por sua vez
    %% alugou 1 DVD a mais do que a pessoa que alugou um DVD por ter
    %% seu DVD quebrado.
    member([caio, _, _, DCaio], Ps),
    member([nicole, _, _, DNicole], Ps),
    member([NQ, _, quebrado, DQuebrado], Ps),
    DCaio #> DNicole, DNicole #> DQuebrado,
    NQ \= caio, NQ \= nicole,
    %% dica 3. Eduardo alugou mais filmes do que a pessoa que alugou
    %% um DVD para assistir com sua esposa.
    member([eduardo, _, _, DEduardo], Ps),
    member([NE, _, esposa, DEsposa], Ps),
    NE \= eduardo,
    DEduardo #> DEsposa,
    %% dica 4. Renata alugou 1 filme a mais do que a pessoa que vai
    %% assistir um filme (que não é Bandidos) com o amigo.
    member([renata, _, _, DRenata], Ps),
    member([NA, FA, amigo, DAmigo], Ps),
    DAmigo + 1 #= DRenata,
    NA \= renata,
    FA \= bandidos,
    %% dica 5. Quem teve seu DVD quebrado alugou 1 DVD a mais do que a
    %% pessoa que alugou Casablanca (que não alugou para levar para o
    %% filho), e também alugou mais filmes do que as pessoas que
    %% alugaram Bandidos e Touro Sentado.
    member([_, casablanca, OC, DCasablanca], Ps), OC \= filho,
    member([_, bandidos, _, DBandidos], Ps),
    member([_, touro, _, DTouro], Ps),
    DQuebrado + 1 #= DCasablanca,
    DQuebrado #> DBandidos,
    DQuebrado #> DTouro.

resolver_formatado(Ps) :-
    resolver(Ps),
    formatar_solução(Ps, ['Amigo', 'Filme', 'Objetivo', 'N DVDs']).
