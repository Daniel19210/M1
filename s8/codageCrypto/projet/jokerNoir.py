import numpy as np


def reculJokerNoir(p):
    i = np.where(p == 53)[0][0]
    if (i == 53):
        p[[i, 1]] = p[[1, i]]
    else:
        p[[i, i+1]] = p[[i+1, i]]
    return p
