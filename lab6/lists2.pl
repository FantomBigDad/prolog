%проверка, что параметр - список
list([]).
list([H|T]) :- list(T).

%предикат "расплющивающий" вложенный список 
my_flatten([], []). %пустой не меняется
my_flatten([X|Y], Z):-list(X),my_flatten(X,X1),
my_flatten(Y,Y1),append(X1,Y1,Z). 
my_flatten([X|Y], [X|Y1]):-not(list(X)),my_flatten(Y,Y1).

%добавляет N ко всем спискам, заданным 2-м параметром 
add_first(_,[],[]).
add_first(N,[X|R],[[N|X]|R1]):-add_first(N,R,R1).

%код Грея 
gray([_], [[0],[1]]).
gray([_|R], C):-gray(R,A),reverse(A,B),add_first(0,A,A1),
                add_first(1,B,B1),append(A1,B1,C).

%ordered(L) - упорядочены ли числа в списке L по возрастанию (неубыванию).
%пустой упорядочен
ordered([]).
%один элемент упорядочен
ordered([X]):-number(X). 
ordered([X,Y|T]):-number(X),number(Y),X=<Y,ordered([Y|T]). 

%соединение двух списков
my_append([], List, List).
my_append([H|T1], List2, [H|TResult]) :- my_append(T1, List2, TResult).

%sublist(L,X). - X отрезок списка L
sublist([],[]).
sublist([_|T],L):-sublist(T,L).
sublist([H|T],[H|L]):-my_append(L,_,T).