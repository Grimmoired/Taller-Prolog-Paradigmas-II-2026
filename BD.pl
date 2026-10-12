:- encoding(utf8).

profesion('Ingeniería en Computadores',  % Un tema incompatible con una determinada profesion que le guste al usuario hace que se descarte esa profesión de la lista de opciones viables.
          [matematicas, tecnologia, resolverProblemas, construir],  % La primera fila son cualidades compatibles con la carrera
          [naturaleza, arte, ensenar]).  % La segunda son cualidades incompatibles
profesion('Psicología',
          [ayudarPersonas, escuchar, ciencias],
          [tecnologia, negocios, construir]).
profesion('Medicina',
          [salud, ayudarPersonas, ciencias, resolverProblemas],
          [arte, negocios]).
profesion('Derecho',
          [leyes, hablar, escribir, liderar],
          [construir, naturaleza]).
profesion('Administración de Empresas',
          [negocios, liderar, matematicas, hablar],
          [naturaleza, construir]).
profesion('Arquitectura',
          [arte, construir, matematicas, resolverProblemas],
          [negocios, leyes]).
profesion('Diseño Gráfico',
          [arte, tecnologia, escribir],
          [matematicas, leyes, negocios]).
profesion('Educación',
          [ensenar, hablar, ayudarPersonas, escuchar],
          [negocios, construir]).
profesion('Biología',
          [ciencias, naturaleza, resolverProblemas],
          [negocios, arte, hablar]).
profesion('Periodismo',
          [escribir, hablar, escuchar],
          [matematicas, construir]).
profesion('Enfermería',
          [salud, ayudarPersonas, escuchar],
          [tecnologia, leyes]).
profesion('Ingeniería Civil',
          [matematicas, construir, resolverProblemas, liderar],
          [escribir, ensenar]).

pregunta(tecnologia, '¿Te gusta la tecnología?').
pregunta(resolverProblemas, '¿Te gusta resolver problemas?').
pregunta(ayudarPersonas, '¿Te interesa ayudar a las personas?').
pregunta(escuchar, '¿Prefieres escuchar o hablar?').
pregunta(matematicas, '¿Te gustan las matemáticas?').
pregunta(hablar, '¿Disfrutas hablar con otras personas?').
pregunta(ciencias, '¿Te interesan las ciencias?').
pregunta(naturaleza, '¿Te gusta la naturaleza?').
pregunta(arte, '¿Te gusta el arte?').
pregunta(escribir, '¿Disfrutas escribir?').
pregunta(negocios, '¿Te interesan los negocios?').
pregunta(liderar, '¿Te gusta liderar equipos?').
pregunta(construir, '¿Te gusta construir cosas?').
pregunta(ensenar, '¿Te gusta enseñar?').
pregunta(salud, '¿Te interesa la salud?').
pregunta(leyes, '¿Te interesan las leyes y la justicia?').

ordenPreguntas([tecnologia, resolverProblemas, ayudarPersonas, escuchar, matematicas, hablar, ciencias, naturaleza, arte, escribir, negocios, liderar, construir, ensenar, salud, leyes]).

nombreTema(matematicas, 'matemáticas').
nombreTema(tecnologia, 'tecnología').
nombreTema(resolverProblemas, 'resolver problemas').
nombreTema(ayudarPersonas, 'ayudar a las personas').
nombreTema(escuchar, 'escuchar').
nombreTema(hablar, 'hablar').
nombreTema(ciencias, 'ciencias').
nombreTema(naturaleza, 'naturaleza').
nombreTema(arte, 'arte').
nombreTema(escribir, 'escribir').
nombreTema(negocios, 'negocios').
nombreTema(liderar, 'liderar').
nombreTema(construir, 'construir').
nombreTema(ensenar, 'enseñar').
nombreTema(salud, 'salud').
nombreTema(leyes, 'leyes y justicia').

cantidadPreferencias(3).
