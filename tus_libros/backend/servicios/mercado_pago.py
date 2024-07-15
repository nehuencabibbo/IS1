class MercadoPago:

    def debit(self, amount_to_debit, credit_card):
        # Acá implementaríamos la comunicación con la API de Mercado Pago - Luciano."

        if credit_card.number() == '1111111111111117':
            raise RuntimeError("Stolen card!")
