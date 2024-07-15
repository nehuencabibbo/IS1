Grupo: 14
Nota: 8.5
Por: Ana, Pedro

Felicitaciones, ¡el ejercicio está aprobado!

Lograron un buen modelo. Tienen portfolios que se crean de manera válida, cumpliendo con las restricciones del enunciado. Además, los reportes son totalmente extensibles, cumpliendo con los requisitos del enunciado: poder agregar futuros reportes sin tener que modificar la jerarquía de transacciones, simplemente creando clases nuevas por cada reporte.

Sin embargo, hay varias cosas que se podrían mejorar o que faltaron, de las cuales nos vamos a explayar mejor a continuación:
Transferencias

    Las partes de la transferencia son transacciones, y responden a un comportamiento similar al del depósito y la extracción, por lo cual se podría mover esta jerarquía de partes de la transferencia dentro de las transacciones, resultando en la superclase AccountTransaction, con subclases Deposit, Withdraw y la jerarquía TransferenciaPartes.

    No están bien distribuidas las responsabilidades en el mensaje balance. No es responsabilidad de una ReceptiveAccount saber cómo afectan las transacciones al balance, sino que cada transacción tendría que poder afectar al balance como quiera.

    Una forma de hacer esto es mediante un double dispatch, donde la transacción reciba el balance mediante un mensaje como affectBalance: currentBalance, y dentro de este, cada transacción afecte al balance como deba.

    Respecto a esto, la responsabilidad de saber cómo cada parte de la transferencia afecta al balance deberían tenerla las TransferenciaPartes y no la Transferencia.

    Es decir, al afectar el valor del balance, cada parte debería, a partir del value de la transferencia, saber si sumar o restar este valor al balance total.

    Las partes de la transferencia tienen el mensaje valueForBalance sin self subclassResponsibility. De hecho, este mensaje y el de inicialización tienen la misma implementación en ambas clases, por lo que podrían estar implementadas directamente en la superclase para sacar código repetido. Y podrían mover el colaborador interno cuenta a la superclase.

    La forma de creación de una transferencia capaz no es tan clara. Para empezar, se llama al mensaje Transferencia register: valor desde: cuentaOrigen hacia: cuentaDestino , y dentro se llama al mensaje de clase Transferencia porValor: unValor desde: unaCuenta hacia: otraCuenta, cuyo nombre no deja tan en claro qué hace. Dentro de este se hacen dos checkeos, se crea la instancia y se le envía el mensaje de inicialización.

    Capaz algo más ordenado sería no tener ese segundo mensaje de clase, sino que tener directamente una abstracción para hacer los checkeos, algo como asertarQue: unaCantidadDeDinero puedeSerTransferidaHacia: cuentaDestino desde: cuentaOrigen.

    Todos los mensajes de la transferencia y sus partes están sin categorizar.

    Respecto de los tests, ningún test está nombrado por lo que es dificil saber qué se está testeando.

Portfolios

    Podrían haber creado una jerarquía de cuentas, con una superclase Account y como subclases la ReceptiveAccount y el Portfolio. Esto les permitiría organizar conocimiento, ya que ambos son tipos de cuentas, los cuales saben responder a los mismos mensajes: balance, transactions, hasRegistered:.
    Los portfolios no pueden tener múltiples parents. Los padres deberían ser una OrderedCollection o algo similar, de forma que se puedan tener varios. Claro, esto debe ir acompañado de un test.
    En los tests de portfolios válidos, solo testean el mensaje de error. Deberían testear, además, que el estado del portfolio no haya cambiado (es decir, que no se hayan añadido las cuentas).
    Para saber si una cuenta tiene transacciones, podrían haber usado el mensaje anySatisfy: en vez de detect:ifFound:ifNone:.
    Siguiendo con lo anterior, no es necesario que se tengan los mensajes tieneTransaccion: y hasRegistered:. Se podía resolver todo en un solo mensaje, ya que tieneTransaccion: solamente llama a hasRegistered:.
    El nombre del colaborador interno coleccionDeCuentas es un poco implementativo. Un mejor nombre podría ser accounts.
    Los nombres de los colaboradores internos de los tests podrían ser más claros. En vez de tener cuenta1 podrían tener receptiveAccount o receptiveAccountWithMoney.
    Es medio desorganizado tener varios tests con el mismo número en la misma suite de tests. Es decir, ustedes tienen dos tests01, dos tests02, y así.

Reportes

    El nombre de la jerarquía ReporteVisitor es implementativo, un mejor nombre podría ser ReporteDeTransaccionDeCuenta, y para las subclases NetoDeTransferencias y ResumenDeCuenta.

    Dentro de ambos reportes, para generar el reporte le están pidiendo a la cuenta sus transacciones. De esta manera, se están acoplando a la implementación de las cuentas.

    Lo que podrían hacer para evitar esto es tener un mensaje dentro de las cuentas para poder visitarlas con un reporte, algo como visitTransactionsFor: aTransactionReport .

    Para generar el reporte de Neto de Transferencia, utilizan un isKindOf: para saber si la transacción es parte de una transferencia o no. No es necesario que tengan ese if, ya que podrían tener los mensajes visitando al depósito y a la extracción, y que estos estén vacíos.

    Relacionado al problema de responsabilidades que tienen en el mensaje balance, les pasa algo similar con los reportes y los valores de las transacciones. No es responsabilidad del reporte saber si el valor de la transacción tiene que ser modificado (por ejemplo negado).

    No hay tests para el reporte de un Portfolio.

    En el camino de TDD para los Resumenes de Cuenta dan pasos muy grandes, testean un caso vacío, un caso con un depósito, y directamente ya testean casos múltiples. Lo ideal hubiera sido tener un test por cada tipo de transacción, y recién ahí testear casos múltiples.

    Algo similar podrían haber hecho con el Neto de Transferencia: testear cuando no hay transacciones, cuando hay una transacción de cada tipo, y después testear casos múltiples.

    Los nombres de los colaboradores internos de los tests podrían ser más claros. En vez de tener cuentaConTransaccion podrían tener qué tipo de cuenta es, algo como receptiveAccountConTransaccion.

Generales

    Para las aserciones en los tests, en vez de hacer self assert: … = … podrían usar el mensaje ya existente (y que les va a facilitar debuggear) self assert: … equals: ….

Un gusto corregir su ejercicio.

Ante cualquier duda ya sea de la corrección o del ejercicio en sí (o cualquier otro tema) no duden en consultarnos!

Que tengan una buena semana. Saludos, Pedro y Ana.
