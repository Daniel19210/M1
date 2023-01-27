import numpy as np
from main import reculJokerNoir


def testReculJoker():
    print("Test Joker avec un paquet normal")
    paquet = np.array([x for x in range(0, 55)])
    paquet = reculJokerNoir(paquet)
    verif = np.array([x for x in range(0, 55)])
    verif[[1, 53]] = verif[[53, 1]]
    np.array_equal(paquet, verif)


def testJokerDernierePosition():
    print("Test Joker en dernière position")
    paquet = np.array([x for x in range(0, 55)])
    paquet = reculJokerNoir(paquet)
    verif = np.array([x for x in range(0, 55)])
    verif[[1, 53]] = verif[[53, 1]]
    np.array_equal(paquet, verif)


def testSuite():
    testJokerDernierePosition()
    print("Tout les tests ce sont bien déroulé")


testSuite()
