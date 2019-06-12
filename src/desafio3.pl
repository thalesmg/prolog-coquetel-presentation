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

resolver(Pessoas) :-
    length(Pessoas, 4),
    maplist(length_(4), Pessoas),
    transpose(Pessoas, Attrs),
    Attrs = [_Criancas, Animais, Lanches, Idades],
    maplist(length_(4), Attrs),

    permutation([6, 7, 8, 9], Idades),
    permutation([bolacha, fruta, salgadinho, sanduiche], Lanches),
    permutation([leao_marinho, peixe_palhaco, tartaruga, tubarao], Animais),

    Pessoas = [Allan, Danilo, Elias, Renan],
    Allan = [allan, _, _, _],
    Danilo = [danilo, _, _, _],
    Elias = [elias, _, _, _],
    Renan = [renan, _, _, _],

    %% dica 1. Nem a criança que quer ver o peixe-palhaço nem a que
    %% quer ver o tubarão levou bolacha.
    member([_, peixe_palhaco, LPeixePalhaco, _], Pessoas),
    member([_, tubarao, LTubarao, _], Pessoas),
    LPeixePalhaco \= bolacha,
    LTubarao \= bolacha,

    %% dica 2. Quem levou sanduíche é 1 ano mais novo que a criança
    %% que quer ver o peixe-palhaço.
    member([_, ASanduiche, sanduiche, ISanduiche], Pessoas),
    member([_, peixe_palhaco, LPeixePalhaco, IPeixePalhaco], Pessoas),
    ASanduiche \= peixe_palhaco,
    LPeixePalhaco \= sanduiche,
    ISanduiche + 1 #= IPeixePalhaco,

    %% dica 3. A criança que levou fruta é 1 ano mais nova do que quem
    %% deseja ver o tubarão.
    member([_, AFruta, fruta, IFruta], Pessoas),
    member([_, tubarao, LTubarao, ITubarao], Pessoas),
    AFruta \= tubarao,
    LTubarao \= fruta,
    ITubarao #= IFruta + 1,

    %% dica 4. Danilo é 2 anos mais velho do que a criança que levou
    %% fruta.
    member([danilo, _, LDanilo, IDanilo], Pessoas),
    member([CFruta, _, fruta, IFruta], Pessoas),
    CFruta \= danilo,
    LDanilo \= fruta,
    IDanilo #= IFruta + 2,

    %% dica 5. Alan não tem 6 anos.
    member([allan, _, _, IAllan], Pessoas),
    IAllan #\= 6,

    %% dica 6. A criança que levou salgadinho quer ver o tubarão.
    member([_, tubarao, salgadinho, _], Pessoas),

    %% dica 7. Quem deseja ver o tubarão é o Renan ou o menino de 9
    %% anos.
    member([CTubarao, tubarao, _, ITubarao], Pessoas),
    ( CTubarao == renan
    ; ITubarao #= 9 ),

    %% dica 8. Quem levou sanduíche tem 8 anos ou quer ver o
    %% leão-marinho.
    member([_, ASanduiche, sanduiche, ISanduiche], Pessoas),
    ( ASanduiche == leao_marinho
    ; ISanduiche #= 8 ).

resolver_formatado(Ps) :-
    resolver(Ps),
    formatar_solução(Ps, ['Criança', 'Animal', 'Lanche', 'Idade']).
