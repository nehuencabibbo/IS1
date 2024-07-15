# Servicios financieros

## Parte 1: Transferencias

Un banco quiere empezar a ofrecer nuevos servicios a sus clientes, por lo que nos contrató para extender su actual sistema.

Actualmente se cuenta con un modelo bancario simple, formado por cuentas bancarias y transacciones de depósito y retiro. El mismo se puede cargar haciendo file-in de ServiciosFinancieros-Ejercicio.st.

El primer servicio a implementar consiste en brindar la posibilidad de realizar transferencias entre los clientes. Para ello decidió agregar un nuevo tipo de transacción: la transferencia entre cuentas.

Una **transferencia** es una transacción entre cuentas, que tiene ”dos patas”. La **pata de la extracción**, de donde se saca la plata, y la **pata del depósito** a donde se deposita la plata.

Una transferencia se realiza entonces entre dos cuentas y por un valor.

Además de poder registrar una transferencia entre cuentas, deseamos poder saber el valor de la misma. Del mismo modo, queremos poder preguntarle a cada una de las patas de la transferencia cual es su contraparte: a la pata de extracción cual es el depósito por transferencia relacionado, y viceversa.

Antes de comenzar, notar que uno de los tests está fallando.. ¿qué sucede? Corregir este problema antes de comenzar con el modelado de las transferencias.

Una vez corregido el test, implementar el modelo mediante TDD.

## Parte 2: Portfolios

El segundo servicio a implementar es tener la posibilidad de poder administrar agrupaciones de cuentas. Las agrupaciones de cuentas se denominan **portfolios**. Se espera poder hacer con ellos lo mismo que con una cuenta convencional, excepto registrar transacciones. Por ejemplo, debemos podemos **obtener el balance** de un portfolio: Si un portfolio es la agrupación de Cuenta 1 (con balance de $100) y Cuenta 2 (con balance de $200), se espera que el balance del mismo sea $300. También se espera **poder preguntarle** a un portfolio por medio de un mensaje **si alguna de sus cuentas registró una transacción**. Por último, también se desea **poder conocer todas las transacciones de una cuenta** mediante otro mensaje.

Notar que un portfolio puede estar conformado no sólo por cuentas convencionales sino por otros portfolios, y se espera que las 3 operaciones mencionadas funcionen correctamente para estos casos también.

Por el momento, no se desea poder quitar cuentas convencionales ni portfolios de un portfolio.

Implementar el modelo mediante TDD.

### Portfolios válidos

Dado que un portfolio puede estar compuesto por otros portfolios, lo correcto sería que asegurarse que las cuentas no se repitan porque sino habría duplicación de información. Es decir, debemos evitar cualquiera de los siguientes escenarios:

1. Un portfolio no puede agregar dos veces la misma cuenta.
2. Un portfolio no puede agregar una cuenta ya incluída en un portfolio previamente agregado.
3. Un portfolio no se puede incluir a sí mismo.
4. No puedo agregar una cuenta a un portfolio cuando este último ya es hijo de otro portfolio padre que tenía dicha cuenta.
5. No puedo agregar un portfolio a otro porfolio, si el primero incluye una cuenta que el segundo ya tiene.

Extender el modelo existente para contemplar estas restricciones.

## Parte 3: Reportes

Por nuestro gran trabajo, el CEO del banco decidió extender el contrato y seguir agregando funcionalidades. Esta vez, quiere poder agregar la funcionalidad de brindar reportes para las cuentas y portfolios de clientes.

Se espera tener dos reportes inicialmente:

1. El resumen de cuentas (Account Summary).
2. El neto de transferencias (Transfer Net).

El **resumen de cuenta** debe generar una línea por cada transacción realizada en una cuenta con el siguiente formato:

```
Depósito por 100 pesos
Extracción por 50 pesos
Salida por transferencia de 20 pesos
Entrada por transferencia de 30 pesos
Balance = 60 pesos
```

Este sería el resumen de cuenta esperado de una cuenta a la cual se le realizó un depósito por 100, una extracción por 50, se le sacó 20 por una transferencia y recibió 30 por otra transferencia.

El **reporte de neto de transferencias** debe devolver el resultado de sumar todos los depósitos por transferencias y restarle todas las extracciones por transferencias. Para el ejemplo anterior, el neto de transferencias seria 10.

El banco prevé agregar muchos reportes nuevos en un tiempo inmediato, por lo tanto el modelo final para sacar reportes debe cumplir con los siguientes requerimientos de extensibilidad:

1. Poder agregar futuros reportes sin tener que modificar la jerarquía de cuentas.
2. Poder agregar futuros reportes sin tener que modificar la jerarquía de transacciones.
3. Crear nuevos reportes debe implicar crear clases nuevas únicamente y no modificar ninguna existente.

Implementar la solución haciendo TDD. Deben partir del código de la solución del ejercicio anterior, ya sea el realizado por ustedes o a partir de la solución provista por la cátedra.

## Extra: Reportes especiales

El CEO del banco nos pidió armar otros 2 nuevos reportes para portfolios. El primero (PortfolioTreePrinter) deberá mostrar la estructura de árbol completa del portfolio. El segundo, un reporte más detallado (PortfolioDetailedTreePrinter) que muestre las transacciones indentadas de acuerdo a la profundidad de cada cuenta del portfolio.

Dado un portfolio como se muestra a continuación: 
```
johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'. 
childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount. 
myAccount := ReceptiveAccount named: 'Cuenta mia'. 
familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
```

El reporte de la estructura de árbol de dicho portfolio debería ser:
```
Portfolio de la familia
   Cuenta mia
   Portfolio de hijos
      Cuenta de Juan
      Cuenta de Angeles
```

Se espera que el reporte detallado se muestre de la siguiente manera:
```
Portfolio de la familia
   Cuenta Mia
      Depósito por xxx
      Extracción por yyy
      Balance = bbb
   Portfolio de hijos
      Cuenta de Juan
         Depósito por zzz
         Extracción por nnn
         Balance = bbb
      Cuenta de Angeles
         Salida por transferencia de qqq
         Balance = bbb
      Balance = bbb
   Balance = bbb
```

Al igual que los reportes anteriores, el diseño final para resolverlos debe permitir agregar reportes sobre portfolios sin tener que modificar nada.
