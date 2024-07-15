import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import unittest

from dominio.libro_de_ventas import LibroDeVentas
from dominio.ticket import Ticket


class LibroDeVentasTests(unittest.TestCase):
    def setUp(self):
        self.libro_de_ventas = LibroDeVentas()

    def test1_si_no_compro_nada_listar_compras_no_devuelve_nada(self):
        compras, total = self.libro_de_ventas.calcular_informacion_de_compras_del_cliente("")

        self.assertEqual(len(compras), 0)
        self.assertEqual(total, 0)

    def test2_si_hice_dos_compras_puedo_verlas_al_listarlas(self):
        ticket = Ticket({"0": {"cantidad": 1, "precio_total": 100}, "1": {"cantidad": 1, "precio_total": 200}}, 300)

        self.libro_de_ventas.agregar_venta("pepe", ticket)

        compras, total = self.libro_de_ventas.calcular_informacion_de_compras_del_cliente("pepe")

        self.assertEqual(total, 300)

        self.assertEqual(compras.get("0", None), 1)
        self.assertEqual(compras.get("1", None), 1)
