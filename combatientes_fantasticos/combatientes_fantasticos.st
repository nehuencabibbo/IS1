!classDefinition: #CombateTest category: #Ejercicio01!
TestCase subclass: #CombateTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!CombateTest methodsFor: 'public' stamp: 'FG 4/2/2024 17:51:52'!
test01CombateAUnaRondaDañaAlCombatienteDelBando1

    | bando1 bando2 combate combatientesDelBando1 combatientesDelBando2 |
    
    combatientesDelBando1 := {Humano new}.
    combatientesDelBando2 := {Humano new}.
    
    bando1 := Bando conCombatientes: combatientesDelBando1 yEnemigos: combatientesDelBando2.
    bando2 := Bando conCombatientes: combatientesDelBando2 yEnemigos: combatientesDelBando1.
    
    combate := Combate conUnBando: bando1 yOtroBando: bando2.
    combate desarrollarRondas: 1.
    
    self deny: (bando1 estaDañadoPor: 0).! !

!CombateTest methodsFor: 'public' stamp: 'FG 4/2/2024 17:51:39'!
test02CombateAUnaRondaDañaAlCombatienteDelBando2
	
    | bando1 bando2 combate combatientesDelBando1 combatientesDelBando2 |
    
    combatientesDelBando1 := {Humano new}.
    combatientesDelBando2 := {Humano new}.
    
    bando1 := Bando conCombatientes: combatientesDelBando1 yEnemigos: combatientesDelBando2.
    bando2 := Bando conCombatientes: combatientesDelBando2 yEnemigos: combatientesDelBando1.
    
    combate := Combate conUnBando: bando1 yOtroBando: bando2.
    combate desarrollarRondas: 1.
    
    self deny: (bando2 estaDañadoPor: 0).! !

!CombateTest methodsFor: 'public' stamp: 'FG 4/2/2024 17:51:17'!
test03CombateAUnaRondaConBandosDeDistintaCantidadDeCombatientesDañaABando1
    
    | bando1 bando2 combate combatientesDelBando1 combatientesDelBando2 |
    
    combatientesDelBando1 := {Humano new. Humano new}.
    combatientesDelBando2 := {Humano new enfocarseEnElMasSano}.
    
    bando1 := Bando conCombatientes: combatientesDelBando1 yEnemigos: combatientesDelBando2.
    bando2 := Bando conCombatientes: combatientesDelBando2 yEnemigos: combatientesDelBando1.
    
    combate := Combate conUnBando: bando1 yOtroBando: bando2.
    combate desarrollarRondas: 1.

    self deny: (bando1 estaDañadoPor: 0).! !

!CombateTest methodsFor: 'public' stamp: 'FG 4/2/2024 17:51:09'!
test04CombateAUnaRondaConBandosDeDistintaCantidadDeCombatientesDañaABando2
    
    | bando1 bando2 combate combatientesDelBando1 combatientesDelBando2 |
    
    combatientesDelBando1 := {Humano new enfocarseEnElMasSano}.
    combatientesDelBando2 := {Humano new. Humano new}.
    
    bando1 := Bando conCombatientes: combatientesDelBando1 yEnemigos: combatientesDelBando2.
    bando2 := Bando conCombatientes: combatientesDelBando2 yEnemigos: combatientesDelBando1.

    combate := Combate conUnBando: bando1 yOtroBando: bando2.
    combate desarrollarRondas: 1.
    
    self deny: (bando2 estaDañadoPor: 0).! !

!CombateTest methodsFor: 'public' stamp: 'FG 4/2/2024 17:50:36'!
test05SePuedeDesarrollarUnCombateAMasDeUnaRondaEntreBandosDeUnCombatiente  

    | bando1 bando2 combate combatientesDelBando1 combatientesDelBando2 |
    
    combatientesDelBando1 := {Humano new}.
    combatientesDelBando2 := {Humano new}.
    
    bando1 := Bando conCombatientes: combatientesDelBando1 yEnemigos: combatientesDelBando2.
    bando2 := Bando conCombatientes: combatientesDelBando2 yEnemigos: combatientesDelBando1.
    
    combate := Combate conUnBando: bando1 yOtroBando: bando2.
    combate desarrollarRondas: 2.
    
    self assert: (bando2 estaDañadoPor: 8)! !

!CombateTest methodsFor: 'public' stamp: 'FG 4/2/2024 17:44:58'!
test06SePuedeDesarrollarUnCombateAMasDeUnaRondaEntreBandosDeMasDeUnCombatiente

    | bando1 bando2 combate combatientesDelBando1 combatientesDelBando2 |
    
    combatientesDelBando1 := {Ogro new. Ogro new}.
    combatientesDelBando2 := {Humano new. Humano new}.
    
    bando1 := Bando conCombatientes: combatientesDelBando1 yEnemigos: combatientesDelBando2.
    bando2 := Bando conCombatientes: combatientesDelBando2 yEnemigos: combatientesDelBando1.
    
    combate := Combate conUnBando: bando1 yOtroBando: bando2.
    combate desarrollarRondas: 2.

    self assert: (bando1 estaDañadoPor: 16).
    self assert: (bando2 estaDañadoPor: 32).! !

!CombateTest methodsFor: 'public' stamp: 'FG 4/2/2024 19:17:44'!
test07DesarrollarCombateCompleto

    | bando1 bando2 combate combatientesDelBando1 combatientesDelBando2 |
    
    combatientesDelBando1 := {Ogro new. Ogro new}.
    combatientesDelBando2 := {Humano new. Humano new}.
    
    bando1 := Bando conCombatientes: combatientesDelBando1 yEnemigos: combatientesDelBando2.
    bando2 := Bando conCombatientes: combatientesDelBando2 yEnemigos: combatientesDelBando1.
    
    combate := Combate conUnBando: bando1 yOtroBando: bando2.
    combate desarrollar.

   self assert: bando2 estaDerrotado.! !

!CombateTest methodsFor: 'public' stamp: 'FG 4/2/2024 19:19:46'!
test08MostrarGanador

    | bando1 bando2 combate combatientesDelBando1 combatientesDelBando2 |
    
    combatientesDelBando1 := {Ogro new. Ogro new}.
    combatientesDelBando2 := {Humano new. Humano new}.
    
    bando1 := Bando conCombatientes: combatientesDelBando1 yEnemigos: combatientesDelBando2.
    bando2 := Bando conCombatientes: combatientesDelBando2 yEnemigos: combatientesDelBando1.
    
    combate := Combate conUnBando: bando1 yOtroBando: bando2.
    combate desarrollar.

   self assert: combate obtenerGanador equals: 'El Bando 1 ha ganado'.! !

!CombateTest methodsFor: 'public' stamp: 'FG 4/2/2024 19:22:18'!
test09MostrarEstadisticas

    | bando1 bando2 combate combatientesDelBando1 combatientesDelBando2 |
    
    combatientesDelBando1 := {Ogro new. Ogro new}.
    combatientesDelBando2 := {Humano new. Humano new}.
    
    bando1 := Bando conCombatientes: combatientesDelBando1 yEnemigos: combatientesDelBando2.
    bando2 := Bando conCombatientes: combatientesDelBando2 yEnemigos: combatientesDelBando1.
    
    combate := Combate conUnBando: bando1 yOtroBando: bando2.
    combate desarrollar.

   self assert: combate obtenerEstadisticas equals: 'El porcentaje de vida del bando ganador es: 20%'.! !


!classDefinition: #CombatientesTest category: #Ejercicio01!
TestCase subclass: #CombatientesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!CombatientesTest methodsFor: 'tests-combatir' stamp: 'FG 4/2/2024 16:52:24'!
test_01_GoliatEmpiezaSano

	| goliat |
	goliat := Humano new.
		
	self assert: goliat estaSano.
! !

!CombatientesTest methodsFor: 'tests-combatir' stamp: 'FG 4/2/2024 16:52:27'!
test_02_GoliatNoEstaSanoSiRecibeDaño

	| goliat |
	goliat := Humano new.

	goliat recibirDaño: 2.

	self deny: goliat estaSano.
! !

!CombatientesTest methodsFor: 'tests-combatir' stamp: 'FG 4/2/2024 16:52:31'!
test_03_CuandoSeDañaAAlguienEsPorUnaCantidadDeDaño

	| goliat |
	goliat := Humano new.

	goliat recibirDaño: 4.
	
	self assert: (goliat estaDañadoPor: 4).
! !

!CombatientesTest methodsFor: 'tests-combatir' stamp: 'FG 4/2/2024 16:52:34'!
test_04_CuandoSeDañaAAlguienEsPorUnaCantidadDeDaño

	| goliat |
	goliat := Humano new.
	goliat recibirDaño: 4.
	
	self deny: (goliat estaDañadoPor: 8).
! !

!CombatientesTest methodsFor: 'tests-combatir' stamp: 'FG 4/2/2024 16:52:36'!
test_05_GoliatPuedeRecibirDañoMultiplesVeces

	| goliat |
	goliat := Humano new.

	goliat recibirDaño: 4.
	goliat recibirDaño: 4.
	
	self assert: (goliat estaDañadoPor: 8).
! !

!CombatientesTest methodsFor: 'tests-combatir' stamp: 'FG 4/2/2024 16:52:40'!
test_06_DavidPuedeAtacarAAlguien

	| david goliat |
	david := Humano new.
	goliat := Humano new.
	
	david atacarA: goliat.
	
	self assert: (goliat estaDañadoPor: 4).
! !

!CombatientesTest methodsFor: 'tests-combatir' stamp: 'FG 4/2/2024 16:52:45'!
test_07_DavidPuedeAtacarEnemigosAsignados

	| david goliat |
	david := Humano new.
	goliat := Humano new.
		
	david asignarEnemigos: {goliat}.
	david atacar.
	
	self deny: goliat estaSano.
	self assert: (goliat estaDañadoPor: 4).
! !

!CombatientesTest methodsFor: 'tests-combatir' stamp: 'FG 4/2/2024 16:52:49'!
test_08_DavidNoAtacaAUnEnemigoNoAsignado

	| david goliat |
	david := Humano new.
	goliat := Humano new.
		
	david atacar.
	
	self assert: goliat estaSano.
! !


!CombatientesTest methodsFor: 'tests-estrategia' stamp: 'FG 4/2/2024 16:51:58'!
test01PuedoDefinirleUnaEstrategiaADavid

	| goliat david |
	goliat := Humano new.
	david := Humano new.
	
	david enfocarseEnElMasSano.
	david asignarEnemigos: {goliat}.
	david atacar.
	
	self deny: goliat estaSano.
	self assert: (goliat estaDañadoPor: 4).! !

!CombatientesTest methodsFor: 'tests-estrategia' stamp: 'FG 4/2/2024 16:52:04'!
test02EnfocarseEnElMasSanoAtacaAlMenosDañado

	| david goliat isaac |
	david := Humano new.
	goliat := Humano new.
	goliat recibirDaño: 2.
	isaac := Humano new.
	
	david enfocarseEnElMasSano.
	david asignarEnemigos: {goliat. isaac.}.
	david atacar.
	
	self assert: (isaac estaDañadoPor: 4).! !

!CombatientesTest methodsFor: 'tests-estrategia' stamp: 'FG 4/2/2024 16:52:11'!
test03EnfocarseEnElMasSanoAtacaAlMenosDañadoNoImportaElOrden

	| david goliat isaac |
	david := Humano new.
	goliat := Humano new.
	goliat recibirDaño: 2.
	isaac := Humano new.
	
	david enfocarseEnElMasSano.
	david asignarEnemigos: {isaac. goliat.}.
	david atacar.
	
	self assert: (isaac estaDañadoPor: 4).! !

!CombatientesTest methodsFor: 'tests-estrategia' stamp: 'FG 4/2/2024 16:52:16'!
test04EnfocarseEnElMasHeridoAtacaAlMasDañado

	| david goliat isaac |
	david := Humano new.
	goliat := Humano new.
	goliat recibirDaño: 2.
	isaac := Humano new.
	
	david enfocarseEnElMasHerido.
	david asignarEnemigos: {goliat. isaac.}.
	david atacar.
	
	self assert: (goliat estaDañadoPor: 6).! !

!CombatientesTest methodsFor: 'tests-estrategia' stamp: 'FG 4/2/2024 17:11:11'!
test05UnCombatientePuedePegarPorUnaCantidadDeterminadaDeDaño

	| david goliat |
	david := Ogro new.
	goliat := Humano new.
	
	david asignarEnemigos: {goliat}.
	
	david atacar.
	
	self assert: (goliat estaDañadoPor: 8).! !


!classDefinition: #HostigadorTest category: #Ejercicio01!
CombatientesTest subclass: #HostigadorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!HostigadorTest methodsFor: 'test' stamp: 'FG 4/2/2024 16:50:37'!
test01HostigadorAtacaPrimeroAlMasSanoYLuegoAlMasHerido
    | hostigador humano1 humano2 |
    hostigador := Hostigador new.
    humano1 := Humano new.
    humano2 := Humano new.
    
    hostigador asignarEnemigos:
        {humano1. humano2}.
        
    hostigador atacar.
    hostigador atacar.
    hostigador atacar.
    
    self assert: (humano1 estaDañadoPor: 8).
    self assert: (humano2 estaDañadoPor: 4).! !


!classDefinition: #HumanoTest category: #Ejercicio01!
CombatientesTest subclass: #HumanoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!HumanoTest methodsFor: 'test' stamp: 'FG 4/2/2024 16:47:43'!
test01HumanoTiene20DeVida

	| humano1 humano2 |
	
	humano1 := Humano new.
	humano2 := Humano new.
	
	humano1 asignarEnemigos: {humano2}.
	
	5 timesRepeat: [humano1 atacar.].
	
	self assert: humano2 estaMuerto.! !

!HumanoTest methodsFor: 'test' stamp: 'FG 4/2/2024 17:02:28'!
test02HumanoPega4DeDaño

	| ogro humano |
	
	ogro := Ogro new.
	humano := Humano new.
	
	humano asignarEnemigos: {ogro}.
	
	humano atacar.
	
	self assert: (ogro estaDañadoPor: 4).! !


!classDefinition: #MagoTest category: #Ejercicio01!
CombatientesTest subclass: #MagoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!MagoTest methodsFor: 'test' stamp: 'FG 4/2/2024 17:10:46'!
test01MagoDañaALos6MasSanos

	| mago humano1 humano2 humano3 humano4 humano5 humano6 humano7 |
	
	mago := Mago new.
	humano1 := Humano new.
	humano2 := Humano new.
	humano3 := Humano new.
	humano4 := Humano new.
	humano5 := Humano new.
	humano6 := Humano new.
	humano7 := Humano new.
	
	mago asignarEnemigos: { humano1. humano2. humano3. humano4. humano5. humano6. humano7}.
	
	humano1 asignarEnemigos: { humano4 }.
	
	humano1 atacar.
	
	mago atacar.
	
	self assert: (humano1 estaDañadoPor: 2).
	self assert: (humano2 estaDañadoPor: 2).
	self assert: (humano3 estaDañadoPor: 2).
	self assert: (humano4 estaDañadoPor: 4).
	self assert: (humano5 estaDañadoPor: 2).
	self assert: (humano6 estaDañadoPor: 2).
	self assert: (humano7 estaDañadoPor: 2).! !


!classDefinition: #OgroTest category: #Ejercicio01!
CombatientesTest subclass: #OgroTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!OgroTest methodsFor: 'test' stamp: 'FG 4/2/2024 16:45:11'!
test01OgroTiene40DeVida

	| ogro humano |
	
	ogro := Ogro new.
	humano := Humano new.
	
	humano asignarEnemigos: {ogro}.
	
	10 timesRepeat: [humano atacar.].
	
	self assert: ogro estaMuerto.! !

!OgroTest methodsFor: 'test' stamp: 'FG 4/2/2024 17:03:06'!
test02OgroPega8DeDaño

	| ogro humano |
	
	ogro := Ogro new.
	humano := Humano new.
	
	ogro asignarEnemigos: {humano}.
	
	ogro atacar.
	
	self assert: (humano estaDañadoPor: 8).! !


!classDefinition: #Bando category: #Ejercicio01!
Object subclass: #Bando
	instanceVariableNames: 'grupoDeCombatientes grupoDeEnemigos vidaInicial'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!Bando methodsFor: 'initialization' stamp: 'FG 4/2/2024 19:07:47'!
initializeConCombatientes: unGrupoDeCombatientes yEnemigos: unGrupoDeEnemigos 
	
	grupoDeCombatientes := unGrupoDeCombatientes.
	grupoDeEnemigos := unGrupoDeEnemigos.
	self asignarEnemigos.
	self asignarVidaInicial.! !


!Bando methodsFor: 'private' stamp: 'FG 4/2/2024 16:56:10'!
asignarEnemigos
	
	grupoDeCombatientes do: [:combatiente | combatiente asignarEnemigos: grupoDeEnemigos].! !

!Bando methodsFor: 'private' stamp: 'FG 4/2/2024 19:08:23'!
asignarVidaInicial
	
	vidaInicial := grupoDeCombatientes inject: 0 into: [:sumaDeVida :combatiente | sumaDeVida + combatiente obtenerVida].! !


!Bando methodsFor: 'public' stamp: 'FG 4/2/2024 16:58:03'!
atacar

	grupoDeCombatientes do: [:combatiente | combatiente estaMuerto ifFalse: [combatiente atacar.]].! !

!Bando methodsFor: 'public' stamp: 'FG 4/2/2024 19:06:21'!
estaDañadoPor: unaCantidadDeDaño
	
	^unaCantidadDeDaño = self obtenerDaño .
	! !

!Bando methodsFor: 'public' stamp: 'FG 4/2/2024 18:38:58'!
estaDerrotado
	
	"grupoDeCombatientes do: [:combatiente | combatiente estaMuerto ifFalse: [^false]].
	
	^true."
	
	grupoDeCombatientes detect: [:combatiente | combatiente estaMuerto not] ifFound: [:combatiente | ^false] ifNone: [^true].! !

!Bando methodsFor: 'public' stamp: 'FG 4/2/2024 19:06:07'!
obtenerDaño
	
	^grupoDeCombatientes inject: 0 into: [:sumaDeDaño :combatiente | sumaDeDaño + combatiente dañoRecibido].
	
	! !

!Bando methodsFor: 'public' stamp: 'FG 4/2/2024 19:06:48'!
obtenerVidaInicial
	^vidaInicial.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Bando class' category: #Ejercicio01!
Bando class
	instanceVariableNames: ''!

!Bando class methodsFor: 'instance creation' stamp: 'NC 3/24/2024 15:50:34'!
conCombatientes: unGrupoDeCombatientes

	^self new initializeConCombatientes: unGrupoDeCombatientes! !

!Bando class methodsFor: 'instance creation' stamp: 'FG 4/2/2024 17:30:54'!
conCombatientes: unBandoDeCombatientes yEnemigos: unBandoDeEnemigos

	^self new initializeConCombatientes: unBandoDeCombatientes yEnemigos: unBandoDeEnemigos! !


!classDefinition: #Combate category: #Ejercicio01!
Object subclass: #Combate
	instanceVariableNames: 'bando1 bando2 cantidadDeRondas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!Combate methodsFor: 'initialization' stamp: 'FG 4/2/2024 18:53:26'!
initializeConUnBando: unBando yOtroBando: otroBando

	bando1 := unBando.
	bando2 := otroBando.
	cantidadDeRondas := 0.! !


!Combate methodsFor: 'public' stamp: 'FG 4/2/2024 18:54:12'!
desarrollar
	
	[bando1 estaDerrotado not and: bando2 estaDerrotado not] whileTrue: [self desarrollarRonda].
	! !

!Combate methodsFor: 'public' stamp: 'FG 4/2/2024 18:54:20'!
desarrollarRonda

	cantidadDeRondas := cantidadDeRondas + 1.
	bando1 atacar.
	bando2 atacar.! !

!Combate methodsFor: 'public' stamp: 'FG 4/2/2024 18:54:03'!
desarrollarRondas: unaCantidadDeRondas

	unaCantidadDeRondas timesRepeat: [self desarrollarRonda].! !

!Combate methodsFor: 'public' stamp: 'FG 4/2/2024 18:52:58'!
obtenerCantidadDeRondas
	^cantidadDeRondas.! !

!Combate methodsFor: 'public' stamp: 'FG 4/2/2024 19:22:00'!
obtenerEstadisticas
	
	| bandoGanador dañoRecibidoGanador vidaInicialGanador estadistica |
	
	bandoGanador := self obtenerBandoGanador.
	
	bandoGanador = nil ifTrue: ['El combeta no ha terminado'].
	
	vidaInicialGanador := bandoGanador obtenerVidaInicial.
	
	dañoRecibidoGanador := bandoGanador obtenerDaño.
	
	estadistica := dañoRecibidoGanador / vidaInicialGanador * 100.
	
	^'El porcentaje de vida del bando ganador es: ' , estadistica printString , '%'.! !

!Combate methodsFor: 'public' stamp: 'FG 4/2/2024 18:57:44'!
obtenerGanador
	
	bando1 estaDerrotado ifTrue: [^'El Bando 2 ha ganado'].

	bando2 estaDerrotado ifTrue: [^'El Bando 1 ha ganado']. 					
	
	^'El combeta no ha terminado'	.! !


!Combate methodsFor: 'private' stamp: 'FG 4/2/2024 19:01:10'!
obtenerBandoGanador
	
	bando1 estaDerrotado ifTrue: [^bando2].

	bando2 estaDerrotado ifTrue: [^bando1]. 					
	
	^nil.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Combate class' category: #Ejercicio01!
Combate class
	instanceVariableNames: ''!

!Combate class methodsFor: 'instance creation' stamp: 'FG 4/2/2024 17:35:45'!
conUnBando: unBando yOtroBando: otroBando

	^self new initializeConUnBando: unBando yOtroBando: otroBando. ! !


!classDefinition: #Combatiente category: #Ejercicio01!
Object subclass: #Combatiente
	instanceVariableNames: 'enemigos dañoRecibido dañoDeAtaque vida'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:25:43'!
asignarEnemigos: unConjuntoDeCombatientes 
	enemigos := unConjuntoDeCombatientes.! !

!Combatiente methodsFor: 'public' stamp: 'FG 4/2/2024 16:59:33'!
atacar
	self shouldBeImplemented.! !

!Combatiente methodsFor: 'public' stamp: 'NC 3/24/2024 15:23:50'!
atacarA: unCombatiente
	unCombatiente recibirDaño: dañoDeAtaque.! !

!Combatiente methodsFor: 'public' stamp: 'FG 4/2/2024 17:49:04'!
dañoRecibido
	^dañoRecibido! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:30:07'!
estaDañadoPor: unaCantidadDeDaño
	^dañoRecibido = unaCantidadDeDaño.! !

!Combatiente methodsFor: 'public' stamp: 'FG 4/2/2024 18:31:45'!
estaMuerto
	^vida <= 0.! !

!Combatiente methodsFor: 'public' stamp: 'SF 3/20/2024 19:30:36'!
estaSano
	^dañoRecibido = 0.! !

!Combatiente methodsFor: 'public' stamp: 'FG 4/2/2024 16:49:52'!
obtenerVida
	^vida.! !

!Combatiente methodsFor: 'public' stamp: 'FG 4/2/2024 16:49:34'!
recibirDaño: unaCantidadDeDaño
	dañoRecibido := dañoRecibido + unaCantidadDeDaño.
	vida := vida - unaCantidadDeDaño.! !


!classDefinition: #Hostigador category: #Ejercicio01!
Combatiente subclass: #Hostigador
	instanceVariableNames: 'estrategia seEnfocaEnElMasSano'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!Hostigador methodsFor: 'initialization' stamp: 'FG 4/2/2024 16:51:13'!
initialize
	enemigos := #().
	dañoRecibido := 0.
	dañoDeAtaque := 4.
	vida := 20.
	
	self enfocarseEnElMasSano.
	seEnfocaEnElMasSano := true.! !


!Hostigador methodsFor: 'public' stamp: 'FG 4/2/2024 16:46:45'!
atacar
    | victima |
    enemigos isEmpty ifTrue: [ ^ self ].
    victima := self elegirVictima.
    self atacarA: victima.
    self alternarEstrategia.! !

!Hostigador methodsFor: 'public' stamp: 'FG 4/2/2024 17:03:23'!
enfocarseEnElMasHerido
	estrategia := [:candidatos | candidatos detectMin: [:combatiente | combatiente obtenerVida ]].
! !

!Hostigador methodsFor: 'public' stamp: 'FG 4/2/2024 17:03:29'!
enfocarseEnElMasSano
	estrategia := [:candidatos | candidatos detectMax: [:combatiente | combatiente obtenerVida ]].
! !


!Hostigador methodsFor: 'private' stamp: 'FG 4/2/2024 16:46:15'!
alternarEstrategia
    seEnfocaEnElMasSano
        ifTrue: [
            self enfocarseEnElMasHerido.
            seEnfocaEnElMasSano := false ]
        ifFalse: [
            self enfocarseEnElMasSano.
            seEnfocaEnElMasSano := true ].! !

!Hostigador methodsFor: 'private' stamp: 'FG 4/2/2024 17:10:00'!
elegirVictima
    ^estrategia value: enemigos.! !


!classDefinition: #Humano category: #Ejercicio01!
Combatiente subclass: #Humano
	instanceVariableNames: 'estrategia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!Humano methodsFor: 'initialization' stamp: 'FG 3/26/2024 20:49:07'!
initialize
	enemigos := #().
	dañoRecibido := 0.
	dañoDeAtaque := 4.
	vida := 20.
	
	self enfocarseEnElMasSano.! !


!Humano methodsFor: 'public' stamp: 'FG 3/26/2024 20:48:03'!
atacar
	| victimaElegida |
	enemigos isEmpty ifTrue: [^self].
	victimaElegida := self elegirVictima.
	self atacarA: victimaElegida.
! !

!Humano methodsFor: 'public' stamp: 'FG 4/2/2024 17:19:25'!
enfocarseEnElMasHerido
	estrategia := [:candidatos | (candidatos select: [:combatiente | combatiente obtenerVida > 0]) detectMin: [:combatiente | combatiente obtenerVida ]].
! !

!Humano methodsFor: 'public' stamp: 'FG 4/2/2024 17:03:45'!
enfocarseEnElMasSano
	estrategia := [:candidatos | candidatos detectMax: [:combatiente | combatiente obtenerVida ]].
! !


!Humano methodsFor: 'private' stamp: 'FG 4/2/2024 17:09:31'!
elegirVictima
    ^estrategia value: enemigos.! !


!classDefinition: #Mago category: #Ejercicio01!
Combatiente subclass: #Mago
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!Mago methodsFor: 'public' stamp: 'FG 3/26/2024 21:16:47'!
asignarEstrategia
	
	enemigos sortBlock: [:combatiente1 :combatiente2 | combatiente1 obtenerVida > combatiente2 obtenerVida].
	
	(enemigos size > 6) 
		ifTrue: [1 to: 6]
		ifFalse: [enemigos do: [:combatiente | self atacarA: combatiente ].].
	
	! !

!Mago methodsFor: 'public' stamp: 'FG 3/26/2024 21:23:18'!
atacar
	| victimasElegidas |
	
	enemigos isEmpty ifTrue: [^self].
	victimasElegidas := self elegirVictimas.
	
	victimasElegidas do: [:combatiente | self atacarA: combatiente].
	
	
! !


!Mago methodsFor: 'initialization' stamp: 'FG 4/2/2024 16:54:46'!
initialize
	enemigos := #().
	dañoRecibido := 0.
	dañoDeAtaque := 2.
	vida := 20.! !


!Mago methodsFor: 'private' stamp: 'FG 4/2/2024 17:08:35'!
elegirVictimas
    
    enemigos sort: [:combatiente1 :combatiente2 | combatiente1 obtenerVida > combatiente2 obtenerVida].
    
    ^enemigos copyFrom: 1 to: 6.! !


!classDefinition: #Ogro category: #Ejercicio01!
Combatiente subclass: #Ogro
	instanceVariableNames: 'estrategia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio01'!

!Ogro methodsFor: 'public' stamp: 'FG 3/26/2024 20:47:54'!
atacar
	| victimaElegida |
	enemigos isEmpty ifTrue: [^self].
	victimaElegida := self elegirVictima.
	self atacarA: victimaElegida.
! !

!Ogro methodsFor: 'public' stamp: 'FG 4/2/2024 17:03:51'!
enfocarseEnElMasHerido
	estrategia := [:candidatos | candidatos detectMin: [:combatiente | combatiente obtenerVida ]].
! !

!Ogro methodsFor: 'public' stamp: 'FG 4/2/2024 17:03:57'!
enfocarseEnElMasSano
	estrategia := [:candidatos | candidatos detectMax: [:combatiente | combatiente obtenerVida ]].
! !


!Ogro methodsFor: 'initialization' stamp: 'FG 3/26/2024 20:48:40'!
initialize
	enemigos := #().
	dañoRecibido := 0.
	dañoDeAtaque := 8.
	vida := 40.
	
	self enfocarseEnElMasSano.! !


!Ogro methodsFor: 'private' stamp: 'FG 4/2/2024 17:09:35'!
elegirVictima
    ^estrategia value: enemigos.! !
