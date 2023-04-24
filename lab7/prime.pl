my_append([], List, List).
my_append([H|T1], List2, [H|TResult]) :-
 my_append(T1, List2, TResult).

naive_rev([], []).
naive_rev([H|T], Rev) :- naive_rev(T, RevT),
                         my_append(RevT, [H], Rev).

%число 1 не имеет простых делителей
prime_factors(1,L,L).

% добавить очередной делитель 
prime_factors(N, [factor(M,K)|T],F):- N>1,N mod M =:=0,K1 is K+1,
 							N1 is N div M,
prime_factors(N1, [factor(M,K1)|T],F).
prime_factors(N, [factor(M,0)|T],F):- N>1,N mod M =\=0, M1 is M+1,
prime_factors(N, [factor(M1,0)|T],F).
prime_factors(N, [factor(M,K)|T],F):- N>1,K>0,N mod M =\=0, M1 is M+1,
				prime_factors(N, [factor(M1,0),factor(M,K)|T],F).

prime_factors(1, []).
prime_factors(Num, Factors):-Num>1,prime_factors(Num,[factor(2,0)],F),
   naive_rev(F, Factors).


