from dominio.ticket import Ticket
from dominio.carrito import Carrito
from dominio.tarjeta_de_credito import TarjetaDeCredito

from datetime import datetime

from typing import *

class Cajero:
    def __init__(self, precios, procesador_de_pagos):
        self.procesador_de_pagos = procesador_de_pagos
        self.precios = precios

    def obtener_total_a_pagar(self, compras):
        total = 0
        for isbn, cantidad in compras.items():
            total += self.precios[isbn] * cantidad

        return total

    def obtener_resumen_de_compra(self, compras) -> Dict[str, Dict[str, int]]:
        resumen_de_compra = {}
        for isbn, cantidad in compras.items():
            resumen_de_compra[isbn] = {}
            resumen_de_compra[isbn]["cantidad"] = cantidad
            resumen_de_compra[isbn]["precio total"] = cantidad * self.precios[isbn]  

        return resumen_de_compra

    
    def cobrar(self, carrito: Carrito, tarjeta_de_credito: TarjetaDeCredito):
        if carrito.tiene_una_cantidad_de_libros(0):
            raise RuntimeError(Cajero.descripcion_no_se_puede_cobrar_un_carrito_vacio())
        
        if tarjeta_de_credito.esta_vencida(datetime.now().month, datetime.now().year):
            raise RuntimeError(Cajero.descripcion_no_se_puede_cobrar_a_una_tarjeta_vencida())
        
        compras = carrito.listar()

        total = self.obtener_total_a_pagar(compras)

        # Puede fallar
        self.procesador_de_pagos.debit(total, tarjeta_de_credito)
        
        resumen_de_compra = self.obtener_resumen_de_compra(compras)

        return Ticket(resumen_de_compra, total) 


    @classmethod
    def descripcion_no_se_puede_cobrar_un_carrito_vacio(cls):
        return "No se puede cobrar un carrito vacio"
    
    
    @classmethod
    def descripcion_no_se_puede_cobrar_a_una_tarjeta_vencida(cls):
        return "No se puede cobrar a una tarjeta de credito vencida"
