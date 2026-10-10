:- encoding(utf8).

% El programa trabaja con la siguiente sintaxis para interpretar las respuestas:

% <oracion>    ::= <expresion> | "no" <expresion>
% <expresion>  ::= "me" <verboMe> <complemento> | <verboYo> <complemento>
% <verboMe>    ::= "gusta" | "gustan" | "interesa" | "interesan" | "encanta" | "encantan"
% <verboYo>    ::= "disfruto" | "prefiero" | "amo"
% <complemento>::= [<articulo>] <tema>

% Resultado: preferencia(afinidad, Tema) o preferencia(rechazo, Tema)

interpretar(Linea, Preferencia) :-  % Falla si la frase usa algún elemento fuera de la sintaxis establecida.
    tokenizar(Linea, Palabras),
    phrase(oracion(Preferencia), Palabras).

tokenizar(Texto, Palabras) :-  % Todo se generaliza a un formato sin tildes ni signos.
    string_lower(Texto, Minusculas),
    string_chars(Minusculas, Caracteres),
    limpiarCaracteres(Caracteres, Limpios),
    atom_chars(Atomo, Limpios),
    atomic_list_concat(Partes, ' ', Atomo),
    removerVacios(Partes, Palabras).

limpiarCaracteres([], []).
limpiarCaracteres([C|Resto], [L|RestoLimpio]) :-
    limpiarCaracter(C, L),
    limpiarCaracteres(Resto, RestoLimpio).

limpiarCaracter(C, L) :- cambiar(C, L), !.
limpiarCaracter(C, C) :- 'a' @=< C, C @=< 'z', !.
limpiarCaracter(_, ' ').

cambiar('á', 'a').
cambiar('é', 'e').
cambiar('í', 'i').
cambiar('ó', 'o').
cambiar('ú', 'u').
cambiar('ü', 'u').
cambiar('ñ', 'n').

removerVacios([], []).
removerVacios([''|Resto], Removido) :- !, removerVacios(Resto, Removido).
removerVacios([P|Resto], [P|Removido]) :- removerVacios(Resto, Removido).

oracion(preferencia(afinidad, Tema)) --> expresion(Tema).
oracion(preferencia(rechazo, Tema))  --> [no], expresion(Tema).

expresion(Tema) --> [me], verboMe, complemento(Tema).
expresion(Tema) --> verboYo, complemento(Tema).

verboMe --> [gusta].
verboMe --> [gustan].
verboMe --> [interesa].
verboMe --> [interesan].
verboMe --> [encanta].
verboMe --> [encantan].

verboYo --> [disfruto].
verboYo --> [prefiero].
verboYo --> [amo].

complemento(Tema) --> articuloOPC, tema(Tema).

articuloOPC --> [].
articuloOPC --> articulo.

articulo --> [el].
articulo --> [la].
articulo --> [los].
articulo --> [las].
articulo --> [un].
articulo --> [una].

gente --> [personas].
gente --> [gente].
gente --> [demas].
gente --> [otros].

tema(matematicas) --> [matematicas].
tema(matematicas) --> [numeros].
tema(matematicas) --> [calcular].

tema(tecnologia) --> nombreTecnologia.
tema(tecnologia) --> [trabajar, con], articuloOPC, nombreTecnologia.
tema(tecnologia) --> [programar].

tema(resolverProblemas) --> [resolver], articuloOPC, palabraProblema.

tema(ayudarPersonas) --> [ayudar, a], articuloOPC, gente.

tema(escuchar) --> [escuchar].
tema(escuchar) --> [escuchar, a], articuloOPC, gente.

tema(hablar) --> [hablar].
tema(hablar) --> [conversar].
tema(hablar) --> [hablar, en, publico].
tema(hablar) --> [hablar, con], articuloOPC, gente.

tema(ciencias) --> [ciencias].
tema(ciencias) --> [ciencia].
tema(ciencias) --> [investigar].
tema(ciencias) --> [experimentar].

tema(naturaleza) --> [naturaleza].
tema(naturaleza) --> [animales].
tema(naturaleza) --> [plantas].
tema(naturaleza) --> [cuidar], articuloOPC, [naturaleza].

tema(arte) --> [arte].
tema(arte) --> [dibujar].
tema(arte) --> [pintar].
tema(arte) --> [disenar].
tema(arte) --> [musica].

tema(escribir) --> [escribir].
tema(escribir) --> [leer].
tema(escribir) --> [escritura].

tema(negocios) --> [negocios].
tema(negocios) --> [vender].
tema(negocios) --> [emprender].
tema(negocios) --> [economia].

tema(liderar) --> [liderar].
tema(liderar) --> [dirigir, equipos].
tema(liderar) --> [organizar, equipos].

tema(construir) --> [construir].
tema(construir) --> [construir, cosas].
tema(construir) --> [armar, cosas].
tema(construir) --> [construcciones].

tema(ensenar) --> [ensenar].
tema(ensenar) --> [explicar].
tema(ensenar) --> [ensenar, a], articuloOPC, gente.

tema(salud) --> [salud].
tema(salud) --> [medicina].
tema(salud) --> [cuidar], articuloOPC, [salud].

tema(leyes) --> [leyes].
tema(leyes) --> [derecho].
tema(leyes) --> [justicia].
tema(leyes) --> [defender], articuloOPC, [justicia].

nombreTecnologia --> [tecnologia].
nombreTecnologia --> [computadoras].
nombreTecnologia --> [computacion].

palabraProblema --> [problemas].
palabraProblema --> [acertijos].
palabraProblema --> [retos].
