import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import unittest

from stubs.stub_registro_de_actividad import StubRegistroDeActividad
from registro_de_actividad import RegistroDeActividad
from stubs.stub_autenticador import StubAutenticador
from typing import *
from tus_libros_web_api import TusLibrosWebAPI
from dominio.carrito import Carrito
from utils import parsear_catalogo_por_isbn, parsear_catalogo_por_isbn_y_precio
from dominio.cajero import Cajero
from stubs.stub_procesador_de_pagos import StubProcesadorDePagos
from datetime import datetime, timedelta


class TusLibrosWebAPITests(unittest.TestCase):
    def setUp(self):
        catalogo: Set[str] = set(parsear_catalogo_por_isbn("../catalogos/catalogo_test.json"))
        precios = parsear_catalogo_por_isbn_y_precio("../catalogos/catalogo_test.json")
        self.procesador_de_pagos = StubProcesadorDePagos()
        self.autenticador = StubAutenticador()

        self.timeout_en_minutos = 10
        timeout = timedelta(minutes=self.timeout_en_minutos)
        registro_de_actividad = RegistroDeActividad(timeout)
        self.tus_libros_web_api = TusLibrosWebAPI(catalogo, self.autenticador, self.procesador_de_pagos, precios,
                                        registro_de_actividad)

        self.stub_registro_de_actividad = StubRegistroDeActividad(timeout)
        self.tus_libros_web_api_con_registro_stub = TusLibrosWebAPI(catalogo, self.autenticador, self.procesador_de_pagos,
                                                          precios, self.stub_registro_de_actividad)

        self.cart_id = self.tus_libros_web_api.create_cart("", "")

        self.nro_de_tarjeta_valido = "1111111111111112"
        fecha_actual = datetime.now()
        self.mes_de_expiracion_valido = fecha_actual.month + 1
        self.año_de_expiracion_valido = fecha_actual.year + 1
        self.nombre = "Marten"

    def test01_un_carrito_recien_creado_esta_vacio(self):
        carrito = self.tus_libros_web_api.list_cart(self.cart_id)
        self.assertTrue(len(carrito) == 0)

    def test02_puedo_agregar_un_libro_al_carrito(self):
        self.tus_libros_web_api.add_to_cart(self.cart_id, "0", 1)

        carrito = self.tus_libros_web_api.list_cart(self.cart_id)

        self.assertTrue(len(carrito) == 1)
        self.assertTrue(carrito.get("0", None) == 1)

    def test03_puedo_agregar_libros_distintos_al_carrito(self):
        self.tus_libros_web_api.add_to_cart(self.cart_id, "0", 1)
        self.tus_libros_web_api.add_to_cart(self.cart_id, "1", 1)

        carrito = self.tus_libros_web_api.list_cart(self.cart_id)

        self.assertTrue(len(carrito) == 2)
        self.assertTrue(carrito.get("0", None) == 1)
        self.assertTrue(carrito.get("1", None) == 1)

    def test04_al_intentar_listar_un_carrito_sin_crearlo_devuelve_el_error_del_backend(self):
        cart_id = "0"
        with self.assertRaises(RuntimeError) as exception_carrito:
            self.tus_libros_web_api.list_cart(cart_id)
            self.fail("No deberia poder listar un carrito que no esta creado")

        self.assertEqual(str(Carrito.descripcion_de_error_carrito_no_existe()), str(exception_carrito.exception))

    def test05_no_puedo_agregar_un_libro_que_no_esta_en_el_catalogo(self):
        with self.assertRaises(RuntimeError) as exception_carrito:
            self.tus_libros_web_api.add_to_cart(self.cart_id, "2", 1)
            self.fail("No deberia poder agregar un libro que no esta en el catalogo")

        self.assertEqual(str(Carrito.descripcion_libro_no_esta_en_catalogo()), str(exception_carrito.exception))

    def test06_carritos_diferentes_pueden_tener_libros_diferentes(self):
        cart_id2 = self.tus_libros_web_api.create_cart("", "")

        self.tus_libros_web_api.add_to_cart(cart_id2, "1", 1)

        carrito1 = self.tus_libros_web_api.list_cart(self.cart_id)
        carrito2 = self.tus_libros_web_api.list_cart(cart_id2)

        self.assertTrue(len(carrito1) == 0)
        self.assertTrue(len(carrito2) == 1)
        self.assertTrue(carrito2.get("1", None) == 1)

    def test07_puedo_agregar_multiples_veces_el_mismo_libro_al_carrito(self):
        self.tus_libros_web_api.add_to_cart(self.cart_id, "0", 2)

        carrito = self.tus_libros_web_api.list_cart(self.cart_id)

        self.assertEqual(carrito.get("0"), 2)

    def test08_no_se_puede_hacer_check_out_a_un_carrito_vacio(self):
        with self.assertRaises(RuntimeError) as exception_cajero:
            self.tus_libros_web_api.check_out_cart(self.cart_id, self.nro_de_tarjeta_valido, self.mes_de_expiracion_valido,
                                             self.año_de_expiracion_valido, self.nombre)
            self.fail("No deberia poderle hacer check out a un carrito vacio")

        self.assertEqual(Cajero.descripcion_no_se_puede_cobrar_un_carrito_vacio(), str(exception_cajero.exception))

    def test09_se_puede_hacer_checkout_a_un_carrito_con_libros(self):
        self.tus_libros_web_api.add_to_cart(self.cart_id, "0", 1)
        procesador_de_pagos = StubProcesadorDePagos()

        def pasa(numero_de_tarjeta_que_pasa):
            def debit(amount_to_debit, credit_card):
                if numero_de_tarjeta_que_pasa != credit_card.number():
                    raise RuntimeError("Tarjeta Robada")

            return debit

        procesador_de_pagos.set_debit(pasa(self.nro_de_tarjeta_valido))

        transaction_id = self.tus_libros_web_api.check_out_cart(
            self.cart_id,
            self.nro_de_tarjeta_valido,
            self.mes_de_expiracion_valido,
            self.año_de_expiracion_valido,
            self.nombre)

        self.assertTrue(len(transaction_id) > 0)

    def test10_no_se_puede_listar_con_una_sesion_expirada(self):
        def todo_expirado(sesion_id):
            return True

        cart_id = self.tus_libros_web_api_con_registro_stub.create_cart("", "")
        self.stub_registro_de_actividad.set_esta_expirada(todo_expirado)

        with self.assertRaises(RuntimeError) as excepcion:
            self.tus_libros_web_api_con_registro_stub.list_cart(cart_id)
            self.fail("No deberia poder listar un carrito con una sesion expirada")

        self.assertEqual(str(TusLibrosWebAPI.descripcion_error_sesion_expirada()), str(excepcion.exception))

    def test11_no_se_puede_agregar_a_un_carrito_con_una_sesion_expirada(self):
        def todo_expirado(sesion_id):
            return True

        cart_id = self.tus_libros_web_api_con_registro_stub.create_cart("", "")
        self.stub_registro_de_actividad.set_esta_expirada(todo_expirado)

        with self.assertRaises(RuntimeError) as excepcion:
            self.tus_libros_web_api_con_registro_stub.add_to_cart(cart_id, "1", 1)
            self.fail("No deberia poder agregar libros a un carrito con una sesion expirada")

        self.assertEqual(str(TusLibrosWebAPI.descripcion_error_sesion_expirada()), str(excepcion.exception))

    def test12_no_se_puede_hacer_check_out_a_un_carrito_con_la_sesion_expirada(self):
        def todo_expirado(sesion_id):
            return True

        def nada_expirado(sesion_id):
            return False

        cart_id = self.tus_libros_web_api_con_registro_stub.create_cart("", "")

        self.stub_registro_de_actividad.set_esta_expirada(nada_expirado)
        self.tus_libros_web_api_con_registro_stub.add_to_cart(cart_id, "1", 1)
        self.stub_registro_de_actividad.set_esta_expirada(todo_expirado)

        with self.assertRaises(RuntimeError) as excepcion:
            self.tus_libros_web_api_con_registro_stub.check_out_cart(cart_id, self.nro_de_tarjeta_valido,
                                                               self.mes_de_expiracion_valido,
                                                               self.año_de_expiracion_valido, self.nombre)
            self.fail("No deberia poder hacer check out a un carrito con una sesion expirada")

        self.assertEqual(str(TusLibrosWebAPI.descripcion_error_sesion_expirada()), str(excepcion.exception))

    # TODO: Este test esta bien? --> Si!
    def test13_listar_un_carrito_no_expirado_resetea_el_tiempo_de_sesion(self):
        cart_id = self.tus_libros_web_api_con_registro_stub.create_cart("", "")

        self.stub_registro_de_actividad.set_ahora(datetime.now() + timedelta(minutes=5))
        self.tus_libros_web_api_con_registro_stub.list_cart(cart_id)

        se_reseteo_el_tiempo_de_expiracion = self.stub_registro_de_actividad.le_quedan_una_cantidad_de_minutos_a(
            cart_id, self.timeout_en_minutos)

        self.assertTrue(se_reseteo_el_tiempo_de_expiracion)

    def test14_agregar_a_un_carrito_no_expirado_resetea_el_tiempo_de_sesion(self):
        cart_id = self.tus_libros_web_api_con_registro_stub.create_cart("", "")

        self.stub_registro_de_actividad.set_ahora(datetime.now() + timedelta(minutes=5))
        self.tus_libros_web_api_con_registro_stub.add_to_cart(cart_id, "1", 1)

        se_reseteo_el_tiempo_de_expiracion = self.stub_registro_de_actividad.le_quedan_una_cantidad_de_minutos_a(
            cart_id, self.timeout_en_minutos)

        self.assertTrue(se_reseteo_el_tiempo_de_expiracion)

    def test15_hacer_check_out_a_un_carrito_no_expirado_resetea_el_tiempo_de_sesion(self):
        cart_id = self.tus_libros_web_api_con_registro_stub.create_cart("", "")

        self.stub_registro_de_actividad.set_ahora(datetime.now() + timedelta(minutes=5))
        self.tus_libros_web_api_con_registro_stub.add_to_cart(cart_id, "1", 1)
        self.tus_libros_web_api_con_registro_stub.check_out_cart(cart_id, self.nro_de_tarjeta_valido,
                                                           self.mes_de_expiracion_valido, self.año_de_expiracion_valido,
                                                           self.nombre)

        se_reseteo_el_tiempo_de_expiracion = self.stub_registro_de_actividad.le_quedan_una_cantidad_de_minutos_a(
            cart_id, self.timeout_en_minutos)

        self.assertTrue(se_reseteo_el_tiempo_de_expiracion)

    def test16_si_no_compro_nada_listar_compras_no_devuelve_nada(self):
        def authenticate(usuario, contra):
            return True

        self.autenticador.set_authenticator(authenticate)

        compras, total = self.tus_libros_web_api.list_purchases("", "")

        self.assertEqual(len(compras), 0)
        self.assertEqual(total, 0)

    def test17_si_hice_dos_compras_puedo_verlas_al_listarlas(self):
        def authenticate(usuario, contra):
            return True

        self.autenticador.set_authenticator(authenticate)

        cart_id = self.tus_libros_web_api.create_cart("pepe", "amongus")
        self.tus_libros_web_api.add_to_cart(cart_id, "0", 1)
        self.tus_libros_web_api.add_to_cart(cart_id, "1", 1)
        self.tus_libros_web_api.check_out_cart(
            cart_id,
            self.nro_de_tarjeta_valido,
            self.mes_de_expiracion_valido,
            self.año_de_expiracion_valido,
            self.nombre)

        compras, total = self.tus_libros_web_api.list_purchases("pepe", "amongus")

        self.assertEqual(total, 300)

        self.assertEqual(compras.get("0", None), 1)
        self.assertEqual(compras.get("1", None), 1)

    def test18_si_expira_la_sesion_no_afecta_a_listar_las_compras(self):
        def authenticate(usuario, contra):
            return True

        def nada_expirado(sesion_id):
            return False

        self.autenticador.set_authenticator(authenticate)
        self.stub_registro_de_actividad.set_esta_expirada(nada_expirado)

        cart_id = self.tus_libros_web_api_con_registro_stub.create_cart("pepe", "amongus")
        self.tus_libros_web_api_con_registro_stub.add_to_cart(cart_id, "0", 1)
        self.tus_libros_web_api_con_registro_stub.add_to_cart(cart_id, "1", 1)
        self.tus_libros_web_api_con_registro_stub.check_out_cart(
            cart_id,
            self.nro_de_tarjeta_valido,
            self.mes_de_expiracion_valido,
            self.año_de_expiracion_valido,
            self.nombre)

        def todo_expirado(sesion_id):
            return True

        self.stub_registro_de_actividad.set_esta_expirada(todo_expirado)

        compras, total = self.tus_libros_web_api_con_registro_stub.list_purchases("pepe", "amongus")

        self.assertEqual(total, 300)

        self.assertEqual(compras.get("0", None), 1)
        self.assertEqual(compras.get("1", None), 1)

    def test19_no_puedo_listar_las_compras_de_un_usuario_que_no_existe(self):
        def no_pasa(usuario_que_no_pasa, contra_que_no_pasa):
            def authenticate(usuario, contra):
                if usuario_que_no_pasa == usuario:
                    raise RuntimeError("Invalid credentials")

            return authenticate

        usuario = "pepe"
        contra = "amongus"
        self.autenticador.set_authenticator(no_pasa(usuario, contra))

        with self.assertRaises(RuntimeError) as excepcion:
            self.tus_libros_web_api.list_purchases(usuario, contra)
            self.fail("No deberia poder listar las compras de un usuario que no existe")

        self.assertEqual("Invalid credentials", str(excepcion.exception))

if __name__ == '__main__':
    unittest.main()
