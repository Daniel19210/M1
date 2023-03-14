import numpy as np
import inspect
from chiffrement import reculJokerNoir, reculJokerRouge, coupeDouble


def testReculJokerNoirPaquetNeuf():
    paquet = np.array([x for x in range(1, 55)])
    paquet = reculJokerNoir(paquet)
    temoin = np.array([x for x in range(1, 53)] + [54, 53])
    print("Passed :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print( "Failed :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testJokerNoirDernierePosition():
    paquet = np.array([x for x in range(1, 53)] + [54])
    paquet = np.insert(paquet, 53, 53)  # Insertion en dernière position
    paquet = reculJokerNoir(paquet)
    temoin = np.array([x for x in range(1, 53)] + [54])
    temoin = np.insert(temoin, 1, 53)
    print("Passed :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print( "Failed :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testReculJokerRougeDernierePosition():
    paquet = np.array([x for x in range(1, 55)])
    paquet = reculJokerRouge(paquet)
    temoin = np.array([x for x in range(1,54)])
    temoin = np.insert(temoin, 2, 54)
    print("Passed :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print( "Failed :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testReculJokerRougeAvantDernierePosition():
    paquet = np.array([x for x in range(1, 54)])
    paquet = np.insert(paquet, 52, 54)
    paquet = reculJokerRouge(paquet)
    temoin = np.array([x for x in range(1,54)])
    temoin = np.insert(temoin, 1, 54)
    print("Passed :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print( "Failed :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")


def testReculJokerRougePositionNormale():
    paquet = np.array([x for x in range(1, 54)])
    paquet = np.insert(paquet, 25, 54)
    paquet = reculJokerRouge(paquet)
    temoin = np.array([x for x in range(1, 28)]+[54]+[x for x in range(28, 54)])
    print("Passed :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print( "Failed :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")

def testCoupeDouble():
    paquet = np.array([x for x in range(1,53)])
    paquet = np.insert(paquet, 7, 54)
    paquet = np.insert(paquet, 42, 53)
    paquet = coupeDouble(paquet)

    p1 = np.array([x for x in range(42, 53)])
    p2 = np.concatenate(([54], np.array([x for x in range(8, 42)]), [53]))
    p3 = np.array([x for x in range(1,8)])
    temoin = np.concatenate((p1, p2, p3))
    print("Passed :", inspect.getframeinfo(inspect.currentframe()).function) if np.array_equal(paquet, temoin) else print( "Failed :", inspect.getframeinfo(inspect.currentframe()).function, f"\n\t{paquet=}\n\t{temoin=}")

def testSuite():
    testReculJokerNoirPaquetNeuf()
    testJokerNoirDernierePosition()
    testReculJokerRougeDernierePosition()
    testReculJokerRougeAvantDernierePosition()
    testReculJokerRougePositionNormale()
    testCoupeDouble()
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
