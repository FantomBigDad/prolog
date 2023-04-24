%длина списка
len([],0).
len([_|T],N) :- len(T,N1), N is N1+1.

my_append([], List, List).
my_append([H|T1], List2, [H|TResult]) :-
 my_append(T1, List2, TResult).

naive_rev([], []).
naive_rev([H|T], Rev) :- naive_rev(T, RevT),
                         my_append(RevT, [H], Rev).
%суммирование списков
sum_list([],L2,L2).
sum_list([H|T],[],[H|T]).
sum_list([H1|T1],[H2|T2],[H|T]):-H is H1+H2,sum_list(T1,T2,T).

%коэффициент при степени N
get_coef([],_,0).  
get_coef([A|_],0,A).
get_coef([_|T],N,A) :-N>0, N1 is N-1, get_coef(T,N1,A).
 
%ппоизведение кэффициентов
pcoef(P1,P2,I,J,C) :- get_coef(P1,I,A), get_coef(P2,J,B), C is A*B.
 
%новые коэффициенты 
newcoef(_,_,N,I,0)  :- I>N.
newcoef(P1,P2,N,I,S)  :- I=<N, J is N-I, pcoef(P1,P2,I,J,C), I1 is I+1, 
newcoef(P1,P2,N,I1,S1), S is S1+C.

 %произведение полиномов, заданных списками
poly_mult(P1,P2,I,[])    :- len(P1,N1), len(P2,N2), N is N1+N2-2, I>N.
poly_mult(P1,P2,I,[Q|T]) :- len(P1,N1), len(P2,N2), N is N1+N2-1,I<N,newcoef(P1,P2,I,0,Q), I1 is I+1, poly_mult(P1,P2,I1,T). 
polymult(P1,P2,R) :- poly_mult(P1,P2,0,R).

%выражение в список коэффициентов
poly2list(X, [0,1]):-atom(X).%переменная
poly2list(X, [X]):-number(X).%число
poly2list(X+Y, L):-poly2list(X,L1),poly2list(Y,L2),sum_list(L1,L2,L).
poly2list(X*Y, L):-poly2list(X,L1),poly2list(Y,L2),polymult(L1,L2,L).
poly2list(X^1, L):-poly2list(X,L).
poly2list(X^N, L):-N mod 2 =:= 0, N1 is N div 2, 
poly2list((X*X)^N1, L).
poly2list(X^N, L):-N>1,N mod 2 =\= 0, N1 is N - 1, 
poly2list(X*X^N1, L).

%список коэффициентов в выражение
list2polinom([H],0,H).
list2polinom([0,H|T],I,X):-I1 is I-1,list2polinom([H|T],I1,X).
list2polinom([1|T],1,x+X):-list2polinom(T,0,X),X\=0.
list2polinom([1|T],I,x^I+X):-I>1,I1 is I-1,list2polinom(T,I1,X),X\=0.
list2polinom([H|T],1,H*x+X):-H>0,H=\=1,list2polinom(T,0,X),X\=0.
list2polinom([H|T],I,H*x^I+X):-H>0,H=\=1,I>1, 
I1 is I-1,list2polinom(T,I1,X),X\=0.

%если ноль
list2polinom([1|T],1,x):-list2polinom(T,0,0).
list2polinom([1|T],I,x^I):-I>1,I1 is I-1,list2polinom(T,I1,0).
list2polinom([H|T],1,H*x):-H>0,H=\=1,list2polinom(T,0,0).
list2polinom([H|T],I,H*x^I):-H>0,H=\=1,I>1,
I1 is I-1,list2polinom(T,I1,0).

%полином в нормальный вид
polynomize(N,N):-number(N).
polynomize(X,Poly):-not(number(X)),poly2list(X,L),naive_rev(L,R), len(R,K), K1 is K-1,list2polinom(R,K1,Poly).

