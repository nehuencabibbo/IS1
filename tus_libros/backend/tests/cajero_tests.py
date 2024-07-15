import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import unittest

from utils import parsear_catalogo_por_isbn, parsear_catalogo_por_isbn_y_precio

from typing import *
from stubs.stub_procesador_de_pagos import StubProcesadorDePagos

from dominio.carrito import Carrito
from dominio.cajero import Cajero
from dominio.tarjeta_de_credito import TarjetaDeCredito 


class CajeroTest(unittest.TestCase):
    def setUp(self):
        catalogo = parsear_catalogo_por_isbn("../catalogos/catalogo_test.json")

        self.procesador_de_pagos = StubProcesadorDePagos()
        self.precios = parsear_catalogo_por_isbn_y_precio("../catalogos/catalogo_test.json")

        self.mes = 1
        self.año = 2024

        self.carrito = Carrito(catalogo)
        self.cajero = Cajero(self.precios, self.procesador_de_pagos)

        self.tarjeta_de_credito_vencida = TarjetaDeCredito.crear_tarjeta_con(self.mes, self.año - 1, "1010202030304040", "pablo")
        self.tarjeta_de_credito_valida = TarjetaDeCredito.crear_tarjeta_con(self.mes, self.año + 1, "1010202030304040", "pablo")


    def test_01_no_se_puede_cobrar_un_carrito_vacio(self):
        with self.assertRaises(RuntimeError) as exception_cajero:
            self.cajero.cobrar(self.carrito, self.tarjeta_de_credito_valida)
            self.fail("No se debería poder cobrar un carrito vacio")

        self.assertEqual(str(Cajero.descripcion_no_se_puede_cobrar_un_carrito_vacio()), str(exception_cajero.exception))


    def test_02_no_se_puede_cobrar_a_una_tarjeta_vencida(self):
        self.carrito.agregar("0", 1)

        with self.assertRaises(RuntimeError) as excepcion_cajero:
            self.cajero.cobrar(self.carrito, self.tarjeta_de_credito_vencida)
            self.fail("No se debería poder cobrar a una tarjeta de credito vencida.")

        self.assertEqual(str(Cajero.descripcion_no_se_puede_cobrar_a_una_tarjeta_vencida()), str(excepcion_cajero.exception))


    def test_03_si_la_tarjeta_es_valida_y_no_robada_se_puede_cobrar(self):
        self.carrito.agregar("0", 1)

        def pasa(numero_de_tarjeta_que_pasa):
            def debit(amount_to_debit, credit_card):
                if numero_de_tarjeta_que_pasa != credit_card.number():
                    raise RuntimeError("Tarjeta Robada")
            return debit

        numero_de_trajeta_valida = self.tarjeta_de_credito_valida.number()
        self.procesador_de_pagos.set_debit(pasa(numero_de_trajeta_valida))

        ticket = self.cajero.cobrar(self.carrito, self.tarjeta_de_credito_valida)

        self.assertTrue(ticket.tiene_total(self.precios["0"]))


    def test_04_si_la_tarjeta_es_robada_no_se_puede_cobrar(self):
        self.carrito.agregar("0", 1)

        def no_pasa(numero_de_tarjeta_robada):
            def debit(amount_to_debit, credit_card):
                if numero_de_tarjeta_robada == credit_card.number():
                    raise RuntimeError("Tarjeta Robada")
            return debit

        numero_de_tarjeta_robada = self.tarjeta_de_credito_valida.number()
        self.procesador_de_pagos.set_debit(no_pasa(numero_de_tarjeta_robada))

        with self.assertRaises(RuntimeError):
            self.cajero.cobrar(self.carrito, self.tarjeta_de_credito_valida)
            self.fail("No deberia poder cobrarle a una tarjeta de credito robada")

    
if __name__ == "__main__":
    unittest.main()
