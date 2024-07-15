Grupo: 14
Nota: 9
Por: Borja, Naza

Felicitaciones! El ejercicio excelente.

Lograron sacar los if implementando double dispatch, evitan romper encapsulamiento y quitan código repetido.

Les dejamos algunas consideraciones que vimos a lo largo del ejercicio.
Double Dispatch

    Excelente, logran sacar todos los IFs respetando el uso de buenos nombres para el DD y categorizando adecuadamente los mensajes. Tengan en cuenta que les faltó definir como abstractos los mensajes en Número. Recuerden que esto es clave porque es una forma de comunicación, de establecer como se debe comportar un número. Esto ayuda a cualquier que tenga que extender el sistema o crear una nueva subclase porque le indica qué mensajes tiene que implementar, y en caso de no hacerlo, lanza una excepción clara de la causa del error.

Fibonacci y Switch Dinámico

    Logran quitar los IFs de Fibonacci utilizando correctamente la técnica de Switch Dinámico y utilizando abstracciones para mejorar la declaratividad del código aunque les queda un poco de código repetido con el manejo de colecciones.
    Por otro lado, no lanzan ninguna excepción si no entra en ninguna subclase.
    No logran sumar unos puntos por el extra quitando los IFs del #with:over:

Preguntas y respuestas

Las respuestas de las preguntas son todas correctas excepto la primera, que no resulta claro que entiendan bien.

Lo que es importante saber acá es que el primero dice qué se hace y el segundo dice qué se hace pero en el contexto de una clase/objeto particular. El segundo mensaje aporta información más específica sobre cómo se tiene que resolver ese qué (lo pueden ver como un cómo).

Cualquier duda que tengan, no duden en consultarnos!

Saludos
