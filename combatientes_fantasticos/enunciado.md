# Combatientes Fantasticos
## Enunciado

Quiero hacer un juego donde dos jugadores arman cada uno un bando de combatientes, definiendo la estrategia a cada combatiente.

Luego se ponen a combatir estos dos bandos y quiero saber cuánto tiempo duró el combate, quién ganó y alguna medida de cuán bien ganó: porcentaje de vida que le quedó al ganador.
Aclaraciones

## Cómo funciona un combate:

    cómo identificar cada bando: bando 1 y bando 2

    iniciativa: bando 1 va primero

    se ejecuta por rondas

    una ronda es: cada miembro del bando 1 ataca (recibe el mensaje #atacar), luego cada miembro del bando 2 ataca y ahí termina la ronda

    se chequea que el combate terminó sólo entre rondas

    forma de expresar que ganó un bando: se puede preguntar “ganó el bando 1?”, “ganó el bando 2?”, tal vez devolver una string describiendo el bando ganador.

## Información o funcionalidad que tal vez necesite definir:

    que alguien en cero hit points no puede actuar más (empiezan en 20)

    seguramente necesiten más mensajes en el Combatiente para poder resolver la información que se necesita al finalizar el combate
