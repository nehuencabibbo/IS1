from typing import *


class ParserHTTP:
    def __init__(self, tus_libros_web_api):
        self.tus_libros_web_api = tus_libros_web_api

    @staticmethod
    def validar_header_del_request(request: Dict[str, str], parametros_esperados: List[str]):
        # Ejemplo de uso
        # parametrosEsperados = ["clientId", "password"]
        # faltanParametros, parametrosFaltantes = self.validarRequestHeaders()
        # if faltanParametros:
        #     response = {"statusCode": "400", "body": f"Faltan los headers: {" - ".join(parametrosFaltantes)}"}
        #     return response
        parametros_faltantes = []
        for parametro in parametros_esperados:
            valor_del_parametro = request.get(parametro, None)
            if not valor_del_parametro:
                parametros_faltantes.append(parametro)

        faltan_parametros = len(parametros_faltantes) > 0

        return faltan_parametros, parametros_faltantes

    def response_ante(self, accion: Callable):
        try:
            output = accion()
            response = {"statusCode": "200", "body": "0|" + (output if output else "OK")}

        except RuntimeError as e:
            response = {"statusCode": "400", "body": "1|" + str(e)}

        return response

    def create_cart(self, request: Dict[str, str]) -> Dict[str, str]:
        client_id: str = request["clientId"]
        password: str = request["password"]

        response = self.response_ante(lambda: self.tus_libros_web_api.create_cart(client_id, password))

        return response

    def add_to_cart(self, request: Dict[str, str]) -> Dict[str, str]:
        cart_id: str = request["cartId"]
        book_isbn: str = request["bookIsbn"]

        try:
            book_quantity: int = int(request["bookQuantity"])

        except ValueError:
            return {"statusCode": "400", "body": "1|" + self.descripcion_de_error_book_quantity_invalido()}

        response = self.response_ante(lambda: self.tus_libros_web_api.add_to_cart(cart_id, book_isbn, book_quantity))

        return response

    def list_cart(self, request: Dict[str, str]) -> Dict[str, str]:
        cart_id: str = request["cartId"]

        def listar_carrito():
            libros_por_cantidad: Dict[str, int] = self.tus_libros_web_api.list_cart(cart_id)
            salida = '|'.join(f'{isbn}|{cantidad}' for isbn, cantidad in libros_por_cantidad.items())
            return salida

        response = self.response_ante(listar_carrito)

        return response

    def check_out_cart(self, request: Dict[str, str]):
        try:
            ccn = request["ccn"]
            ccn = int(ccn)

        except ValueError:
            return {"statusCode": "400", "body": "1|" + ParserHTTP.descripcion_de_error_numero_tarjeta_invalido()}

        try:
            cced: str = request["cced"]
            mes, año = cced[0:2], cced[2:]
            mes, año = int(mes), int(año)

        except ValueError:
            return {"statusCode": "400", "body": "1|" + ParserHTTP.descripcion_de_error_fecha_vencimiento_tarjeta_invalido()}

        cart_id: str = request["cartId"]
        cco: str = request["cco"]

        response = self.response_ante(lambda: self.tus_libros_web_api.check_out_cart(cart_id, ccn, mes, año, cco))

        return response

    def list_purchases(self, request: Dict[str, str]):
        client_id: str = request["clientId"]
        password: str = request["password"]

        def listar_compras():
            compras, total = self.tus_libros_web_api.list_purchases(client_id, password)
            salida = '|'.join(f'{isbn}|{cantidad}' for isbn, cantidad in compras.items())
            salida += f'|{total}'
            return salida

        response = self.response_ante(listar_compras)

        return response

    @classmethod
    def descripcion_de_error_book_quantity_invalido(cls):
        return "La cantidad a ingresar del libro debe ser numerica"

    @classmethod
    def descripcion_de_error_numero_tarjeta_invalido(cls):
        return "El numero de la tarjeta de credito debe ser numerico"

    @classmethod
    def descripcion_de_error_fecha_vencimiento_tarjeta_invalido(cls):
        return "La fecha de vencimiento de la tarjeta de credito debe ser numerica"
