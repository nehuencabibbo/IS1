import json
import uuid

from typing import *

def parsear_catalogo_por_isbn(file_name: str) -> Set[str]:
    with open(file_name, 'r') as archivo:
        catalogo = json.load(archivo)

    return {book['isbn'] for book in catalogo}


def parsear_catalogo_por_isbn_y_precio(file_name: str) -> Set[str]:
    with open(file_name, 'r') as archivo:
        catalogo = json.load(archivo)

    return {book['isbn']: book["precio"] for book in catalogo}


def obtener_nueva_id() -> str:
    return str(uuid.uuid4().int)

