class TarjetaDeCredito:
    def __init__(self, mes_de_vencimiento: int, año_de_vencimiento: int, numero: int, nombre: str):
        self.mes_de_vencimiento = mes_de_vencimiento
        self.año_de_vencimiento = año_de_vencimiento
        self.numero = numero
        self.nombre = nombre

    @classmethod
    def crear_tarjeta_con(cls, mes_de_vencimiento: int, año_de_vencimiento: int, numero: int, nombre: str):
        if (año_de_vencimiento < 1900
                or mes_de_vencimiento < 1
                or mes_de_vencimiento > 12
                or len(str(numero)) != 16
                or len(nombre) == 0):
            raise RuntimeError(TarjetaDeCredito.descripcion_de_error_tarjeta_invalida())

        tarjeta = cls(mes_de_vencimiento, año_de_vencimiento, numero, nombre)

        return tarjeta

    def number(self): 
        return self.numero

    def esta_vencida(self, mes_actual: int, año_actual: int):
        if año_actual != self.año_de_vencimiento:
            return año_actual > self.año_de_vencimiento
        
        return mes_actual > self.mes_de_vencimiento

    @classmethod
    def descripcion_de_error_tarjeta_invalida(cls):
        return "La tarjeta de credito es invalida"
