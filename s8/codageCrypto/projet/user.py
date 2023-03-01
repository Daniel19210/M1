import numpy as np
import random as rdn
import chiffrement as m

def main():
    # rdn.seed(1)  # Fixe le RNG
    # Création d'un paquet mélangé
    paquet = np.array(rdn.sample(range(1, 55), 54))

    # messageBrut = "test"
    # messageBrut = "TEST"
    # messageBrut = "test avec des caractères spéciaux."
    messageBrut = m.formattageMessage(input("Entrer le message à coder:\n"))
    # messageBrut = m.lectureFichier("texteBrut/lorem.txt")

    m.genererCleEncodage(paquet, messageBrut)
    cleEncodage = m.lectureFichier("cle.txt")
    messageChiffre = m.chiffrage(messageBrut, cleEncodage)
    messageDechiffre = m.dechiffrage(cleEncodage, messageChiffre)
    print(f"Le message chiffré est: '{messageChiffre}'")
    print(f"Le message dechiffré est: '{messageDechiffre}'")
    print(f"La clé de chiffrement est: '{cleEncodage}'")
    m.ecritureMessage("crypte.txt", messageChiffre)
    m.ecritureMessage("messDechiffre.txt", messageDechiffre)


if __name__ == "__main__":
    main()
    pass
