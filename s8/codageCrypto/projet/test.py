import numpy as np
import inspect
from chiffrement import reculJokerNoir, reculJokerRouge


def testReculJokerNoirPaquetNeuf():
    paquet = np.array([x for x in range(1, 55)])
    paquet = reculJokerNoir(paquet)
    temoin = np.array([x for x in range(1, 53)] + [54, 53])
    print("Passed :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print( "Failed :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testJokerNoirDernierePosition():
    paquet = np.array([x for x in range(1, 53)] + [54])
    paquet = np.insert(paquet, 53, 53)  # Insertion en dernière position
    paquet = reculJokerNoir(paquet)
    temoin = np.array([53]+[x for x in range(2, 53)]+[54, 1])
    print("Passed :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print( "Failed :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testReculJokerRougeDernierePosition():
    paquet = np.array([x for x in range(1, 55)])
    paquet = reculJokerRouge(paquet)
    temoin = np.array([2, 54]+[x for x in range(3, 54)]+[1])
    print("Passed :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print( "Failed :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testReculJokerRougeAvantDernierePosition():
    paquet = np.array([x for x in range(1, 54)])
    paquet = np.insert(paquet, 52, 54)
    paquet = reculJokerRouge(paquet)
    temoin = np.array([54]+[x for x in range(2, 54)]+[1])
    print("Passed :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print( "Failed :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testReculJokerRougePositionNormale():
    paquet = np.array([x for x in range(1, 54)])
    paquet = np.insert(paquet, 25, 54)
    paquet = reculJokerRouge(paquet)
    temoin = np.array([x for x in range(1, 28)]+[54]+[x for x in range(28, 54)])
    print("Passed :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print( "Failed :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testSuite():
    testReculJokerNoirPaquetNeuf()
    testJokerNoirDernierePosition()
    testReculJokerRougeDernierePosition()
    testReculJokerRougeAvantDernierePosition()
    testReculJokerRougePositionNormale()
    print("Testsuite terminée")


testSuite()


def testManipulationPaquet(paquet):
    print(f"{paquet=}")
    paquetNoir = reculJokerNoir(paquet)
    print(f"{paquetNoir=}")
    paquetRouge = reculJokerRouge(paquet)
    print(f"{paquetRouge=}")
    # paquetCoupe = coupeDouble(paquet)
    # print(f"{paquetCoupe=}")
    # paquetCoupeSimple = coupeSimple(paquet)
    # print(f"{paquetCoupeSimple=}")
    # lettre = lecturePseudoAleatoire(paquet)
    # print(f"{alphabet[lettre]=}")
