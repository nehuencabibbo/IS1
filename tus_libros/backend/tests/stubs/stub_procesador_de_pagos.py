class StubProcesadorDePagos:
    def __init__(self):
        self.debit = lambda x, y: ""

    def set_debit(self, debit):
        self.debit = debit

    def debit(self, amount_to_debit, credit_card_number):
        self.debit(amount_to_debit, credit_card_number)
