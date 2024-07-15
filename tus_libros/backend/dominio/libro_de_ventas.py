class LibroDeVentas:
    def __init__(self):
        self.ventas = {}  # client_id: list(ticket, ...)

    def calcular_informacion_de_compras_del_cliente(self, client_id):
        compras_del_cliente = self.ventas.get(client_id, None)
        if not compras_del_cliente:
            return {}, 0

        total = 0
        todas_las_compras = {}
        for ticket in compras_del_cliente:
            compras_del_ticket = ticket.obtener_compras()  # {isbn: {cantidad: int, precio_total: int}}
            total += ticket.obtener_total()

            for isbn, venta in compras_del_ticket.items():
                cantidad = venta["cantidad"]

                if isbn not in todas_las_compras:
                    todas_las_compras[isbn] = cantidad
                else:
                    todas_las_compras[isbn] += cantidad

        return todas_las_compras, total

    def agregar_venta(self, client_id, ticket):
        if client_id not in self.ventas:
            self.ventas[client_id] = [ticket]
        else:
            self.ventas[client_id].append(ticket)
