Grupo: 14
Nota: 8
Por: Joaco, Ivo

Felicidades! El trabajo está muy bien!

Les dejamos algunos comentarios de cosas que se pueden mejorar:

    Les quedó mucho código repetido para las estrategias. Lo ideal sería que el objeto que las modela (los closures en su caso), esté solo una vez. Piensen en qué pasaría si uno quiere modificar el comportamiento de una de las estrategias: Debería ir buscando uno por uno todos esos bloques repetidos para modificarlos.
    Lo mismo al momento de atacar, tienen checkeos y acciones que se repiten en todos los ataques, esto podrían haberlo unificado, tal como se charló en la solución mostrada en clase.
    Cuidado con como definen los mensajes abstractos. Tienen que hacerlo con subclassResponsibility, no con shouldBeImplemented, esto es importante porque el mensaje de error cuando una subclase concreta no lo implemente será distinto. shouldBeImplemented es para indicar que el método debe ser implementado en esa clase, lo podemos usar provisoriamente mientras estamos desarrollando.
    Ojo que en el mago les quedó un mensaje que no se usa sin borrar #asignarEstrategia, y la implementación que dejaron ahí no tiene mucho sentido.
    Si bien no lo consideramos para la nota de este ejercicio, cuidado con la jerarquía de tests que hicieron. Si bien puede parecer tentador para verlos más organizados, recuerden que son parte del código que entregan y los tests son parte de un modelo en si mismo. Si quieren tenerlos por separado y verlos de forma más organizada, pueden usar una subcategoría (Por ejemplo Ejercicio01-tests) y el mismo entorno se los va a separar en dos secciones diferentes.

Nuevamente, muy buen trabajo.

Saludos
