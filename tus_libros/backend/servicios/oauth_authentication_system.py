class OAuthAuthenticationSystem:

    def authenticate(self, username, password):
        # Acá implementaríamos la comunicación con el sistema externo - Luciano.
        # if not(username == 'yenny' and password == 'elAteneo2003'):
        #     raise RuntimeError("Invalid credentials")
        if (username == 'yenny' and password == 'elAteneo2003'):
            raise RuntimeError("Invalid credentials")

        
