from datetime import timedelta, datetime
from typing import Tuple

class RegistroDeActividad:
    def __init__(self, timeout: timedelta):
        self.sesiones = {}
        self.timeout = timeout

    def actualizar_ultimo_acceso(self, sesion_id):
        self.sesiones[sesion_id] = datetime.now()

    def esta_expirada(self, sesion_id):
        ultimo_acceso = self.sesiones.get(sesion_id, None)
        if not ultimo_acceso: return False 

        ahora = datetime.now()

        return (ahora - ultimo_acceso) >= self.timeout

    @classmethod
    def descripcion_de_error_timeout_invalido(cls) -> str:
        return "El timeout tiene un formato invalido"
