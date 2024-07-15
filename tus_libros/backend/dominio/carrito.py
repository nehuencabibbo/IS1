from typing import *


class Carrito:
    def __init__(self, catalogo: Set[str]):
        self.compras: Dict[str, int] = {}
        self.catalogo: Set[str] = catalogo

    @classmethod
    def descripcion_de_error_carrito_no_existe(cls):
        return f"No existe el carrito"
    
    @classmethod
    def descripcion_libro_no_esta_en_catalogo(cls):
        return "El libro tiene que estar en el catalogo"
    
    @classmethod
    def descripcion_de_error_book_quantity_invalido(cls):
        return "El libro tiene que tener una cantidad mayor a cero"

    def listar(self):
        return self.compras.copy()

    def agregar(self, isbn_del_libro: str, cantidad: int):
        if isbn_del_libro not in self.catalogo:
            raise RuntimeError(Carrito.descripcion_libro_no_esta_en_catalogo())

        self.compras[isbn_del_libro] = self.compras.get(isbn_del_libro, 0) + cantidad

    def tiene_una_cantidad_de_libros_de_un_isbn(self, una_cantidad_de_libros: int, isbn: str) -> bool:
        return self.compras.get(isbn, 0) == una_cantidad_de_libros

    def tiene_una_cantidad_de_libros(self, una_cantidad_de_libros: int) -> bool:
        return len(self.compras) == una_cantidad_de_libros

    def tiene_libro(self, isbn_del_libro: str) -> bool:
        return isbn_del_libro in self.compras

    def tiene_libros(self, unos_libros: List[str]) -> bool:
        for libro in unos_libros:
            if not self.tiene_libro(libro):
                return False
        return True

    def vaciar(self):
        self.compras = {}