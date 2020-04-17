import numpy as np


def Euler2Rotation(phi, theta, psi):
    R = np.array([[0, 1, 0], [1, 0, 0], [0, 0, 1]])
    return R
