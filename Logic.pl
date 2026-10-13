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

registrar(pref(afinidad, Tema)) :-
    olvidar(Tema),
    assertz(meGusta(Tema)).
registrar(pref(rechazo, Tema)) :-
    olvidar(Tema),
    assertz(noMeGusta(Tema)).

olvidar(Tema) :-
    retractall(meGusta(Tema)),
    retractall(noMeGusta(Tema)).

confirmar(pref(afinidad, Tema)) :-
    nombreTema(Tema, Nombre),
    format("Entendido, registrare tu afinidad con: ~w.~n", [Nombre]).
confirmar(pref(rechazo, Tema)) :-
    nombreTema(Tema, Nombre),
    format("Entendido, registrare tu aversion a: ~w.~n", [Nombre]).