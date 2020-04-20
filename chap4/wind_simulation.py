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

        steadyStateInBody = Euler2Rotation2(MAV.phi0, MAV.theta0, MAV.psi0) @ self._steady_state
        self.u_w = steadyStateInBody.item(0)
        self.v_w = steadyStateInBody.item(1)
        self.w_w = steadyStateInBody.item(2)
        self._Ts = Ts

    def update(self, Va):
        # returns a six vector.
        #   The first three elements are the steady state wind in the inertial frame
        #   The second three elements are the gust in the body frame
        '''gust = np.array([[self.u_w.update(np.random.randn())],
                         [self.v_w.update(np.random.randn())],
                         [self.w_w.update(np.random.randn())]])'''
        '''
        L_u = 200
        L_v = 200
        L_w = 50
        sigma_u = 1.06
        sigma_v = 1.06
        sigma_w = 0.7

        gust = np.array([[sigma_u * sqrt(2 * Va / L_u) * transferFunction(np.array([[1]]), np.array([[1, Va / L_u]]), SIM.ts_plotting)],
                         [sigma_v * sqrt(3 * Va / L_v) * transferFunction(np.array([[1, Va / (sqrt(3) * L_v)]]), np.array([[1, 2 * Va / L_v, (Va / L_v)**2]]), SIM.ts_plotting)],
                         [sigma_w * sqrt(3 * Va / L_w) * transferFunction(np.array([[1, Va / (sqrt(3) * L_w)]]), np.array([[1, 2 * Va / L_w, (Va / L_w)**2]]), SIM.ts_plotting)]])
        '''
        gust = np.array([[np.random.randn() * self._steady_state.item(0) / 20],
                         [np.random.randn() * self._steady_state.item(1) / 20],
                         [np.random.randn() * self._steady_state.item(2) / 20]])
        steadyStateInBody = Euler2Rotation2(MAV.phi0, MAV.theta0, MAV.psi0) @ self._steady_state
        self.u_w = steadyStateInBody.item(0) + gust.item(0)
        self.v_w = steadyStateInBody.item(1) + gust.item(1)
        self.w_w = steadyStateInBody.item(2) + gust.item(2)
        return np.concatenate((self._steady_state, gust))
