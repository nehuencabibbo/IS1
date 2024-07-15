import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import unittest

from dominio.carrito import Carrito



class CarritoTests(unittest.TestCase):
    def setUp(self):
        self.isbn_de_un_libro = "0"
        self.isbn_de_otro_libro = "1"

        self.catalogo = set()
        self.catalogo.add(self.isbn_de_un_libro)
        self.catalogo.add(self.isbn_de_otro_libro)
        
        self.carrito = Carrito(self.catalogo)


    def test01_un_carrito_recien_creado_esta_vacio(self):
        self.assertTrue(self.carrito.tiene_una_cantidad_de_libros(0))


    def test02_puedo_agregar_un_libro_al_carrito(self):
        self.carrito.agregar(self.isbn_de_un_libro, 1)

        self.assertTrue(self.carrito.tiene_una_cantidad_de_libros(1))
        self.assertTrue(self.carrito.tiene_libros([self.isbn_de_un_libro]))


    def test03_puedo_agregar_multiples_libros_al_carrito(self):
        self.carrito.agregar(self.isbn_de_un_libro, 1)
        self.carrito.agregar(self.isbn_de_otro_libro, 1)

        self.assertTrue(self.carrito.tiene_una_cantidad_de_libros(2))
        self.assertTrue(self.carrito.tiene_libros([self.isbn_de_un_libro, self.isbn_de_otro_libro]))


    def test04_no_puedo_agregar_un_libro_que_no_esta_en_el_catalogo(self):
        libro_fuera_del_catalogo = "2"

        with self.assertRaises(RuntimeError) as exception_carrito:
            self.carrito.agregar(libro_fuera_del_catalogo, 1)
            self.fail("No deberia poder agregar un libro que no esta en el catalogo")

        self.assertEqual(str(Carrito.descripcion_libro_no_esta_en_catalogo()), str(exception_carrito.exception))

    
    def test05_puedo_agregar_multiples_veces_el_mismo_libro_al_carrito(self):
        self.carrito.agregar(self.isbn_de_un_libro, 2)

        self.assertTrue(self.carrito.tiene_una_cantidad_de_libros_de_un_isbn(2, self.isbn_de_un_libro))


if __name__ == '__main__':
    unittest.main()
