import numpy as np
import chiffrement as m


def generePaquetInverse():
    neuf = np.array([x for x in range(1, 55)])
    inverse = np.array(neuf[::-1])
    jokerInverse = np.array([x for x in range(1, 53)] + [54, 53])
    m.ecritureMessage("paquetExemple/neuf.txt", np.array2string(neuf))
    m.ecritureMessage("paquetExemple/inverse.txt", np.array2string(inverse))
    m.ecritureMessage("paquetExemple/jokerInverse.txt", np.array2string(jokerInverse))


generePaquetInverse()
# print(lecturePaquet())
