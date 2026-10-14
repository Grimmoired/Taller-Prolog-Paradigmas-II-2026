% Ejecución:  swipl Logic.pl   y luego   ?- orientador.
:- encoding(utf8).
:- ensure_loaded('BD.pl').
:- ensure_loaded('BNF.pl').

:- dynamic meGusta/1, noMeGusta/1.

orientador :-  % Iniciador de conversacion.
    limpiarPreferencias,
    mostrar('Hola. Estoy aquí para ayudarte a explorar opciones profesionales. ¿Qué te gusta?'),
    leerPreferencia,
    ordenPreguntas(Orden),
    preguntar(Orden),
    recomendar.

mostrar(Texto) :-
    format("OrientadorCE: ~w~n", [Texto]).

limpiarPreferencias :-
    retractall(meGusta(_)),
    retractall(noMeGusta(_)).

leerLinea(Linea) :-
    write('Usuario: '),
    flush_output,
    read_line_to_string(user_input, Lectura),
    (   Lectura == end_of_file
    ->  nl,
        mostrar('Fin de la sesion, fue un placer atenderlo.'),
        halt
    ;   Linea = Lectura
    ).

leerPreferencia :-  % Si la frase no se reconoce, no se registra y se pide de nuevo.
    leerLinea(Linea),
    (   interpretar(Linea, Pref)
    ->  registrar(Pref),
        confirmar(Pref)
    ;   mostrar('No pude entender tu respuesta, ¿Puedes decirlo de otra forma?'),
        leerPreferencia
    ).

registrar(preferencia(afinidad, Tema)) :-
    olvidar(Tema),
    assertz(meGusta(Tema)).
registrar(preferencia(rechazo, Tema)) :-
    olvidar(Tema),
    assertz(noMeGusta(Tema)).

olvidar(Tema) :-
    retractall(meGusta(Tema)),
    retractall(noMeGusta(Tema)).

confirmar(preferencia(afinidad, Tema)) :-
    nombreTema(Tema, Nombre),
    format("Entendido, registrare tu afinidad con: ~w.~n", [Nombre]).
confirmar(preferencia(rechazo, Tema)) :-
    nombreTema(Tema, Nombre),
    format("Entendido, registrare tu aversion a: ~w.~n", [Nombre]).

preguntar(_) :- yaHaySuficientes, !.  % Hace multiples preguntas hasta reunir suficientes preferencias.
preguntar([]) :- !.
preguntar([Tema|Resto]) :-
    yaRespondido(Tema), !,
    preguntar(Resto).
preguntar([Tema|Resto]) :-
    pregunta(Tema, Texto),
    mostrar(Texto),
    leerPreferencia,
    preguntar(Resto).

yaRespondido(Tema) :- meGusta(Tema).
yaRespondido(Tema) :- noMeGusta(Tema).

yaHaySuficientes :-
    findall(T, yaRespondido(T), Lista),
    length(Lista, Cantidad),
    cantidadPreferencias(Minimo),
    Cantidad >= Minimo.

compatible(Profesion, Coincidencias) :-  % Si tiene una afinidad clara a una determinada profesion, y no demuestra intereses incompatibles con dicha profesion, esta se denomina compatible.
    profesion(Profesion, Afinidades, Incompatibles),
    coincidencias(Afinidades, Coincidencias),
    Coincidencias \= [],
    \+ hayIncompatible(Incompatibles),
    \+ hayRechazo(Afinidades).

coincidencias(Afinidades, Lista) :-
    findall(T, (member(T, Afinidades), meGusta(T)), Lista).

hayIncompatible(Incompatibles) :-
    member(T, Incompatibles),
    meGusta(T).

hayRechazo(Afinidades) :-
    member(T, Afinidades),
    noMeGusta(T).

recomendar :-  % Muestra las profesiones compatibles con mas coincidencias.
    findall(N-Prof, (compatible(Prof, Co), length(Co, N)), Candidatas),
    (   Candidatas == []
    ->  mostrar('Lo siento, no encontré una profesión compatible con tus preferencias.')
    ;   mejorPuntaje(Candidatas, Maximo),
        findall(P, member(Maximo-P, Candidatas), Mejores),
        mostrarRecomendacion(Mejores)
    ).

mejorPuntaje(Candidatas, Maximo) :-
    findall(N, member(N-_, Candidatas), Numeros),
    max_list(Numeros, Maximo).

mostrarRecomendacion([Unica]) :- !,
    format("En base a tus preferencias, te recomiendo ~w.~n", [Unica]),
    mostrarCoincidencias(Unica).
mostrarRecomendacion(Varias) :-
    mostrar('En base a tus preferencias, te recomiendo cualquiera de estas opciones:'),
    mostrarLista(Varias).

mostrarLista([]).
mostrarLista([P|Resto]) :-
    format("  - ~w~n", [P]),
    mostrarCoincidencias(P),
    mostrarLista(Resto).

mostrarCoincidencias(Profesion) :-
    compatible(Profesion, Coincidencias),
    format("    (coincide con: ~w)~n", [Coincidencias]).
