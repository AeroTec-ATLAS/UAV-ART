"""
Class to determine wind velocity at any given moment,
calculates a steady wind speed and uses a stochastic
process to represent wind gusts. (Follows section 4.4 in uav book)
"""
import sys
sys.path.append('..')
from tools.transfer_function import transferFunction
from tools.rotations import Euler2Rotation2
import parameters.aerosonde_parameters as MAV
#import parameters.simulation_parameters as SIM
from math import sqrt
import numpy as np


class windSimulation:
    def __init__(self, Ts):
        # steady state wind defined in the inertial frame
        self._steady_state = np.array([[0., 0., 0.]]).T
        # Gust model parameters from table 4.1
        L_u = 200
        L_v = 200
        L_w = 50
        sigma_u = 1.06
        sigma_v = 1.06
        sigma_w = 0.7
        Va0 = MAV.Va0  # Reference value for airspeed
        self.u_w_g = transferFunction(sigma_u * sqrt(2 * Va0 / L_u) ** np.array([[1]]), sigma_u * sqrt(2 * Va0 / L_u) * np.array([[1, Va0 / L_u]]), Ts)
        self.v_w_g = transferFunction(sigma_v * sqrt(3 * Va0 / L_v) ** np.array([[1, Va0 / (sqrt(3) * L_v)]]), sigma_v * sqrt(3 * Va0 / L_v) ** np.array([[1, 2 * Va0 / L_v, (Va0 / L_v)**2]]), Ts)
        self.w_w_g = transferFunction(sigma_w * sqrt(3 * Va0 / L_w) * np.array([[1, Va0 / (sqrt(3) * L_w)]]), sigma_w * sqrt(3 * Va0 / L_w) * np.array([[1, 2 * Va0 / L_w, (Va0 / L_w)**2]]), Ts)
        self._Ts = Ts

    def update(self):
        # returns a six vector.
        #   The first three elements are the steady state wind in the inertial frame
        #   The second three elements are the gust in the body frame
        gust = np.array([[self.u_w_g.update(np.random.randn())],
                         [self.v_w_g.update(np.random.randn())],
                         [self.w_w_g.update(np.random.randn())]])
        #gust = np.array([[0.],[0.],[0.]])
        return np.concatenate((self._steady_state, gust))
