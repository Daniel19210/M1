import random as rdn
import numpy as np


def reculJokerRouge(p):
    i = np.where(p == 54)[0][0]
    if i == 53:
        p[[i, 2]] = p[[2, i]]
    elif i == 52:
        p[[i, 1]] = p[[1, i]]
    else:
        p[[i, i+2]] = p[[i+2, i]]
    return p


def reculJokerNoir(p):
    i = np.where(p == 53)[0][0]
    if (i == 53):
        p[[i, 1]] = p[[1, i]]
    else:
        p[[i, i+1]] = p[[i+1, i]]
    return p


def testMano(paquet):
    print(f"{paquet=}")
    paquetNoir = reculJokerNoir(paquet)
    print(f"{paquetNoir=}")
    paquetRouge = reculJokerRouge(paquet)
    print(f"{paquetRouge=}")
    paquetCoupe = coupeDouble(paquet)
    print(f"{paquetCoupe=}")
    paquetCoupeSimple = coupeSimple(paquet)
    print(f"{paquetCoupeSimple=}")
    # lettre = lecturePseudoAleatoire(paquet)
    # print(f"{alphabet[lettre]=}")


def coupeDouble(p):
    iNoir = np.where(p == 53)[0][0]
    iRouge = np.where(p == 54)[0][0]
    p1, p2, p3 = p[:min(iNoir, iRouge)], p[min(iNoir, iRouge):max(
        iNoir, iRouge)+1], p[max(iNoir, iRouge)+1:]
    return np.concatenate((p3, p2, p1))


def coupeSimple(p):
    # Il faut convertir le joker rouge en 53
    carte = p[53] if p[53] != 54 else 53
    cartesABouger, reste = p[:carte], p[carte:53]
    return np.concatenate((reste, cartesABouger, [carte]))


def melange(p):
    p = reculJokerNoir(p)
    p = reculJokerRouge(p)
    p = coupeDouble(p)
    p = coupeSimple(p)
    return p


def lecturePseudoAleatoire(p):
    # Il faut convertir le joker rouge en 53
    n = p[0] if p[0] != 54 else 53
    m = p[n]
    if (m >= 53):
        p = melange(p)
        lecturePseudoAleatoire(p)
    elif (m > 26):
        m = m - 26
    return m


# Les jokers sont 53 et 54, noir étant 53
# Prend le paquet en argument et le renvoi
def main():
    rdn.seed(1)

    # Création d'un paquet mélangé
    paquet = np.array(rdn.sample(range(1, 55), 54))
    # Voir si il faut prendre un fichier en input
    messageACoder = input("Entrer le message à coder:\n")
    cleEncodage = ''
    res = ""
    longeurMessage = len(messageACoder)
    for i in range(longeurMessage):
        paquet = melange(paquet)
        carte = lecturePseudoAleatoire(paquet)
        cleEncodage += chr(carte + 64)  # Nouvelle lettre de la clé
        test = (ord(cleEncodage[i]) + ord(messageACoder[i])) % 26 + 65
        res += chr(test)  # Nouvelle lettre du message chiffré
    # print(f"{cleEncodage=}")
    print(f"Le message chiffré est: '{res}'")


if __name__ == "__main__":
    main()
    pass
