class StubAutenticador:
    def __init__(self):
        self.authenticate = lambda x, y: ""

    def set_authenticator(self, authenticator):
        self.authenticate = authenticator

    def authenticate(self, usuario, contra):
        self.authenticate(usuario, contra)
