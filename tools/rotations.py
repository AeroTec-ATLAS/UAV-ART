import numpy as np
from math import sin, cos


def Euler2Rotation(phi, theta, psi):
    # Transfroms Euler angles into a rotation matrix R, for a body to inertial rotation
    s_phi = sin(phi)
    c_phi = cos(phi)
    s_theta = sin(theta)
    c_theta = cos(theta)
    s_psi = sin(psi)
    c_psi = cos(psi)

    R = np.array([[c_theta * c_psi, s_phi * s_theta * c_psi - c_phi * s_psi, c_phi * s_theta * c_psi + s_phi * s_psi],
                  [c_theta * s_psi, s_phi * s_theta * s_psi + c_phi * c_psi, c_phi * s_theta * s_psi - s_phi * c_psi],
                  [-s_theta, s_phi * c_theta, c_phi * c_theta]])
    return R


def Euler2Quaternion(phi, theta, psi):
    e0 = cos(psi / 2) * cos(theta / 2) * cos(phi / 2) + sin(psi / 2) * sin(theta / 2) * sin(phi / 2)
    e1 = cos(psi / 2) * cos(theta / 2) * sin(phi / 2) + sin(psi / 2) * sin(theta / 2) * cos(phi / 2)
    e2 = cos(psi / 2) * sin(theta / 2) * cos(phi / 2) + sin(psi / 2) * cos(theta / 2) * sin(phi / 2)
    e3 = sin(psi / 2) * cos(theta / 2) * cos(phi / 2) + cos(psi / 2) * sin(theta / 2) * sin(phi / 2)
    e = np.array([e0, e1, e2, e3])
    return e
