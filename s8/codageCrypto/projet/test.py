import numpy as np
from main import *


def testReculJokerNoir():
    print("Test Joker avec un paquet normal")
    paquet = np.array([x for x in range(1, 55)])
    paquet = reculJokerNoir(paquet)
    verif = np.array([x for x in range (1, 53)] + [54,53])
    print("Test ReculJokerNoir OK") if np.array_equal(paquet, verif) else print("Test False\n",paquet)


def testJokerNoirDernierePosition():
    print("Test Joker en dernière position")
    paquet = np.array([x for x in range(1, 53)] + [54])
    paquet = np.insert(paquet, 53, 53)
    verif = np.array([53]+[x for x in range (2,53)]+[54, 1])
    paquet = reculJokerNoir(paquet)
    print("Test ReculJokerNoirDernierePos OK") if np.array_equal(paquet, verif) else print("Test False\n", paquet, "\n", verif)


def testSuite():
    testJokerNoirDernierePosition()
    testReculJokerNoir()
    print("Tout les tests ce sont bien déroulé")


testSuite()
