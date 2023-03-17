import numpy as np
import random as rdn
import chiffrement as m


def lancementTerminal():
    # rdn.seed(1)  # Fixe le RNG
    # Création d'un paquet mélangé
    paquet = np.array(rdn.sample(range(1, 55), 54))
    messageBrut = m.formattageMessage(input("Entrer le message à coder:\n"))
    messageChiffre = m.chiffrage(messageBrut, paquet)
    messageDechiffre = m.dechiffrage(paquet, messageChiffre)
    print(f"Le message chiffré est: '{messageChiffre}'")
    print(f"Le message dechiffré est: '{messageDechiffre}'")
    print(f"La position du paquet initial est: '{paquet}'")


lancementTerminal()
