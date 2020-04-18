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
