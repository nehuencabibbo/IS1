from utils import obtener_nueva_id


class Ticket:
    def __init__(self, compras, total):
        self.compras = compras  # {isbn: {cantidad: int, precio_total: int}}
        self.total = total
        self.id = obtener_nueva_id()
    
    def tiene_total(self, un_total: int):
        return self.total == un_total

    def transaction_id(self):
        return self.id
    
    def obtener_compras(self):
        return self.compras.copy()

    def obtener_total(self):
        return self.total
