**Aporte de los mensajes de DD**

Cada uno de los llamados aporta información sobre la clase del objeto al que se le está enviando el mensaje, hacer esto nos permite abstraernos de la clase a la que pertenece ese objeto. Cuando el polimorfismo simple no es suficiente, y el argumento del llamado también puede variar de tipo, hay que recurrir a esta técnica para a su vez abstraernos del tipo del argumento. Ejemplo:

Primer envío de mensaje:

    unNumero / unDivisor

Aca ganamos información sobre el tipo de unNumero, pero unDivisor puede variar en tipo, a fines de nuestro trabajo, puede ser una fracción o un entero. Dependiendo el tipo de unDivisor vamos a tener que operar de forma distinta, chequeando a que clase pertenece para ejecutar el código correspondiente, para evitar eso, hacemos lo siguiente:

    unDivisor dividiAUn: self

Donde self es unNumero. Aquí implementamos el mensaje polimórfico dividiAUn en cada una de las clases posibles a las que puede pertenecer unDivisor, para así abstraernos de la clase a la que pertenece y evitar los ifs del chequeo de clase, que empeoran la mantenibilidad, extensibilidad y modificacion del codigo.

**Lógica de instanciado**

El mejor lugar donde tener la lógica para instanciar un objeto es la clase a la que pertenece ese objeto, como un mensaje de clase, ya que inicializar una instancia de una determinada clase es una acción propia de las clases. Otra posibilidad acerca de dónde poner el código correspondiente a instanciar un objeto de una clase sería en su superclase, pero sería anti-intuitivo y se le estaría delegando una responsabilidad a la superclase que no le corresponde.

Si se crease el objeto de diferentes formas, se podrían hacer varios mensajes de clase en la clase que corresponda para instanciar el objeto de la forma deseada. El único problema que pudiera llegar a haber es que hubiera codigo repetido por no identificar que más de una de las formas de inicializar distintas instancias de la clase en cuestión fuesen en verdad idénticas, en cuyo caso simplemente se unifican en una; o bien que hubiera codigo repetido entre mensajes de inicialización que no fuesen idénticos, en cuyo caso se crearía la abstracción correspondiente.

**Nombres de las categorías de métodos**

El criterio que usamos para categorizar los métodos es lo que son en base a lo que hacen, pero en un nivel de abstracción mayor, por ejemplo: la suma, la resta, la división y la multiplicación todas se categorizan como operaciones aritméticas, que vendría a ser la idea común detrás de todo ese conjunto de métodos.

La única excepción a esta regla son los métodos privados, categorizamos un método como privado cuando no es algo que se espera que se use desde afuera, sino que fue algo propio nuestro para solucionar algún problema del código respecto a alguna heurística de las vistas en clase.

**Subclass Responsibility**

Eso es para que después, si se quiere agregar otra subclase de una clase ya creada, ya sea por nosotros o por otro programador, sepa los métodos que son necesarios implementar para que todo funcione correctamente y el modelo esté completo, es decir, que el mensaje subclassresponsibility también se pone para que el modelo sea autodescriptivo, y guíe al que quiera ampliarlo o modificarlo. Por ejemplo, a fines de nuestro TP, se podría querer agregar una subclase complejos a la clase numeros, y para ello se van a tener que implementar una serie de métodos básicos que se encuentran en la clase abstracta, en nuestro caso Números, en caso de no hacerlo el mensaje subclass responsability le va a indicar al programador que falta implementar algo.

**No rompas**

Si se rompe el encapsulamiento, va a haber una alta acoplacion del código. El hecho de que todos se conozcan con todos (en un caso extremo) va a implicar que se toque lo que se toque del código, se va a tener que cambiar todo lo que está “unido” al objeto que se cambió, lo cual empeora la mantenibilidad y extensibilidad del código.
