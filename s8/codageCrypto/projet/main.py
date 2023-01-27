import random as rdn
import numpy as np

# Les jokers sont 53 et 54, noir étant 53


# Prend le paquet en argument et le renvoi
def reculJokerNoir(p):
    i = np.where(p == 53)[0][0]
    if (i == 53):
        p[[i, 1]] = p[[1, i]]
    else:
        p[[i, i+1]] = p[[i+1, i]]
    return p


def main():
    rdn.seed(1)
    paquet = np.array(rdn.sample(range(1, 55), 54))
    print(f"{paquet=}")
    paquet = reculJokerNoir(paquet)
    print(f"{paquet=}")


if __name__ == "__main__":
    main()
    pass
