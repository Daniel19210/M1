import numpy as np
import random as rdn
import chiffrement as m


def lancementTerminal():
    # rdn.seed(1)  # Fixe le RNG
    # Création d'un paquet mélangé
    paquet = np.array(rdn.sample(range(1, 55), 54))
    m.ecritureMessage("paquet.txt", np.array2string(paquet))

    messageBrut = m.formattageMessage(input("Entrer le message à coder:\n"))
    messageChiffre = m.chiffrage(messageBrut, paquet)
    paquet2 = m.lectureFichier("paquet.txt")
    messageDechiffre = m.dechiffrage(paquet2, messageChiffre)
    print(f"Le message chiffré est: '{messageChiffre}'")
    print(f"Le message dechiffré est: '{messageDechiffre}'")
    print(f"La position du paquet initial est: '{paquet2}'")
    m.ecritureMessage("crypte.txt", messageChiffre)
    m.ecritureMessage("messDechiffre.txt", messageDechiffre)


lancementTerminal()
