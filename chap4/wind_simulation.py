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
import numpy as np


class windSimulation:
    def __init__(self, Ts):
        # steady state wind defined in the inertial frame
        self._steady_state = np.array([[0., 0., 0.]]).T

        steadyStateInBody = Euler2Rotation2(MAV.phi0,MAV.theta0,MAV.psi0) @ self._steady_state
        self.u_w = steadyStateInBody.item(0)
        self.v_w = steadyStateInBody.item(1)
        self.w_w = steadyStateInBody.item(2)
        self._Ts = Ts

    def update(self):
        # returns a six vector.
        #   The first three elements are the steady state wind in the inertial frame
        #   The second three elements are the gust in the body frame
        '''gust = np.array([[self.u_w.update(np.random.randn())],
                         [self.v_w.update(np.random.randn())],
                         [self.w_w.update(np.random.randn())]])'''
        gust = np.array([[0.],[0.],[0.]])
        return np.concatenate((self._steady_state, gust))
