%число Фибоначчи
fib(1,1).
fib(2,1).
fib(N,F):-N>2,N1 is N-1, N2 is N-2,fib(N1,F1),fib(N2,F2),F is F1+F2.


%сумма и длина
sum_len([], 0,0).
sum_len([H|T], S,L):-sum_len(T, S1,L1), L is L1+1, S is S1+H.
%среднее арифметическое
mean(List,Mean):-sum_len(List,S,L),Mean is S / L.



%ДНФ
%переменная или отрицание
dnfvar(X):-atom(X),not(number(X)).
dnfvar(\+X):-atom(X),not(number(X)).
%конъюнкция
dnfand(X/\Y):-dnfand(X),dnfvar(Y).
dnfand(X):-dnfvar(X).
%дизъюнкция
dnfor(X\/Y):-dnfor(X),dnfand(Y).
dnfor(X):-dnfand(X).
dnf(X):-dnfor(X).


my_member([H|_], H).
my_member([_|T], X) :- my_member(T, X).

%логическая формула
eval_logic(X, V):- atom(X),my_member(V,true(X)).
eval_logic(\+X, V):- not(eval_logic(X,V)).
eval_logic(X \/ _, V):- eval_logic(X,V).
eval_logic(X \/ Y, V):- not(eval_logic(X,V)),eval_logic(Y,V).
eval_logic(X /\ Y, V):- eval_logic(X,V),eval_logic(Y,V).
eval_logic(X -> _, V):- not(eval_logic(X,V)).
eval_logic(X -> Y, V):-eval_logic(X,V), eval_logic(Y,V).