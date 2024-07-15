import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import unittest

from typing import *

from stubs.stub_autenticador import StubAutenticador
from stubs.stub_procesador_de_pagos import StubProcesadorDePagos
from dominio.carrito import Carrito
from parser_http import ParserHTTP
from tus_libros_web_api import TusLibrosWebAPI
from utils import parsear_catalogo_por_isbn, parsear_catalogo_por_isbn_y_precio
from datetime import datetime
from dominio.cajero import Cajero
from dominio.tarjeta_de_credito import TarjetaDeCredito

from datetime import datetime, timedelta
from registro_de_actividad import RegistroDeActividad
from stubs.stub_registro_de_actividad import StubRegistroDeActividad


class ParserHTTPTests(unittest.TestCase):
    def setUp(self):
        catalogo = parsear_catalogo_por_isbn("../catalogos/catalogo_test.json")
        precios = parsear_catalogo_por_isbn_y_precio("../catalogos/catalogo_test.json")
        self.autenticador = StubAutenticador()
        self.procesador_de_pagos = StubProcesadorDePagos()

        timeout = timedelta(minutes=10)
        registro_de_actividad = RegistroDeActividad(timeout)
        tus_libros_web_api = TusLibrosWebAPI(catalogo, self.autenticador, self.procesador_de_pagos, precios,
                                   registro_de_actividad)
        self.parser_http = ParserHTTP(tus_libros_web_api)

        self.stub_registro_de_actividad = StubRegistroDeActividad(timeout)
        tus_libros_web_api_con_stub = TusLibrosWebAPI(catalogo, self.autenticador, self.procesador_de_pagos, precios,
                                            self.stub_registro_de_actividad)
        self.parser_http_con_stub = ParserHTTP(tus_libros_web_api_con_stub)

        self.usuario_valido = "yenny"
        self.contraseña_valida = "elAteneo2003"

    def fallar_ante_response_invalido(self, response):
        if not response or not response["statusCode"] or not response["body"]:
            self.fail(f"Response no valida: {response}")

    # Si el response body no tiene el formato esperado, se devuelve una tupla
    # con strings vacios
    def separar_response(self, response: Dict[str, str]) -> Tuple[str, str]:
        response_body_separado = response["body"].split("|")

        if len(response_body_separado) < 2:
            return "", ""

        caso_de_error = response_body_separado[0]
        respuesta = response_body_separado[1:]

        return caso_de_error, "|".join(respuesta)

    def crear_un_carrito(self, client_id: str, password: str, parser_http) -> Dict[str, str]:
        request = {"clientId": client_id, "password": password}
        response = parser_http.create_cart(request)

        return response

    def agregar_a_un_carrito(self, cart_id: str, book_isbn: str, book_quantity: str, parser_http) -> Dict[str, str]:
        request = {"cartId": cart_id, "bookIsbn": book_isbn, "bookQuantity": book_quantity}
        response = parser_http.add_to_cart(request)

        return response

    def listar_un_carrito(self, cart_id: str, parser_http) -> Dict[str, str]:
        request = {"cartId": cart_id}
        response = parser_http.list_cart(request)

        return response
    
    def listar_las_compras_de_un_cliente(self, client_id: str, password: str, parser_http: ParserHTTP) -> Dict[str, str]:
        request = {"clientId": client_id, "password": password}
        response = parser_http.list_purchases(request)

        return response

    def crear_request_checkout_sin_elementos(self, mes, año, ccn, parser_http):
        response = self.crear_un_carrito(self.usuario_valido, self.contraseña_valida, parser_http)

        mes = str(mes)
        if len(mes) == 1:
            mes = "0" + mes

        cart_id: str = response["body"].split("|")[1]
        cced = mes + str(año)
        cco = "Marten"

        return {"cartId": cart_id, "ccn": ccn, "cced": cced, "cco": cco}
    
    def hacerle_checkout_a_un_carrito(self, cart_id, mes, año, ccn, cco, parser_http: ParserHTTP):
        mes = str(mes)
        if len(mes) == 1:
            mes = "0" + mes

        cced = mes + str(año)
        cco = cco

        request = {"cartId": cart_id, "ccn": ccn, "cced": cced, "cco": cco}

        response = parser_http.check_out_cart(request)

        return response

    def crear_request_checkout_con_elementos(self, mes, año, ccn, parser_http):
        response = self.crear_un_carrito(self.usuario_valido, self.contraseña_valida, parser_http)

        mes = str(mes)
        if len(mes) == 1:
            mes = "0" + mes

        cart_id: str = response["body"].split("|")[1]
        self.agregar_a_un_carrito(cart_id, "0", "1", parser_http)
        cced = mes + str(año)
        cco = "Marten"

        return {"cartId": cart_id, "ccn": ccn, "cced": cced, "cco": cco}

    def assert_que_el_response_tiene(self, response, status_code, caso, descripcion):
        self.fallar_ante_response_invalido(response)

        caso_de_error, descripcion_de_error = self.separar_response(response)

        if (caso_de_error, descripcion_de_error) == ("", ""):
            self.fail("El body esta vacio o no tiene el formato esperado")

        self.assertEqual(response["statusCode"], status_code)
        self.assertEqual(caso_de_error, caso)
        self.assertEqual(descripcion_de_error, descripcion)

    def test01_puedo_crear_un_carrito(self):
        response = self.crear_un_carrito(self.usuario_valido, self.contraseña_valida, self.parser_http)

        self.fallar_ante_response_invalido(response)

        response_body_separado = response["body"].split("|")

        self.assertEqual(response["statusCode"], "200")
        self.assertTrue(len(response_body_separado) == 2)

    def test02_no_puedo_agregar_libros_a_un_carrito_no_existente(self):
        response = self.agregar_a_un_carrito("0", "1", "1", self.parser_http)

        self.assert_que_el_response_tiene(response, "400", "1", Carrito.descripcion_de_error_carrito_no_existe())

    def test03_puedo_agregar_libros_a_un_carrito(self):
        response = self.crear_un_carrito(self.usuario_valido, self.contraseña_valida, self.parser_http)

        cart_id = response["body"].split("|")[1]

        response = self.agregar_a_un_carrito(str(cart_id), "1", "1", self.parser_http)

        self.assert_que_el_response_tiene(response, "200", "0", "OK")

    def test04_no_puedo_listar_un_carrito_inexistente(self):
        response = self.listar_un_carrito("0", self.parser_http)

        self.assert_que_el_response_tiene(response, "400", "1", Carrito.descripcion_de_error_carrito_no_existe())

    def test05_listar_un_carrito_vacio_no_lista_nada(self):
        response = self.crear_un_carrito(self.usuario_valido, self.contraseña_valida, self.parser_http)

        cart_id: str = response["body"].split("|")[1]

        response = self.listar_un_carrito(cart_id, self.parser_http)

        self.assert_que_el_response_tiene(response, "200", "0", "OK")

    def test06_listar_un_carrito_con_elementos_lista_todos_los_elementos(self):
        response = self.crear_un_carrito(self.usuario_valido, self.contraseña_valida, self.parser_http)

        cart_id: str = response["body"].split("|")[1]

        self.agregar_a_un_carrito(cart_id, "0", "1", self.parser_http)
        self.agregar_a_un_carrito(cart_id, "1", "1", self.parser_http)

        response = self.listar_un_carrito(cart_id, self.parser_http)

        self.assert_que_el_response_tiene(response, "200", "0", "0|1|1|1")

    def test07_no_se_puede_agregar_menos_de_un_libro(self):
        response = self.crear_un_carrito(self.usuario_valido, self.contraseña_valida, self.parser_http)

        cart_id: str = response["body"].split("|")[1]

        response = self.agregar_a_un_carrito(cart_id, "0", "0", self.parser_http)

        self.assert_que_el_response_tiene(response, "400", "1", Carrito.descripcion_de_error_book_quantity_invalido())

    def test08_puedo_agregar_multiples_veces_un_mismo_libro_al_carrito(self):
        response = self.crear_un_carrito(self.usuario_valido, self.contraseña_valida, self.parser_http)

        cart_id: str = response["body"].split("|")[1]

        self.agregar_a_un_carrito(cart_id, "0", "2", self.parser_http)

        response = self.listar_un_carrito(cart_id, self.parser_http)

        self.assert_que_el_response_tiene(response, "200", "0", "0|2")

    def test09_al_recibir_una_cantidad_de_libros_no_numerica_muestra_un_error(self):
        response = self.crear_un_carrito(self.usuario_valido, self.contraseña_valida, self.parser_http)

        cart_id: str = response["body"].split("|")[1]

        response = self.agregar_a_un_carrito(cart_id, "0", "x", self.parser_http)

        self.assert_que_el_response_tiene(response, "400", "1",
                                          ParserHTTP.descripcion_de_error_book_quantity_invalido())

    def test10_autenticar_con_un_usuario_no_registrado_lanza_el_error_del_autenticador(self):
        def pasa(usuario_valido, contra_valida):
            def raise_error(usuario, contra):
                if usuario_valido != usuario or contra_valida != contra:
                    raise RuntimeError("Invalid credentials")

            return raise_error

        self.autenticador.set_authenticator(pasa("yenny", "elAteneo2003"))

        response = self.crear_un_carrito("", "", self.parser_http)

        self.assert_que_el_response_tiene(response, "400", "1", "Invalid credentials")

    def test11_autenticar_con_un_usuario_registrado_crea_el_carrito(self):
        def pasa(usuario_valido, contra_valida):
            def raise_error(usuario, contra):
                if usuario_valido != usuario or contra_valida != contra:
                    raise RuntimeError("Invalid credentials")

            return raise_error

        self.autenticador.set_authenticator(pasa("yenny", "elAteneo2003"))

        response = self.crear_un_carrito("yenny", "elAteneo2003", self.parser_http)

        caso_de_error, cart_id = self.separar_response(response)

        if (caso_de_error, cart_id) == ("", ""):
            self.fail("El body esta vacio o no tiene el formato esperado")

        self.assertEqual(response["statusCode"], "200")
        self.assertEqual(caso_de_error, "0")
        self.assertNotEqual(len(cart_id), 0)

    def test12_hacer_checkout_a_un_carrito_vacio_devuelve_un_error(self):
        fecha = datetime.now()
        request = self.crear_request_checkout_sin_elementos(fecha.month + 1, fecha.year + 1, "1111111111111111",
                                                            self.parser_http)

        response = self.parser_http.check_out_cart(request)

        self.assert_que_el_response_tiene(response, "400", "1",
                                          Cajero.descripcion_no_se_puede_cobrar_un_carrito_vacio())

    def test13_hacer_checkout_con_una_tarjeta_vencida_devuelve_un_error(self):
        fecha = datetime.now()
        request = self.crear_request_checkout_con_elementos(fecha.month, fecha.year - 1, "1111111111111111",
                                                            self.parser_http)

        response = self.parser_http.check_out_cart(request)

        self.assert_que_el_response_tiene(response, "400", "1",
                                          Cajero.descripcion_no_se_puede_cobrar_a_una_tarjeta_vencida())

    def test14_hacer_checkout_con_una_tarjeta_con_numero_invalido_devuelve_un_error(self):
        fecha = datetime.now()
        request = self.crear_request_checkout_con_elementos(fecha.month, fecha.year - 1, "1", self.parser_http)

        response = self.parser_http.check_out_cart(request)

        self.assert_que_el_response_tiene(response, "400", "1",
                                          TarjetaDeCredito.descripcion_de_error_tarjeta_invalida())

    def test15_hacer_checkout_con_una_tarjeta_con_fecha_invalida_devuelve_un_error(self):
        fecha = datetime.now()
        request = self.crear_request_checkout_con_elementos(fecha.month - 14, fecha.year - 1, "1", self.parser_http)

        response = self.parser_http.check_out_cart(request)

        self.assert_que_el_response_tiene(response, "400", "1",
                                          TarjetaDeCredito.descripcion_de_error_tarjeta_invalida())

    def test16_hacer_checkout_con_una_sesion_expirada_devuelve_un_error(self):
        fecha = datetime.now()
        self.stub_registro_de_actividad.set_ahora(fecha)
        request = self.crear_request_checkout_con_elementos(fecha.month, fecha.year, "1111111111111111",
                                                            self.parser_http_con_stub)

        self.stub_registro_de_actividad.set_ahora(fecha + timedelta(minutes=12))

        response = self.parser_http_con_stub.check_out_cart(request)

        self.assert_que_el_response_tiene(response, "400", "1", TusLibrosWebAPI.descripcion_error_sesion_expirada())

    def test17_listar_un_carrito_con_una_sesion_expirada_devuelve_un_error(self):
        response = self.crear_un_carrito(self.usuario_valido, self.contraseña_valida, self.parser_http_con_stub)
        cart_id = response["body"].split("|")[1]
        self.stub_registro_de_actividad.set_ahora(datetime.now())
        self.listar_un_carrito(cart_id, self.parser_http_con_stub)

        self.stub_registro_de_actividad.set_ahora(datetime.now() + timedelta(minutes=12))

        response = self.listar_un_carrito(cart_id, self.parser_http_con_stub)

        self.assert_que_el_response_tiene(response, "400", "1", TusLibrosWebAPI.descripcion_error_sesion_expirada())

    def test18_agregar_a_un_carrito_con_una_sesion_expirada_devuelve_un_error(self):
        response = self.crear_un_carrito(self.usuario_valido, self.contraseña_valida, self.parser_http_con_stub)
        cart_id = response["body"].split("|")[1]

        self.stub_registro_de_actividad.set_ahora(datetime.now() + timedelta(minutes=12))

        response = self.agregar_a_un_carrito(cart_id, "0", "1", self.parser_http_con_stub)

        self.assert_que_el_response_tiene(response, "400", "1", TusLibrosWebAPI.descripcion_error_sesion_expirada())


    def test19_puedo_listar_las_compras_de_un_usuario_con_compras(self):
        def todo_pasa(usuario, contra):
            return True
        
        self.autenticador.set_authenticator(todo_pasa)

        response = self.crear_un_carrito("pepe", "amongus", self.parser_http)
        cart_id = response["body"].split("|")[1]
        self.agregar_a_un_carrito(cart_id, "0", "1", self.parser_http)
        self.agregar_a_un_carrito(cart_id, "1", "1", self.parser_http)
        self.hacerle_checkout_a_un_carrito(
            cart_id,
            "05",
            "2029",
            "1111222233334444",
            "Marten",
            self.parser_http)
        
        response = self.listar_las_compras_de_un_cliente("pepe", "amongus", self.parser_http)
        
        body = response["body"].split("|")
        caso_de_exito = body[0]
        libro_0 = body[1:3]
        libro_1 = body[3:5]
        total = body[5]

        self.assertEqual(caso_de_exito, "0")
        self.assertEqual(libro_0, ["0", "1"])
        self.assertEqual(libro_1, ["1", "1"])
        self.assertEqual(total, "300")

    def test20_no_puedo_listar_las_compras_de_un_usuario_no_autenticado(self):
        def nada_pasa(usuario, contra):
            raise RuntimeError("Invalid credentials")
        
        self.autenticador.set_authenticator(nada_pasa)
        
        response = self.listar_las_compras_de_un_cliente("pepe", "amongus", self.parser_http)

        body = response["body"].split("|")
        self.assertEqual(body[0], "1")
        self.assertEqual(body[1], "Invalid credentials")


if __name__ == '__main__':
    unittest.main()
