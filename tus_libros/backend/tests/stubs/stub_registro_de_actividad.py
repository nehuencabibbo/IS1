from datetime import timedelta, datetime
from typing import Callable, Tuple

class StubRegistroDeActividad:
    def __init__(self, timeout: timedelta):
        self.sesiones = {} # id: ultimo accesso
        self.timeout = timeout
        self.esta_expirada_closure = None
        self.ahora = None

    def actualizar_ultimo_acceso(self, sesion_id): 
        self.sesiones[sesion_id] = datetime.now()

    def esta_expirada(self, sesion_id):
        if not self.esta_expirada_closure:
            ultimo_acceso = self.sesiones.get(sesion_id, None)
            if not ultimo_acceso:
                raise RuntimeError("No se encontro la sesion")

            return (self.ahora - ultimo_acceso) >= self.timeout
        
        return self.esta_expirada_closure(sesion_id)
    
    def set_esta_expirada(self, esta_expirada_closure: Callable):
        self.esta_expirada_closure = esta_expirada_closure

    def settear_inicio_de_sesion_para(self, sesion_id, inicio: datetime):
        self.sesiones[sesion_id] = inicio

    def avanzar_para(self, sesion_id, avance: timedelta):
        self.sesiones[sesion_id] += avance

    def set_ahora(self, ahora: datetime):
        self.ahora = ahora

    def le_quedan_una_cantidad_de_minutos_a(self, sesion_id, una_cantidad_de_minutos):
        ultimo_acceso = self.sesiones.get(sesion_id, None)
        ahora = datetime.now()

        diferencia_en_segundos = (ahora - ultimo_acceso).total_seconds()
        minutos_transcurridos = round(diferencia_en_segundos / 60)

        timeout_en_minutos = int(self.timeout.total_seconds() / 60)

        return timeout_en_minutos - minutos_transcurridos == una_cantidad_de_minutos