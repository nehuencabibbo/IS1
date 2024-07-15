import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import unittest

from dominio.tarjeta_de_credito import TarjetaDeCredito


class TarjetaDeCreditoTests(unittest.TestCase):
    def setUp(self):
        self.num_valido = "1111111111111111"
        self.num_invalido = "1"

        self.mes_valido = 12
        self.mes_invalido = 13

        self.año_valido = 2001
        self.año_invalido = -1

        self.nombre_valido = "Marten"
        self.nombre_invalido = ""


    def test01_no_se_puede_crear_una_tarjeta_con_un_año_invalido(self):
        with self.assertRaises(RuntimeError) as excep_tarjeta:
            TarjetaDeCredito.crear_tarjeta_con(self.mes_valido, self.año_invalido, self.num_valido, self.nombre_valido)
            self.fail("No deberia poder crear una tarjeta con un año invalido")

        self.assertEqual(str(TarjetaDeCredito.descripcion_de_error_tarjeta_invalida()), str(excep_tarjeta.exception))


    def test02_no_se_puede_crear_una_tarjeta_con_un_mes_invalido(self):
        with self.assertRaises(RuntimeError) as excep_tarjeta:
            TarjetaDeCredito.crear_tarjeta_con(self.mes_invalido, self.año_valido, self.num_valido, self.nombre_valido)
            self.fail("No deberia poder crear una tarjeta con un mes invalido")

        self.assertEqual(str(TarjetaDeCredito.descripcion_de_error_tarjeta_invalida()), str(excep_tarjeta.exception))


    def test03_no_se_puede_crear_una_tarjeta_con_un_numero_invalido(self):
        with self.assertRaises(RuntimeError) as excep_tarjeta:
            TarjetaDeCredito.crear_tarjeta_con(self.mes_valido, self.año_valido, self.num_invalido, self.nombre_valido)
            self.fail("No deberia poder crear una tarjeta con un numero invalido")

        self.assertEqual(str(TarjetaDeCredito.descripcion_de_error_tarjeta_invalida()), str(excep_tarjeta.exception))


    def test04_no_se_puede_crear_una_tarjeta_sin_nombre(self):
        with self.assertRaises(RuntimeError) as excep_tarjeta:
            TarjetaDeCredito.crear_tarjeta_con(self.mes_valido, self.año_valido, self.num_invalido, self.nombre_invalido)
            self.fail("No deberia poder crear una tarjeta con un numero invalido")

        self.assertEqual(str(TarjetaDeCredito.descripcion_de_error_tarjeta_invalida()), str(excep_tarjeta.exception))


if __name__ == "__main__":
    unittest.main()
