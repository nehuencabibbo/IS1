Equipo Docente FIUBA/IS1 <mgaribotti@fi.uba.ar>
	
mar, 14 may, 9:16
	
para mí, fedegen14, egomez, fiuba-ingsoft1-doc
Grupo: 14
Nota: 7
Por: Celes, Tom

En general tienen un buen modelo, pero no realizan un buen camino de TDD ya que dan pasos muy grandes.

A continuación les paso a enumerar los puntos fuertes y débiles de la entrega.
Sobre el modelo

    Llegaron a un buen modelo y lograron nombrar correctamente la jerarquía que surgió para representar la cabeza del rover. También nombraron muy bien todos los colaboradores y mensajes.
    Podrían tener un mensaje extra a la hora de procesar los comandos para procesar un único comando de modo que #ejecutaComandos: lo llame y quede algo más limpio y claro.
    Los chequeos de cada comando también podrían haberlos abstraídos en varios mensajes para darle aún más claridad al código.
    No encapsulan verificar la posición y dirección en un único mensaje, sino que los verifican por separado en #estasEn: y #estasMirandoHacia:, esto provoca que si cuando el rover se mueve y también rota, los tests que corresponden a esto pasan igual.

Sobre los tests

    Tienen un camino muy corto de TDD, lo cual los lleva a que les falten casos de test y tengan casos repetidos. Se nota que los pasos de su camino no fueron lo más corto posibles.
    Les faltan tests para los cuatro comandos con los otros 3 puntos cardinales.
    Repiten tests para múltiples comandos, con tener uno luego de probar todas las direcciones con cada comando bastaba.
    No assertan que el rover siga en la misma posición que estaba y que continúe mirando la dirección que originalmente estaba mirando en el caso de que se le pase un comando inválido.

Cualquier duda que tengan con la corrección no duden en responder este mail.

¡Saludos!
