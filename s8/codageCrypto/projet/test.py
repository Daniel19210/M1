import numpy as np
import main.reculJokerNoir


def testJokerDernierePosition():
    paquet = np.array([x for x in range(0, 55)])
    paquet = main.reculJokerNoir(paquet)
    verif = np.array([x for x in range(0, 55)])
    verif[[0, 52]] = verif[[52, 0]]
    assert(paquet == verif)
