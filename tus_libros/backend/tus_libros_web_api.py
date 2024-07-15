import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from typing import *
from dominio.carrito import Carrito
from dominio.tarjeta_de_credito import TarjetaDeCredito
from dominio.cajero import Cajero

from dominio.ticket import Ticket
from registro_de_actividad import RegistroDeActividad

from utils import obtener_nueva_id, parsear_catalogo_por_isbn_y_precio
from dominio.libro_de_ventas import LibroDeVentas


class TusLibrosWebAPI:
    def __init__(self, catalogo: Set[str], autenticador, procesador_de_pagos, precios, registro_de_actividad):

        self.carritos = {}  # CartId: Carrito
        self.catalogo: Set[str] = catalogo
        self.libro_de_ventas = LibroDeVentas()
        self.carritos_por_cliente = {}  # client_id: set(cart_id, ..., ...)

        self.autenticador = autenticador
        self.procesador_de_pagos = procesador_de_pagos
        self.registro_de_actividad: RegistroDeActividad = registro_de_actividad

        self.precios = precios
        self.time_out_en_minutos = 10

    def verificar_book_quantity_valido(self, book_quantity):
        if book_quantity <= 0:
            raise RuntimeError(Carrito.descripcion_de_error_book_quantity_invalido())

    def verificar_que_existe_el_carrito(self, cart_id, carrito):
        if not carrito:
            raise RuntimeError(Carrito.descripcion_de_error_carrito_no_existe())

    def verificar_si_expiro_la_sesion(self, sesion_id):
        if self.registro_de_actividad.esta_expirada(sesion_id):
            raise RuntimeError(TusLibrosWebAPI.descripcion_error_sesion_expirada())

    def agregar_carrito_segun_cliente(self, client_id: str, cart_id):
        if not client_id in self.carritos_por_cliente:
            self.carritos_por_cliente[client_id] = set([cart_id])
        else:
            self.carritos_por_cliente[client_id].add(cart_id)

    def agregar_venta(self, cart_id, ticket: Ticket):
        for client_id, carritos_por_id in self.carritos_por_cliente.items():
            if cart_id in carritos_por_id:
                self.libro_de_ventas.agregar_venta(client_id, ticket)

    def create_cart(self, client_id: str, password: str) -> str:
        carrito: Carrito = Carrito(self.catalogo)

        self.autenticador.authenticate(client_id, password)

        cart_id = obtener_nueva_id()
        self.carritos[cart_id] = carrito
        self.registro_de_actividad.actualizar_ultimo_acceso(cart_id)
        self.agregar_carrito_segun_cliente(client_id, cart_id)

        return cart_id

    def list_cart(self, cart_id: str) -> Dict[str, int]:
        carrito = self.carritos.get(cart_id, None)

        self.verificar_que_existe_el_carrito(cart_id, carrito)
        self.verificar_si_expiro_la_sesion(cart_id)

        compras = carrito.listar()

        self.registro_de_actividad.actualizar_ultimo_acceso(cart_id)

        return compras

    def add_to_cart(self, cart_id: str, book_isbn: str, book_quantity: int):
        carrito = self.carritos.get(cart_id, None)

        self.verificar_que_existe_el_carrito(cart_id, carrito)
        self.verificar_si_expiro_la_sesion(cart_id)
        self.verificar_book_quantity_valido(book_quantity)

        self.registro_de_actividad.actualizar_ultimo_acceso(cart_id)

        carrito.agregar(book_isbn, book_quantity)

    def check_out_cart(self, cart_id: str, ccn: int, month: int, year: int, cco: str):
        carrito = self.carritos.get(cart_id, None)

        self.verificar_que_existe_el_carrito(cart_id, carrito)
        self.verificar_si_expiro_la_sesion(cart_id)

        tarjeta = TarjetaDeCredito.crear_tarjeta_con(month, year, ccn, cco)
        cajero = Cajero(self.precios, self.procesador_de_pagos)
        ticket: Ticket = cajero.cobrar(carrito, tarjeta)

        self.agregar_venta(cart_id, ticket)

        # Si yo creo un carrito en el front, no pago ni nada, creo otro y pago, al volver a 
        # la pagina listar esta roto porque el front pide el id del ultimo carrito que haya,
        # si borro el carrito, que es lo mas logico, el boton se muestra mal y se lanza un error
        # de que el carrito de id (id del carrito borrado) no existe
        # Asi que en vez de borrarlo, lo vacio e inicio el cronometro denuevo
        # Para arreglar esto del todo, habria que loggearse, antes de poder hacer una compra, y para cada usuario
        # se podria tener un unico carrito y listo, pero no se corresponde con el tp 
        carrito.vaciar()
        self.registro_de_actividad.actualizar_ultimo_acceso(cart_id)

        return ticket.transaction_id()

    def list_purchases(self, client_id: str, password: str):
        self.autenticador.authenticate(client_id, password)

        todas_las_compras, total = self.libro_de_ventas.calcular_informacion_de_compras_del_cliente(client_id)

        return todas_las_compras, total

    @classmethod
    def descripcion_error_sesion_expirada(cls):
        return 'La sesion ha expirado'
