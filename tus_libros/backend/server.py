from datetime import timedelta
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from servicios.mercado_pago import MercadoPago
from servicios.oauth_authentication_system import OAuthAuthenticationSystem

from registro_de_actividad import RegistroDeActividad

from parser_http import ParserHTTP
from tus_libros_web_api import TusLibrosWebAPI

from utils import parsear_catalogo_por_isbn, parsear_catalogo_por_isbn_y_precio

from flask import Flask
from flask import request as flask_request

class Server:
    def __init__(self, flask_app):
        catalogo = parsear_catalogo_por_isbn("catalogos/catalogo.json")
        precios = parsear_catalogo_por_isbn_y_precio("catalogos/catalogo.json")
        timeout = timedelta(minutes=30)
        tus_libros_web_api = TusLibrosWebAPI(catalogo, OAuthAuthenticationSystem(), MercadoPago(), precios, RegistroDeActividad(timeout))

        self.parser_http = ParserHTTP(tus_libros_web_api)
        self.flask_app = flask_app

        @self.flask_app.route('/createCart', methods=['GET'])
        def create_cart():
            client_id = flask_request.args.get('clientId', "")
            password = flask_request.args.get('password', "")

            request = {"clientId": client_id, "password": password}
            response = self.parser_http.create_cart(request)

            return response["body"], response["statusCode"]


        @self.flask_app.route('/addToCart', methods=['GET'])
        def add_to_cart():
            cart_id = flask_request.args.get('cartId', "")
            book_isbn = flask_request.args.get('bookIsbn', "")
            book_quantity = flask_request.args.get('bookQuantity', "1")

            request = {"cartId": cart_id, "bookIsbn": book_isbn, "bookQuantity": book_quantity}
            response = self.parser_http.add_to_cart(request)

            return response["body"], response["statusCode"]


        @self.flask_app.route('/listCart', methods=['GET'])
        def list_cart():
            cart_id = flask_request.args.get('cartId', "")

            request = {"cartId": cart_id}
            response = self.parser_http.list_cart(request)

            return response["body"], response["statusCode"]
        

        @self.flask_app.route('/checkOutCart', methods=['GET'])
        def check_out_cart():
            #     - `cartId`: Id del carrito creado con /createCart 
            #     - `ccn`: Número de tarjeta de credito 
            #     - `cced`: Fecha de expiración con 2 digitos para el mes y 4 para el año 
            #     - `cco`: Nombre del dueño de la tarjeta. 
            # - Output: 
            #     - En caso de éxito: `0|TRANSACTION_ID`
            #     - En caso de error: `1|DESCRIPCION_DE_ERROR`
            cart_id = flask_request.args.get('cartId', "")
            ccn = flask_request.args.get('ccn', "")
            cced = flask_request.args.get('cced', "")
            cco = flask_request.args.get('cco', "")

            request = {"cartId": cart_id, "ccn": ccn, "cced": cced, "cco": cco}
            print(request)
            response = self.parser_http.check_out_cart(request)

            return response["body"], response["statusCode"]
        

        @self.flask_app.route('/listPurchases', methods=['GET'])
        def list_purchases():
            client_id = flask_request.args.get('clientId', "")
            password = flask_request.args.get('password', "")

            request = {"clientId": client_id, "password": password}
            response = self.parser_http.list_purchases(request)

            return response["body"], response["statusCode"]

    def run(self):
        self.flask_app.run(debug=True, port=9000)

if __name__ == '__main__':
    app = Flask(__name__)
    server = Server(app)

    server.run()
