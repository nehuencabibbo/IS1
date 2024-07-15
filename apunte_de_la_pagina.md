<h2 id="apunte-teórico-">Apunte teórico <img alt="github icon" width="20px" src="https://icongr.am/clarity/library.svg?size=128&amp;color=currentColor" /></h2>

<h2 id="conceptos-fundamentales">Conceptos fundamentales</h2>

<p>Software:</p>
<ul>
  <li>Modelo computable de un dominio de problema de la realidad. Dominio = recorte de la realidad.</li>
</ul>

<p>Desarrollo de software:</p>
<ul>
  <li>Proceso de aprendizaje</li>
  <li>Iterativo e incremental. Feedback inmediato es fundamental.</li>
  <li>Eje descriptivo	, funcional e implementativo. Foco en eje descriptivo y funcional.</li>
</ul>

<p>Paradigma de Objetos:</p>
<ul>
  <li>Objetos que colaboran entre si mediante el envio de mensajes.</li>
</ul>

<p>Objeto:</p>
<ul>
  <li>Representación de un ente de la realidad.</li>
  <li>Se define a partir de los mensajes que sabe responder.</li>
</ul>

<p>Mensaje:</p>
<ul>
  <li>Define el QUE del objeto (vs Método que define el COMO)</li>
  <li>Define una responsabilidad que tiene el objeto.</li>
  <li>Puede tener múltiples implementaciones asociadas (métodos).</li>
</ul>

<p>Método:</p>
<ul>
  <li>Implementación de un mensaje. Define el COMO.</li>
  <li>Conjunto de colaboraciones.</li>
</ul>

<p>Colaborador:</p>
<ul>
  <li>También conocido como variable.</li>
  <li>Interno (variable de instancia), externo (parámetro) o temporales (variables).
    <ul>
      <li>Interno: Lo conozco siempre. Relación de cercanía en cuanto al conocimiento.</li>
      <li>Externo: Lo conozco para una colaboración puntual.</li>
      <li>Temporal: Lo conozco temporalmente dentro de un conjunto de colaboraciones.</li>
    </ul>
  </li>
</ul>

<p>Closure:</p>
<ul>
  <li>Conjunto de colaboraciones, al igual que un método, pero no está asociado a ningún objeto. No hay mensaje asociado.</li>
  <li>Están bindeados al contexto.</li>
  <li>Closure vs “full” closures. Estos últimos tienen binding del return al contexto de ejecución (ej: Smalltalk, Ruby).</li>
</ul>

<p>Clase:</p>
<ul>
  <li>Concepto que aparece en lenguajes OOP con clasificación (vs prototipado, como Self o JS).</li>
  <li>Representa un concepto o idea de la realidad. Ej: “Silla” (clase) vs “esta silla blanca donde estoy sentado (instancia).</li>
  <li>Todo objeto es instancia de una clase.</li>
  <li>Abstracta: No tiene realizaciones concretas. No hay entes de la realidad que puedo relacionar de forma exclusiva con el concepto. Ej: Todo “Numero” es real, entero, fraccionario o imaginario.
    <ul>
      <li>Tiene al menos un método abstracto.</li>
      <li>Corolario: No tiene sentido instanciarlo.</li>
    </ul>
  </li>
  <li>Métodos de instancia vs métodos de clase: Los primeros definen el comportamiento de las instancias, mientras que los segundos, el comportamiento de las clases.</li>
</ul>

<p>Subclase:</p>
<ul>
  <li>Especialización. “Se comporta como” (ojo con el ES UN).</li>
  <li>Subclasificación: Forma de organizar conocimiento mediante jerarquías de clases.</li>
</ul>

<p>Polimorfismo:
-Dos o mas objetos son polimorficos entre si respecto a un conjunto de mensajes &lt;=&gt;
	- Responden de la misma manera / Son semánticamente iguales
	- Mismo nombre del mensaje
	- Misma cantidad y tipo de parametros
	- Mismo tipo de resultado</p>

<h2 id="heurísticas-de-diseño">Heurísticas de diseño</h2>

<ul>
  <li>Buscar el 1:1 entre objeto - ente</li>
  <li>Favorecer composicion por sobre subclasificación</li>
  <li>Quitar código repetido: Señal de que falta una abstracción.</li>
  <li>No romper encapsulamiento.</li>
  <li>Nombrar a los objetos segun el ROL que cumplen en un determinado contexto</li>
  <li>No subclasificar de clases concretas</li>
  <li>Guiarnos por los aspectos funcionales conducen a mejores modelos</li>
  <li>Favorecer el uso de polimorfismo por sobre ifs.</li>
  <li>Favorecer inmutabilidad</li>
  <li>Crear objetos completos</li>
  <li>Crear objetos validos</li>
  <li>No usar null</li>
</ul>

<h2 id="reemplazar-if-por-polimorfismo">Reemplazar if por polimorfismo</h2>

<ol>
  <li>Crear una jerarquia de clases con una clase por cada condicion del if (si no existe)</li>
  <li>Mover el cuerpo del if de cada condicion a cada abstracción del paso 1) utilizando un mensaje polimorfico.</li>
  <li>Nombrar el mensaje polifmorfico</li>
  <li>Nombrar las abstracciones del paso 1)</li>
  <li>Reemplazar el if por el envio de mensaje polimorfico</li>
  <li>Buscar el objeto polimorfico (si es necesario)</li>
</ol>

<h2 id="tdd">TDD</h2>

<ol>
  <li>Escribir el test mas sencillo posible que falle.</li>
  <li>Hacer pasar todos los tests con la implementación más simple posible.</li>
  <li>Reflexionar. ¿Se puede mejorar?</li>
</ol>
