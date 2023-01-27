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