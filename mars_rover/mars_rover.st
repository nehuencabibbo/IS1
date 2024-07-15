!classDefinition: #MarsRoverTest category: #'Ejercicio-Mars-Rover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'roverEnElOrigenMirandoAlNorte'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Mars-Rover'!

!MarsRoverTest methodsFor: 'movimiento' stamp: 'Emi 4/28/2024 16:46:39'!
test01UnComandoVacioNoHaceNada

	roverEnElOrigenMirandoAlNorte 	ejecutaComandos: ''.
	
	self assert: (roverEnElOrigenMirandoAlNorte estasEn: 0@0).! !

!MarsRoverTest methodsFor: 'movimiento' stamp: 'Emi 4/28/2024 16:47:24'!
test02MoverseHaciaAdelanteUnaVezMirandoAlNorte

	roverEnElOrigenMirandoAlNorte 	ejecutaComandos: 'f'.
	
	self assert: (roverEnElOrigenMirandoAlNorte estasEn: 0@1).! !

!MarsRoverTest methodsFor: 'movimiento' stamp: 'Emi 4/28/2024 16:47:49'!
test03MoverseHaciaAdelanteDosVecesMirandoAlNorte

	roverEnElOrigenMirandoAlNorte 	ejecutaComandos: 'ff'.
	
	self assert: (roverEnElOrigenMirandoAlNorte estasEn: 0@2).! !

!MarsRoverTest methodsFor: 'movimiento' stamp: 'Emi 4/28/2024 16:48:09'!
test04MoverseHaciaAtrasUnaVezMirandoAlNorte

	roverEnElOrigenMirandoAlNorte 	ejecutaComandos: 'b'.
	
	self assert: (roverEnElOrigenMirandoAlNorte estasEn: 0@-1).! !

!MarsRoverTest methodsFor: 'movimiento' stamp: 'Emi 4/28/2024 16:48:23'!
test05MoverseHaciaAtrasDosVecesMirandoAlNorte

	roverEnElOrigenMirandoAlNorte 	ejecutaComandos: 'bb'.
	
	self assert: (roverEnElOrigenMirandoAlNorte estasEn: 0@-2).! !


!MarsRoverTest methodsFor: 'setup' stamp: 'Emi 4/28/2024 16:18:01'!
setUp

	roverEnElOrigenMirandoAlNorte := MarsRover enUnPunto: 0@0  mirandoHacia: $N. 
	! !


!MarsRoverTest methodsFor: 'errores' stamp: 'Emi 4/28/2024 16:48:43'!
test10ComandoInvalido

	|unComandoQueDebeFallar|
	
	unComandoQueDebeFallar := 'h'.
	self 
        should: [ roverEnElOrigenMirandoAlNorte ejecutaComandos: unComandoQueDebeFallar. ]
        raise: Error
        withExceptionDo: [:unError | 
            self assert: (unError messageText = MarsRover descripcionDeErrorDeComandoInvalido). ].! !


!MarsRoverTest methodsFor: 'sentido' stamp: 'Emi 4/28/2024 16:49:21'!
test06GirarUnaVezHaciaLaDerechaMirandoHaciaElNorte

	roverEnElOrigenMirandoAlNorte 	ejecutaComandos: 'r'.
	
	self assert: (roverEnElOrigenMirandoAlNorte estasMirandoHacia: $E).! !

!MarsRoverTest methodsFor: 'sentido' stamp: 'Emi 4/28/2024 16:49:36'!
test07GirarDosVecesHaciaLaDerechaMirandoHaciaElNorte

	roverEnElOrigenMirandoAlNorte 	ejecutaComandos: 'rr'.
	
	self assert: (roverEnElOrigenMirandoAlNorte estasMirandoHacia: $S).! !

!MarsRoverTest methodsFor: 'sentido' stamp: 'Emi 4/28/2024 16:49:48'!
test08GirarUnaVezHaciaLaIzquierdaMirandoHaciaElNorte

	roverEnElOrigenMirandoAlNorte 	ejecutaComandos: 'l'.
	
	self assert: (roverEnElOrigenMirandoAlNorte estasMirandoHacia: $O).! !

!MarsRoverTest methodsFor: 'sentido' stamp: 'Emi 4/28/2024 16:50:03'!
test09GirarDosVecesHaciaLaIzquierdaMirandoHaciaElNorte

	roverEnElOrigenMirandoAlNorte 	ejecutaComandos: 'll'.
	
	self assert: (roverEnElOrigenMirandoAlNorte estasMirandoHacia: $S).! !


!classDefinition: #CabezaMarsRover category: #'Ejercicio-Mars-Rover'!
Object subclass: #CabezaMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Mars-Rover'!

!CabezaMarsRover methodsFor: 'public' stamp: 'Emi 4/28/2024 15:32:52'!
girarDerecha
	self subclassResponsibility.! !

!CabezaMarsRover methodsFor: 'public' stamp: 'Emi 4/28/2024 15:32:46'!
girarIzquierda
	self subclassResponsibility.! !

!CabezaMarsRover methodsFor: 'public' stamp: 'Emi 4/28/2024 16:14:59'!
miraHacia: unPuntoCardinal
	self subclassResponsibility ! !

!CabezaMarsRover methodsFor: 'public' stamp: 'Emi 4/28/2024 15:42:31'!
unaPosicionAdelante
	self subclassResponsibility ! !

!CabezaMarsRover methodsFor: 'public' stamp: 'Emi 4/28/2024 15:42:28'!
unaPosicionAtras
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CabezaMarsRover class' category: #'Ejercicio-Mars-Rover'!
CabezaMarsRover class
	instanceVariableNames: ''!

!CabezaMarsRover class methodsFor: 'instance creation' stamp: 'Emi 4/28/2024 16:27:20'!
mirandoHacia: unPuntoCardinal
	|subclaseMirandoHaciaUnPuntoCardinal|
	subclaseMirandoHaciaUnPuntoCardinal := self subclasses detect: [: unaSubclase | unaSubclase new miraHacia: unPuntoCardinal ] ifNone: [^self error: 'Punto cardinal invalido. Debe ser $N, $S, $E, $O'].
	^subclaseMirandoHaciaUnPuntoCardinal new.! !


!classDefinition: #CabezaMarsRoverMirandoAlEste category: #'Ejercicio-Mars-Rover'!
CabezaMarsRover subclass: #CabezaMarsRoverMirandoAlEste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Mars-Rover'!

!CabezaMarsRoverMirandoAlEste methodsFor: 'public' stamp: 'Emi 4/28/2024 16:08:39'!
girarDerecha
	^CabezaMarsRoverMirandoAlSur new.
	! !

!CabezaMarsRoverMirandoAlEste methodsFor: 'public' stamp: 'Emi 4/28/2024 16:08:52'!
girarIzquierda
	^CabezaMarsRoverMirandoAlNorte new.! !

!CabezaMarsRoverMirandoAlEste methodsFor: 'public' stamp: 'Emi 4/28/2024 16:16:06'!
miraHacia: unPuntoCardinal
	^unPuntoCardinal = $E! !

!CabezaMarsRoverMirandoAlEste methodsFor: 'public' stamp: 'Emi 4/28/2024 15:49:11'!
unaPosicionAdelante
	^1@0! !

!CabezaMarsRoverMirandoAlEste methodsFor: 'public' stamp: 'Emi 4/28/2024 15:49:16'!
unaPosicionAtras
	^-1@0! !


!classDefinition: #CabezaMarsRoverMirandoAlNorte category: #'Ejercicio-Mars-Rover'!
CabezaMarsRover subclass: #CabezaMarsRoverMirandoAlNorte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Mars-Rover'!

!CabezaMarsRoverMirandoAlNorte methodsFor: 'public' stamp: 'Emi 4/28/2024 16:02:28'!
girarDerecha
	^CabezaMarsRoverMirandoAlEste new.! !

!CabezaMarsRoverMirandoAlNorte methodsFor: 'public' stamp: 'Emi 4/28/2024 16:02:46'!
girarIzquierda
	^CabezaMarsRoverMirandoAlOeste new.! !

!CabezaMarsRoverMirandoAlNorte methodsFor: 'public' stamp: 'Emi 4/28/2024 16:15:47'!
miraHacia: unPuntoCardinal
	^unPuntoCardinal = $N! !

!CabezaMarsRoverMirandoAlNorte methodsFor: 'public' stamp: 'Emi 4/28/2024 15:43:04'!
unaPosicionAdelante
	^0@1! !

!CabezaMarsRoverMirandoAlNorte methodsFor: 'public' stamp: 'Emi 4/28/2024 15:47:28'!
unaPosicionAtras
	^0@-1. ! !


!classDefinition: #CabezaMarsRoverMirandoAlOeste category: #'Ejercicio-Mars-Rover'!
CabezaMarsRover subclass: #CabezaMarsRoverMirandoAlOeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Mars-Rover'!

!CabezaMarsRoverMirandoAlOeste methodsFor: 'public' stamp: 'Emi 4/28/2024 16:04:04'!
girarDerecha
	^CabezaMarsRoverMirandoAlNorte new.! !

!CabezaMarsRoverMirandoAlOeste methodsFor: 'public' stamp: 'Emi 4/28/2024 16:08:05'!
girarIzquierda
	^CabezaMarsRoverMirandoAlSur new.! !

!CabezaMarsRoverMirandoAlOeste methodsFor: 'public' stamp: 'Emi 4/28/2024 16:16:30'!
miraHacia: unPuntoCardinal
	^unPuntoCardinal = $O! !

!CabezaMarsRoverMirandoAlOeste methodsFor: 'public' stamp: 'Emi 4/28/2024 15:49:38'!
unaPosicionAdelante
	^-1@0! !

!CabezaMarsRoverMirandoAlOeste methodsFor: 'public' stamp: 'Emi 4/28/2024 15:49:45'!
unaPosicionAtras
	^1@0! !


!classDefinition: #CabezaMarsRoverMirandoAlSur category: #'Ejercicio-Mars-Rover'!
CabezaMarsRover subclass: #CabezaMarsRoverMirandoAlSur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Mars-Rover'!

!CabezaMarsRoverMirandoAlSur methodsFor: 'public' stamp: 'Emi 4/28/2024 16:03:17'!
girarDerecha
	^CabezaMarsRoverMirandoAlOeste new.! !

!CabezaMarsRoverMirandoAlSur methodsFor: 'public' stamp: 'Emi 4/28/2024 16:03:33'!
girarIzquierda
	^CabezaMarsRoverMirandoAlEste new.! !

!CabezaMarsRoverMirandoAlSur methodsFor: 'public' stamp: 'Emi 4/28/2024 16:17:03'!
miraHacia: unPuntoCardinal 
	^unPuntoCardinal = $S! !

!CabezaMarsRoverMirandoAlSur methodsFor: 'public' stamp: 'Emi 4/28/2024 15:47:51'!
unaPosicionAdelante
	^0@-1! !

!CabezaMarsRoverMirandoAlSur methodsFor: 'public' stamp: 'Emi 4/28/2024 15:48:38'!
unaPosicionAtras
	^0@1! !


!classDefinition: #MarsRover category: #'Ejercicio-Mars-Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'posicion cabeza'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Mars-Rover'!

!MarsRover methodsFor: 'initialize' stamp: 'Emi 4/28/2024 16:10:56'!
initializeEnUnPunto: unPunto mirandoHacia: unPuntoCardinal
	posicion := unPunto.
	cabeza := CabezaMarsRover mirandoHacia: unPuntoCardinal.! !


!MarsRover methodsFor: 'public - operaciones basicas' stamp: 'Emi 4/28/2024 16:42:04'!
ejecutaComandos: unaSerieDeComandos
	|comandosValidos|
	comandosValidos := #($f, $b, $l, $r).
	
	unaSerieDeComandos do: 
		[:unComando | 
			(comandosValidos includes: unComando) ifFalse: [^self error: self class descripcionDeErrorDeComandoInvalido]. 
			unComando = $f ifTrue: [posicion := posicion + cabeza unaPosicionAdelante].
			unComando = $b ifTrue: [posicion := posicion + cabeza unaPosicionAtras].	
			unComando = $l ifTrue: [cabeza := cabeza girarIzquierda].
			unComando = $r ifTrue: [cabeza := cabeza girarDerecha].
		]! !

!MarsRover methodsFor: 'public - operaciones basicas' stamp: 'Emi 4/28/2024 14:56:51'!
estasEn: unPunto
	^posicion = unPunto.! !

!MarsRover methodsFor: 'public - operaciones basicas' stamp: 'Emi 4/28/2024 16:19:12'!
estasMirandoHacia: unPuntoCardinal
	^cabeza miraHacia: unPuntoCardinal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'Ejercicio-Mars-Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'error description' stamp: 'Emi 4/28/2024 16:35:25'!
descripcionDeErrorDeComandoInvalido
	^'Comando invalido. Los caracteres validos son: f, b, r, l'! !


!MarsRover class methodsFor: 'instance creation' stamp: 'Emi 4/28/2024 14:49:15'!
enUnPunto: unPunto mirandoHacia: unPuntoCardinal
	^ self new initializeEnUnPunto:unPunto mirandoHacia: unPuntoCardinal.
 ! !
