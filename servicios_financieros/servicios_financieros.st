!classDefinition: #PortfolioTest category: #'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'cuenta1 cuenta2 cuenta3 cuenta4'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'funcionamiento' stamp: 'FG 5/3/2024 19:28:36'!
setUp
	
	cuenta1 := ReceptiveAccount  new	.
	cuenta2 := ReceptiveAccount new.
	cuenta3 := ReceptiveAccount  new	.
	cuenta4 := ReceptiveAccount new.
	
	Deposit register: (9 * peso) on: cuenta1.
	Deposit register: (12 * peso) on: cuenta2.
	Deposit register: (18 * peso) on: cuenta3.! !

!PortfolioTest methodsFor: 'funcionamiento' stamp: 'FG 5/3/2024 19:30:33'!
test01UnPortfolioVacioTieneBalanceCero
	
	| portfolio |
	
	portfolio := Portfolio conCuentas: {}.
	
	self assert: portfolio balance = 0.
	! !

!PortfolioTest methodsFor: 'funcionamiento' stamp: 'FG 5/3/2024 19:31:00'!
test02UnPortfolioConUnaCuentaTieneElBalanceDeLaCuenta
	
	| portfolio |
	
	portfolio := Portfolio conCuentas: {cuenta1}.
	
	self assert: portfolio balance = (cuenta1 balance).
	! !

!PortfolioTest methodsFor: 'funcionamiento' stamp: 'FG 5/3/2024 19:31:22'!
test03UnPortfolioConMultiplesCuentasTieneElBalanceDeLaSuma
	
	| portfolio |
	
	portfolio := Portfolio conCuentas: {cuenta1. cuenta2}.
	
	self assert: portfolio balance = (cuenta1 balance + cuenta2 balance).
	! !

!PortfolioTest methodsFor: 'funcionamiento' stamp: 'FG 5/3/2024 19:33:23'!
test04UnPortfolioNoTieneUnaTransaccionDeUnaCuentaQueNoTiene
	
	| portfolio transaccion |
	
	portfolio := Portfolio conCuentas: {cuenta1. cuenta2}.
	
	transaccion := Deposit register: (10 * peso) on: cuenta3.
	
	self deny: (portfolio tieneTransaccion: transaccion).! !

!PortfolioTest methodsFor: 'funcionamiento' stamp: 'FG 5/3/2024 19:34:07'!
test05UnPortfolioConUnaCuentaTieneLasTransaccionesDeLaMisma
	
	| portfolio transaccion |
	
	portfolio := Portfolio conCuentas: {cuenta1}.
	
	transaccion := Deposit register: (10 * peso) on: cuenta1. 
	
	self assert: (portfolio tieneTransaccion: transaccion).! !

!PortfolioTest methodsFor: 'funcionamiento' stamp: 'FG 5/3/2024 19:38:31'!
test06UnPortfolioConMultiplesCuentasTieneLasTransaccionesDeLasMismas
	
	| portfolio todasLasTransacciones |
	
	portfolio := Portfolio conCuentas: {cuenta1. cuenta2}.
	
	todasLasTransacciones := OrderedCollection new.
	
	todasLasTransacciones addAllLast: cuenta1 transactions.
	todasLasTransacciones addAllLast: cuenta2 transactions.
	
	self assert: (portfolio transactions = todasLasTransacciones ).! !

!PortfolioTest methodsFor: 'funcionamiento' stamp: 'FG 5/3/2024 19:43:05'!
test07UnPortfolioConUnPortfolioInternoTieneAlgunasDeLasTransaccionesDeSusCuentasYLasDelPortfolioIntero
	
	| transaccion1 transaccion2 portfolio1 portfolio2 transaccion3 |
	
	portfolio1 := Portfolio conCuentas: {cuenta1. cuenta2}.
	portfolio2 := Portfolio conCuentas: {portfolio1. cuenta3}.
		
	transaccion1 := Deposit register: (10 * peso) on: cuenta1. 
	transaccion2 := Deposit register: (10 * peso) on: cuenta2. 
	transaccion3 := Deposit register: (12 * peso) on: cuenta3. 
	
	self assert: (portfolio2 tieneTransaccion: transaccion1).
	self assert: (portfolio2 tieneTransaccion: transaccion2).
	self assert: (portfolio2 tieneTransaccion: transaccion3).! !

!PortfolioTest methodsFor: 'funcionamiento' stamp: 'FG 5/3/2024 19:40:44'!
test08UnPortfolioConUnPortfolioInternoTieneTodasLasTransaccionesCorrespondientes
	
	| portfolio todasLasTransacciones portfolioInterno |
	
	portfolioInterno := Portfolio conCuentas: {cuenta3 }.
	portfolio := Portfolio conCuentas: {cuenta1. cuenta2. portfolioInterno}.
	
	todasLasTransacciones := OrderedCollection new.
	
	todasLasTransacciones addAllLast: cuenta1 transactions.
	todasLasTransacciones addAllLast: cuenta2 transactions.
	todasLasTransacciones addAllLast: cuenta3 transactions.
	
	self assert: (portfolio transactions = todasLasTransacciones ).! !


!PortfolioTest methodsFor: 'validacion' stamp: 'FG 5/3/2024 20:04:57'!
test01UnPortfolioNoPuedeAgregarUnaCuentaQueYaTiene

	| portfolio |
	
	portfolio := Portfolio conCuentas: {cuenta1}.
	
	self 
		should: [portfolio agregarCuenta: cuenta1] 
		raise: Error
		withExceptionDo: [:error |self assert: error messageText = Portfolio descripcionErrorAgregarCuentaYaContenida].
	
	! !

!PortfolioTest methodsFor: 'validacion' stamp: 'FG 5/3/2024 20:25:54'!
test02UnPortfolioNoPuedeAgregarUnaCuentaYaIncluídaEnUnPortfolioPreviamenteAgregado

	| portfolio portfolio2 |
	
	portfolio := Portfolio conCuentas: {cuenta1}.
	portfolio2 := Portfolio conCuentas: {cuenta2. portfolio.}.
	
	self 
		should: [portfolio2 agregarCuenta: cuenta1] 
		raise: Error
		withExceptionDo: [:error |self assert: error messageText = Portfolio descripcionErrorAgregarCuentaYaContenida].
	
	! !

!PortfolioTest methodsFor: 'validacion' stamp: 'FG 5/3/2024 20:31:31'!
test03UnPortfolioNoSePuedeIncluirASiMismo

	| portfolio |
	
	portfolio := Portfolio conCuentas: {cuenta1}.
	
	self 
		should: [portfolio agregarCuenta: portfolio] 
		raise: Error
		withExceptionDo: [:error |self assert: error messageText = Portfolio descripcionErrorAgregarseASiMismo].
	
	! !

!PortfolioTest methodsFor: 'validacion' stamp: 'Emi 5/5/2024 15:36:41'!
test04UnaCuentaNoPuedeSerAgregadaAUnPortfolioCuandoEstePortfolioEsHijoDeUnPortfolioQueYaTieneLaCuenta

	| portfolio portfolioHijo |
	portfolioHijo := Portfolio conCuentas: {}.
	portfolio := Portfolio conCuentas: {cuenta1. portfolioHijo}.
	self 
		should: [	portfolioHijo agregarCuenta: cuenta1.] 
		raise: Error
		withExceptionDo: [:error |self assert: error messageText = Portfolio descripcionErrorAgregarCuentaYaContenida].
	
	! !

!PortfolioTest methodsFor: 'validacion' stamp: 'Emi 5/5/2024 15:38:48'!
test05UnPortfolioNoPuedeSerAgregadoAOtroPortfolioCuandoElPortfolioPadreYaTieneLaCuenta

	| portfolio portfolioHijo |
	portfolioHijo := Portfolio conCuentas: {cuenta1}.
	portfolio := Portfolio conCuentas: {cuenta1}.
	self 
		should: [	portfolio agregarCuenta: portfolioHijo .] 
		raise: Error
		withExceptionDo: [:error |self assert: error messageText = Portfolio descripcionErrorAgregarCuentaYaContenida].
	
	! !


!classDefinition: #ReceptiveAccountTest category: #'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'Emi 5/3/2024 10:32:13'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JS 4/30/2024 13:50:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: account transactions includes: deposit.
! !


!classDefinition: #ReporteVisitorTest category: #'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReporteVisitorTest
	instanceVariableNames: 'cuentaVacia cuentaConTransaccion cuentaConVariasTransacciones'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReporteVisitorTest methodsFor: 'setUp' stamp: 'Emi 5/10/2024 12:57:57'!
setUp
	
	cuentaVacia := ReceptiveAccount new.
	
	cuentaConTransaccion := ReceptiveAccount new.
	Deposit register: (60 * peso) on: cuentaConTransaccion.
	 
	cuentaConVariasTransacciones := ReceptiveAccount new.
	Deposit register: (50 * peso) on: cuentaConVariasTransacciones.
	Withdraw register: (10 * peso) on: cuentaConVariasTransacciones.! !


!ReporteVisitorTest methodsFor: 'testsNetoDeTransferencia' stamp: 'Emi 5/10/2024 14:32:38'!
test06ReporteNetoDeCuentaVacia
	| reporte resumen resultado |
	reporte := ReporteVisitorNetoDeTransferencias de: 	cuentaVacia .
	
	resumen := reporte mostrarReporte.
	
	resultado := 'El balance neto de transferencias es de 0 pesos'.
	
	self assert: resumen = resultado. ! !

!ReporteVisitorTest methodsFor: 'testsNetoDeTransferencia' stamp: 'Emi 5/10/2024 14:33:44'!
test07ReporteNetoDeCuentaConTransaccionNoAfectaAlReporte
	| reporte resumen resultado |
	reporte := ReporteVisitorNetoDeTransferencias de: 	cuentaConTransaccion .
	
	resumen := reporte mostrarReporte.
	
	resultado := 'El balance neto de transferencias es de 0 pesos'.
	
	self assert: resumen = resultado. ! !

!ReporteVisitorTest methodsFor: 'testsNetoDeTransferencia' stamp: 'Emi 5/10/2024 14:33:56'!
test08ReporteNetoDeCuentaConTransaccionesNoAfectaAlReporte
	| reporte resumen resultado |
	reporte := ReporteVisitorNetoDeTransferencias de: 	cuentaConVariasTransacciones .
	
	resumen := reporte mostrarReporte.
	
	resultado := 'El balance neto de transferencias es de 0 pesos'.
	
	self assert: resumen = resultado. ! !

!ReporteVisitorTest methodsFor: 'testsNetoDeTransferencia' stamp: 'Emi 5/10/2024 14:34:16'!
test09ReporteNetoDeCuentaConTransferencia
	| reporte resumen resultado |
	reporte := ReporteVisitorNetoDeTransferencias de: 	cuentaConVariasTransacciones .
	
	Transferencia register: (20 * peso) desde: cuentaConTransaccion hacia: cuentaConVariasTransacciones.
	
	resumen := reporte mostrarReporte.
	
	resultado := 'El balance neto de transferencias es de 20 pesos'.
	
	self assert: resumen = resultado. ! !

!ReporteVisitorTest methodsFor: 'testsNetoDeTransferencia' stamp: 'Emi 5/10/2024 14:34:25'!
test10ReporteNetoDeCuentaConTransferencias
	| reporte resumen resultado |
	reporte := ReporteVisitorNetoDeTransferencias de: 	cuentaConVariasTransacciones .
	
	Transferencia register: (20 * peso) desde: cuentaConTransaccion hacia: cuentaConVariasTransacciones.
	Transferencia register: (10 * peso) desde: cuentaConVariasTransacciones hacia: cuentaConTransaccion.
	
	resumen := reporte mostrarReporte.
	
	resultado := 'El balance neto de transferencias es de 10 pesos'.
	
	self assert: resumen = resultado. ! !


!ReporteVisitorTest methodsFor: 'testsResumenDeCuenta' stamp: 'Emi 5/10/2024 14:28:38'!
test01ResumenDeUnaCuentaVaciaMuestraSoloElBalance
	| reporte mensaje |
	reporte := ReporteVisitorResumenDeCuenta de: 	cuentaVacia.
	
	mensaje := reporte mostrarReporte.
	
	self assert: mensaje = 'Balance = 0 pesos'. ! !

!ReporteVisitorTest methodsFor: 'testsResumenDeCuenta' stamp: 'Emi 5/10/2024 14:29:22'!
test02ResumenDeCuentaConDepositoMuestraTransaccionYBalance
	| reporte resumen resultado |
	reporte := ReporteVisitorResumenDeCuenta de: 	cuentaConTransaccion .
	
	resumen := reporte mostrarReporte.
	
	resultado := 'Depósito por 60 pesos', Character cr asString, 'Balance = 60 pesos'.
	
	self assert: resumen = resultado. ! !

!ReporteVisitorTest methodsFor: 'testsResumenDeCuenta' stamp: 'Emi 5/10/2024 14:29:53'!
test03ResumenDeCuentaConVariasTransaccionesMuestraTransaccionesYBalance
	| reporte resumen resultado |
	reporte := ReporteVisitorResumenDeCuenta de: 	cuentaConVariasTransacciones .
	
	resumen := reporte mostrarReporte.
	
	resultado := 'Depósito por 50 pesos', Character cr asString, 'Extracción por 10 pesos', Character cr asString, 'Balance = 40 pesos'.
	
	self assert: resumen = resultado. ! !

!ReporteVisitorTest methodsFor: 'testsResumenDeCuenta' stamp: 'Emi 5/10/2024 14:30:43'!
test04ResumenDeCuentaConVariasTransaccionesYTransferencia
	| reporte resumen resultado |
	reporte := ReporteVisitorResumenDeCuenta de: cuentaConVariasTransacciones .
	
	Transferencia register: (20 * peso) desde: cuentaConTransaccion hacia: cuentaConVariasTransacciones. 
	
	resultado := 'Depósito por 50 pesos', Character cr asString, 'Extracción por 10 pesos', Character cr asString, 'Entrada por transferencia de 20 pesos', 	Character cr asString, 'Balance = 60 pesos'.
	
	resumen := reporte mostrarReporte.
	
	self assert: resumen = resultado. 
! !

!ReporteVisitorTest methodsFor: 'testsResumenDeCuenta' stamp: 'Emi 5/10/2024 14:30:55'!
test05ResumenDeCuentaConVariasTransaccionesYTransferencias
	| reporte resumen resultado |
	reporte := ReporteVisitorResumenDeCuenta de: cuentaConVariasTransacciones .
	
	Transferencia register: (20 * peso) desde: cuentaConTransaccion hacia: cuentaConVariasTransacciones. 
	Transferencia register: (10 * peso) desde: cuentaConVariasTransacciones hacia: cuentaConTransaccion.
	
	resultado := 'Depósito por 50 pesos', Character cr asString, 'Extracción por 10 pesos', Character cr asString, 'Entrada por transferencia de 20 pesos', 	
	Character cr asString, 'Salida por transferencia de 10 pesos', Character cr asString, 'Balance = 50 pesos'.
	
	resumen := reporte mostrarReporte.
	
	self assert: resumen = resultado. ! !


!classDefinition: #TransferenciaTest category: #'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferenciaTest
	instanceVariableNames: 'cuentaOrigen cuentaDestino'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenciaTest methodsFor: 'tests' stamp: 'Emi 5/3/2024 13:23:14'!
setUp
	
	cuentaOrigen := ReceptiveAccount  new	.
	Deposit register: (100 * peso) on: cuentaOrigen.
	cuentaDestino := ReceptiveAccount new.! !

!TransferenciaTest methodsFor: 'tests' stamp: 'Emi 5/3/2024 15:19:21'!
test01
	| valor |
	valor := 50 * peso.
	
	Transferencia register: valor  desde: cuentaOrigen  hacia: cuentaDestino.
	
	self assert: cuentaOrigen balance = (50 * peso).
	self assert: cuentaDestino balance = (50 * peso).
	! !

!TransferenciaTest methodsFor: 'tests' stamp: 'Emi 5/3/2024 15:20:32'!
test02
	| valor transferencia |
	valor := 50 * peso.
	
	transferencia := Transferencia register: valor  desde: cuentaOrigen  hacia: cuentaDestino.
	
	self assert: transferencia valor = (50 * peso).
! !

!TransferenciaTest methodsFor: 'tests' stamp: 'Emi 5/3/2024 15:20:37'!
test03
	| valor transferencia |
	valor := 50 * peso.
	
	transferencia := Transferencia register: valor  desde: cuentaOrigen  hacia: cuentaDestino.
	
	self assert: transferencia obtenerParteRetiro == transferencia obtenerParteDeposito obtenerContraparte.
! !

!TransferenciaTest methodsFor: 'tests' stamp: 'Emi 5/3/2024 15:22:24'!
test04
	| valor transferencia |
	valor := 50 * peso.
	
	transferencia := Transferencia register: valor  desde: cuentaOrigen  hacia: cuentaDestino.
	
	self assert: transferencia obtenerParteDeposito == transferencia obtenerParteRetiro obtenerContraparte.
! !

!TransferenciaTest methodsFor: 'tests' stamp: 'Emi 5/3/2024 15:36:11'!
test05

	self should: [Transferencia register: (0  * peso)  desde: cuentaOrigen  hacia: cuentaDestino] 
		raise: Error  
			withExceptionDo: [:unError | self assert: unError messageText equals: Transferencia descripcionDeErrorValorMayorACero ]
! !

!TransferenciaTest methodsFor: 'tests' stamp: 'Emi 5/3/2024 15:37:43'!
test06

	self should: [Transferencia register: (50  * peso)  desde: cuentaOrigen  hacia: cuentaOrigen] 
		raise: Error  
			withExceptionDo: [:unError | self assert: unError messageText equals: Transferencia descripcionDeErrorTransferirmeAMiMismo ]
! !


!classDefinition: #AccountTransaction category: #'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'Emi 5/3/2024 12:00:09'!
valueForBalance
	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'public' stamp: 'Emi 5/10/2024 12:32:13'!
aceptar: unReporte
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'Emi 5/3/2024 11:06:32'!
register: aValue on: account

	| transaction |

	transaction := self for: aValue.
	account register: transaction.
	^transaction.! !


!classDefinition: #Deposit category: #'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

!Deposit methodsFor: 'value' stamp: 'Emi 5/3/2024 12:00:28'!
valueForBalance
	^value! !


!Deposit methodsFor: 'public' stamp: 'Emi 5/10/2024 12:45:57'!
aceptar: unReporte
	unReporte visitarDeposito: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

!Withdraw methodsFor: 'value' stamp: 'Emi 5/3/2024 12:00:44'!
valueForBalance
	^value negated.! !


!Withdraw methodsFor: 'public' stamp: 'Emi 5/10/2024 13:19:02'!
aceptar: unReporte
	unReporte visitarRetiro: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'Emi 5/3/2024 10:31:34'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'coleccionDeCuentas portfolioPadre'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'funcionalidad' stamp: 'Emi 5/5/2024 15:14:11'!
agregarCuenta: unaCuenta

	unaCuenta = self ifTrue: [^self error: self class descripcionErrorAgregarseASiMismo].

	"(self tieneCuenta: unaCuenta) ifTrue: [^self error: self class descripcionErrorAgregarCuentaYaContenida ]."
	
	(self padreTieneCuenta: unaCuenta) ifTrue: [^self error: self class descripcionErrorAgregarCuentaYaContenida ].
	
	coleccionDeCuentas add: unaCuenta.
	! !

!Portfolio methodsFor: 'funcionalidad' stamp: 'FG 5/3/2024 18:03:14'!
balance
	
	^coleccionDeCuentas inject: 0 into: [:balance :unaCuenta | balance + (unaCuenta balance)].! !

!Portfolio methodsFor: 'funcionalidad' stamp: 'FG 5/3/2024 18:37:48'!
hasRegistered: unaTransaccion
	
	^self tieneTransaccion: unaTransaccion.! !

!Portfolio methodsFor: 'funcionalidad' stamp: 'Emi 5/5/2024 15:52:04'!
obtenerCuentas
	
	^coleccionDeCuentas copy.! !

!Portfolio methodsFor: 'funcionalidad' stamp: 'Emi 5/10/2024 14:56:57'!
padreTieneCuenta: unaCuenta

	"unaCuenta = self ifTrue: [^self error: self class descripcionErrorAgregarseASiMismo].
	
	(self tieneCuenta: unaCuenta) ifTrue: [^self error: self class descripcionErrorAgregarCuentaYaContenida ]."
	
	
	portfolioPadre = nil 
		ifTrue: [^self tieneCuenta: unaCuenta]
		ifFalse: [^portfolioPadre padreTieneCuenta: unaCuenta.	]! !

!Portfolio methodsFor: 'funcionalidad' stamp: 'Emi 5/10/2024 15:01:24'!
tieneCuenta: unaCuenta
	
	(unaCuenta isKindOf: Portfolio) 
		ifTrue: [unaCuenta obtenerCuentas 
			detect: [:otraCuenta | self tieneCuentaDelPortfolio: otraCuenta ] 
			ifFound: [:cuentaDetectada | 	^true] 
			ifNone: [^false]]
		ifFalse: [^self tieneCuentaDelPortfolio: unaCuenta].! !

!Portfolio methodsFor: 'funcionalidad' stamp: 'Emi 5/10/2024 15:01:05'!
tieneCuentaDelPortfolio: unaCuenta
	
	coleccionDeCuentas
	detect: [:unaCuentaDelPortfolio | 
			(unaCuentaDelPortfolio isKindOf: Portfolio)
			ifTrue: [unaCuentaDelPortfolio tieneCuenta: unaCuenta ]
			ifFalse: [unaCuentaDelPortfolio = unaCuenta]]
		ifFound: [:unaCuentaDelPortfolio | ^true]
		ifNone: [^false].		
	! !

!Portfolio methodsFor: 'funcionalidad' stamp: 'FG 5/3/2024 18:51:53'!
tieneTransaccion: unaTransaccion
	
	coleccionDeCuentas 
		detect: [:unaCuenta | unaCuenta hasRegistered: unaTransaccion] 
		ifFound:[:unaCuenta | ^true] 
		ifNone: [^false].! !

!Portfolio methodsFor: 'funcionalidad' stamp: 'FG 5/3/2024 19:23:26'!
transactions

	| todasLasTransacciones |
	todasLasTransacciones := OrderedCollection new.

	coleccionDeCuentas do: [:unaCuenta | todasLasTransacciones addAllLast: unaCuenta transactions].
	
	 ^todasLasTransacciones 
! !


!Portfolio methodsFor: 'initialization' stamp: 'Emi 5/5/2024 15:19:47'!
initializeConCuentas: unaColeccionDeCuentas 
	coleccionDeCuentas := OrderedCollection newFrom: {}.
	portfolioPadre := nil.
	unaColeccionDeCuentas do: [:unaCuenta | (unaCuenta isKindOf: Portfolio) ifTrue: [ unaCuenta definirPadre: self.].  self agregarCuenta: unaCuenta.].
	"coleccionDeCuentas := unaColeccionDeCuentas."! !


!Portfolio methodsFor: 'public' stamp: 'Emi 5/5/2024 14:51:11'!
definirPadre: unPortfolioPadre
	portfolioPadre := unPortfolioPadre.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'FG 5/3/2024 18:44:09'!
conCuentas: unaColeccionDeCuentas 
	
	^self new initializeConCuentas: unaColeccionDeCuentas.! !


!Portfolio class methodsFor: 'errores' stamp: 'Emi 5/5/2024 15:15:17'!
descripcionErrorAgregarCuentaYaContenida
	^'No se puede agregar una cuenta ya contenida en el portfolio o en un portfolio padre.'! !

!Portfolio class methodsFor: 'errores' stamp: 'FG 5/3/2024 20:31:18'!
descripcionErrorAgregarseASiMismo
	^'No se puede agregar a sí mismo.'! !


!classDefinition: #ReceptiveAccount category: #'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions portfolios portfolioPadre'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'FG 5/3/2024 18:21:32'!
initialize

	transactions := OrderedCollection new.
	portfolios := {}.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'Emi 5/3/2024 12:03:31'!
balance
	"^transactions inject: 0 into: [:balance :unaTransaccion | unaTransaccion agregateAlBalance: balance]"
	^transactions sum: [:unaTransaccion | unaTransaccion valueForBalance] ifEmpty: [0].! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'FG 5/3/2024 18:35:55'!
register: aTransaction

	transactions add: aTransaction.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'public' stamp: 'Emi 5/5/2024 14:51:45'!
definirPadre: unPortfolioPadre
	portfolioPadre := unPortfolioPadre.! !


!classDefinition: #ReporteVisitor category: #'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReporteVisitor
	instanceVariableNames: 'cuenta mensajeReporte'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReporteVisitor methodsFor: 'public' stamp: 'Emi 5/10/2024 12:59:24'!
mostrarReporte
	self subclassResponsibility ! !

!ReporteVisitor methodsFor: 'public' stamp: 'Emi 5/10/2024 14:09:21'!
visitarDeposito: unDeposito
	self subclassResponsibility 
	! !

!ReporteVisitor methodsFor: 'public' stamp: 'Emi 5/10/2024 14:09:12'!
visitarRetiro: unRetiro
	self subclassResponsibility 
	! !

!ReporteVisitor methodsFor: 'public' stamp: 'Emi 5/10/2024 12:42:34'!
visitarTransferenciaParteDeposito: unaParteDeposito
	self subclassResponsibility 
	! !

!ReporteVisitor methodsFor: 'public' stamp: 'Emi 5/10/2024 12:42:27'!
visitarTransferenciaParteRetiro: unaParteRetiro
	self subclassResponsibility 
	! !


!classDefinition: #ReporteVisitorNetoDeTransferencias category: #'ServiciosFinancieros-Ejercicio'!
ReporteVisitor subclass: #ReporteVisitorNetoDeTransferencias
	instanceVariableNames: 'suma'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReporteVisitorNetoDeTransferencias methodsFor: 'public' stamp: 'Emi 5/10/2024 14:05:58'!
mostrarReporte
	| transacciones |
	transacciones := cuenta transactions.
	transacciones do: [:unaTransaccion | (unaTransaccion isKindOf: TransferenciaParte) ifTrue: [unaTransaccion aceptar: self] ].
	^'El balance neto de transferencias es de ', suma asString, ' pesos'.! !

!ReporteVisitorNetoDeTransferencias methodsFor: 'public' stamp: 'Emi 5/10/2024 14:18:38'!
visitarTransferenciaParteDeposito: unaParteDeposito
 	| valor |
	valor := unaParteDeposito valueForBalance amount.
	suma := suma + valor.! !

!ReporteVisitorNetoDeTransferencias methodsFor: 'public' stamp: 'Emi 5/10/2024 14:17:21'!
visitarTransferenciaParteRetiro: unaParteRetiro 
 	| valor |
	valor := unaParteRetiro valueForBalance amount.
	suma := suma + valor.! !


!ReporteVisitorNetoDeTransferencias methodsFor: 'initialize' stamp: 'Emi 5/10/2024 14:02:13'!
initializeCon: unaCuenta
	cuenta := unaCuenta.
	suma := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReporteVisitorNetoDeTransferencias class' category: #'ServiciosFinancieros-Ejercicio'!
ReporteVisitorNetoDeTransferencias class
	instanceVariableNames: ''!

!ReporteVisitorNetoDeTransferencias class methodsFor: 'as yet unclassified' stamp: 'Emi 5/10/2024 14:02:45'!
de: unaCuenta
	^self new initializeCon: unaCuenta.! !


!classDefinition: #ReporteVisitorResumenDeCuenta category: #'ServiciosFinancieros-Ejercicio'!
ReporteVisitor subclass: #ReporteVisitorResumenDeCuenta
	instanceVariableNames: 'lineas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReporteVisitorResumenDeCuenta methodsFor: 'initialize' stamp: 'Emi 5/10/2024 13:09:28'!
initializeCon: unaCuenta
	cuenta := unaCuenta.
	lineas := OrderedCollection new.! !


!ReporteVisitorResumenDeCuenta methodsFor: 'public' stamp: 'Emi 5/10/2024 13:40:33'!
mostrarReporte
	| transacciones |
	transacciones := cuenta transactions.
	transacciones do: [:unaTransaccion | unaTransaccion aceptar: self].
	lineas add: 'Balance = ', cuenta balance amount asString, ' pesos'.
	^Character  cr asString join: lineas.! !

!ReporteVisitorResumenDeCuenta methodsFor: 'public' stamp: 'Emi 5/10/2024 13:11:22'!
visitarDeposito: unDeposito
	| valor linea |
	valor := unDeposito value amount asString. 
	linea := 'Depósito por ', valor, ' pesos'.
	lineas add: linea.
	! !

!ReporteVisitorResumenDeCuenta methodsFor: 'public' stamp: 'Emi 5/10/2024 13:20:08'!
visitarRetiro: unRetiro
	| valor linea |
	valor := unRetiro value amount asString. 
	linea := 'Extracción por ', valor, ' pesos'.
	lineas add: linea.! !

!ReporteVisitorResumenDeCuenta methodsFor: 'public' stamp: 'Emi 5/10/2024 13:46:32'!
visitarTransferenciaParteDeposito: unaParteDeposito
	| valor linea |
	valor := unaParteDeposito valueForBalance amount asString. 
	linea := 'Entrada por transferencia de ', valor, ' pesos'.
	lineas add: linea.! !

!ReporteVisitorResumenDeCuenta methodsFor: 'public' stamp: 'Emi 5/10/2024 13:51:57'!
visitarTransferenciaParteRetiro: unaParteRetiro
	| valor linea |
	valor := unaParteRetiro valueForBalance amount negated asString. 
	linea := 'Salida por transferencia de ', valor, ' pesos'.
	lineas add: linea.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReporteVisitorResumenDeCuenta class' category: #'ServiciosFinancieros-Ejercicio'!
ReporteVisitorResumenDeCuenta class
	instanceVariableNames: ''!

!ReporteVisitorResumenDeCuenta class methodsFor: 'as yet unclassified' stamp: 'Emi 5/10/2024 12:55:10'!
de: unaCuenta
	^self new initializeCon: unaCuenta.! !


!classDefinition: #Transferencia category: #'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transferencia
	instanceVariableNames: 'transactions parteDeposito parteRetiro valor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transferencia methodsFor: 'as yet unclassified' stamp: 'Emi 5/3/2024 15:18:05'!
initializeConValor: unValor desde: unaCuenta hacia: otraCuenta

	valor := unValor.
	parteRetiro := TransferenciaParteRetiro desde: unaCuenta deUnaTransferencia: self. 
	parteDeposito := TransferenciaParteDeposito desde: otraCuenta deUnaTransferencia: self.

! !

!Transferencia methodsFor: 'as yet unclassified' stamp: 'Emi 5/3/2024 14:22:39'!
obtenerParteDeposito
	^ parteDeposito ! !

!Transferencia methodsFor: 'as yet unclassified' stamp: 'Emi 5/3/2024 14:22:50'!
obtenerParteRetiro
	^ parteRetiro ! !

!Transferencia methodsFor: 'as yet unclassified' stamp: 'Emi 5/3/2024 14:18:30'!
valor
	^valor! !

!Transferencia methodsFor: 'as yet unclassified' stamp: 'Emi 5/3/2024 15:14:49'!
valorDeDeposito
	^valor! !

!Transferencia methodsFor: 'as yet unclassified' stamp: 'Emi 5/3/2024 15:15:09'!
valorDeRetiro
	^valor negated.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transferencia class' category: #'ServiciosFinancieros-Ejercicio'!
Transferencia class
	instanceVariableNames: ''!

!Transferencia class methodsFor: 'as yet unclassified' stamp: 'Emi 5/3/2024 15:33:13'!
descripcionDeErrorTransferirmeAMiMismo
	^'Las cuentas origen y destino deben ser distintas'! !

!Transferencia class methodsFor: 'as yet unclassified' stamp: 'Emi 5/3/2024 15:36:46'!
descripcionDeErrorValorMayorACero

	^'El valor a transferir debe ser mayor a 0'! !

!Transferencia class methodsFor: 'as yet unclassified' stamp: 'Emi 5/3/2024 15:37:19'!
porValor: unValor desde: unaCuenta hacia: otraCuenta
	unaCuenta == otraCuenta ifTrue: [self error: self descripcionDeErrorTransferirmeAMiMismo].
	unValor <= 0 ifTrue: [self error: self descripcionDeErrorValorMayorACero].
	^Transferencia new initializeConValor: unValor desde: unaCuenta hacia: otraCuenta.! !

!Transferencia class methodsFor: 'as yet unclassified' stamp: 'Emi 5/3/2024 15:28:00'!
register: unValor desde: unaCuenta hacia: otraCuenta
	| transferencia |
	transferencia := Transferencia porValor: unValor  desde: unaCuenta  hacia: otraCuenta.

	unaCuenta register: (transferencia obtenerParteRetiro).
	otraCuenta register: (transferencia obtenerParteDeposito).
	
	^transferencia ! !


!classDefinition: #TransferenciaParte category: #'ServiciosFinancieros-Ejercicio'!
Object subclass: #TransferenciaParte
	instanceVariableNames: 'transactions transferencia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenciaParte methodsFor: 'as yet unclassified' stamp: 'Emi 5/10/2024 13:21:51'!
aceptar: unReporte
	self subclassResponsibility ! !

!TransferenciaParte methodsFor: 'as yet unclassified' stamp: 'Emi 5/3/2024 14:24:20'!
obtenerContraparte
	self subclassResponsibility ! !


!classDefinition: #TransferenciaParteDeposito category: #'ServiciosFinancieros-Ejercicio'!
TransferenciaParte subclass: #TransferenciaParteDeposito
	instanceVariableNames: 'cuenta'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenciaParteDeposito methodsFor: 'as yet unclassified' stamp: 'Emi 5/10/2024 13:22:13'!
aceptar: unReporte
	unReporte visitarTransferenciaParteDeposito: self.! !

!TransferenciaParteDeposito methodsFor: 'as yet unclassified' stamp: 'Emi 5/3/2024 13:37:14'!
initializeDesde: unaCuenta deUnaTransferencia: unaTransferencia
	transferencia := unaTransferencia.
	cuenta := unaCuenta.! !

!TransferenciaParteDeposito methodsFor: 'as yet unclassified' stamp: 'Emi 5/3/2024 14:23:52'!
obtenerContraparte
	^transferencia obtenerParteRetiro ! !

!TransferenciaParteDeposito methodsFor: 'as yet unclassified' stamp: 'Emi 5/3/2024 15:14:04'!
valueForBalance
	^transferencia valorDeDeposito.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenciaParteDeposito class' category: #'ServiciosFinancieros-Ejercicio'!
TransferenciaParteDeposito class
	instanceVariableNames: ''!

!TransferenciaParteDeposito class methodsFor: 'as yet unclassified' stamp: 'Emi 5/3/2024 13:35:42'!
desde: unaCuenta deUnaTransferencia: unaTransferencia
	^TransferenciaParteDeposito new initializeDesde: unaCuenta deUnaTransferencia: unaTransferencia
	! !


!classDefinition: #TransferenciaParteRetiro category: #'ServiciosFinancieros-Ejercicio'!
TransferenciaParte subclass: #TransferenciaParteRetiro
	instanceVariableNames: 'cuenta'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenciaParteRetiro methodsFor: 'as yet unclassified' stamp: 'Emi 5/10/2024 13:47:51'!
aceptar: unReporte
	unReporte visitarTransferenciaParteRetiro: self.! !

!TransferenciaParteRetiro methodsFor: 'as yet unclassified' stamp: 'Emi 5/3/2024 13:38:19'!
initializeDesde: unaCuenta deUnaTransferencia: unaTransferencia
	transferencia := unaTransferencia.
	cuenta := unaCuenta.! !

!TransferenciaParteRetiro methodsFor: 'as yet unclassified' stamp: 'Emi 5/3/2024 14:29:27'!
obtenerContraparte
	^transferencia obtenerParteDeposito ! !

!TransferenciaParteRetiro methodsFor: 'as yet unclassified' stamp: 'Emi 5/3/2024 15:13:47'!
valueForBalance
	^transferencia valorDeRetiro.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenciaParteRetiro class' category: #'ServiciosFinancieros-Ejercicio'!
TransferenciaParteRetiro class
	instanceVariableNames: ''!

!TransferenciaParteRetiro class methodsFor: 'as yet unclassified' stamp: 'Emi 5/3/2024 13:37:55'!
desde: unaCuenta deUnaTransferencia: unaTransferencia
	^TransferenciaParteRetiro new initializeDesde: unaCuenta deUnaTransferencia: unaTransferencia
! !
