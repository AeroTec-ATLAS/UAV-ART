"""
mav_dynamics
    - this file implements the dynamic equations of motion for MAV
    - use unit quaternion for the attitude state
    
part of mavsimPy
    - Beard & McLain, PUP, 2012
    - Update history:  
        12/17/2018 - RWB
        1/14/2019 - RWB
        2/24/2020 - RWB
"""
import sys
import math

sys.path.append('..')
import numpy as np

# load message types
from message_types.msg_state import msgState

import parameters.aerosonde_parameters as MAV

# from tools.rotations import Quaternion2Euler, Quaternion2Rotation


class mavDynamics:
    def __init__(self, Ts):
        self.ts_simulation = Ts
        # set initial states based on parameter file
        # _state is the 12x1 internal state of the aircraft that is being propagated:
        # _state = [pn, pe, pd, u, v, w, phi, theta, psi, p, q, r]
        self._state = np.array([[MAV.pn0],  # (0)
                                [MAV.pe0],  # (1)
                                [MAV.pd0],  # (2)
                                [MAV.u0],  # (3)
                                [MAV.v0],  # (4)
                                [MAV.w0],  # (5)
                                [MAV.phi0],  # (6)
                                [MAV.theta0],  # (7)
                                [MAV.psi0],  # (8)
                                [MAV.p0],  # (9)
                                [MAV.q0],  # (10)
                                [MAV.r0]])  # (11)
        self.true_state = msgState()

    ###################################
    # public functions
    def update(self, forces_moments):
        """
            Integrate the differential equations defining dynamics.
            Inputs are the forces and moments on the aircraft.
            Ts is the time step between function calls.
        """

        # Integrate ODE using Runge-Kutta RK4 algorithm
        time_step = self.ts_simulation
        k1 = self._derivatives(self._state, forces_moments)
        k2 = self._derivatives(self._state + time_step / 2. * k1, forces_moments)
        k3 = self._derivatives(self._state + time_step / 2. * k2, forces_moments)
        k4 = self._derivatives(self._state + time_step * k3, forces_moments)
        self._state += time_step / 6 * (k1 + 2 * k2 + 2 * k3 + k4)

        # normalize the quaternion
        # e0 = self._state.item(6)
        # e1 = self._state.item(7)
        # e2 = self._state.item(8)
        # e3 = self._state.item(9)
        # normE = np.sqrt(e0**2+e1**2+e2**2+e3**2)
        # self._state[6][0] = self._state.item(6)/normE
        # self._state[7][0] = self._state.item(7)/normE
        # self._state[8][0] = self._state.item(8)/normE
        # self._state[9][0] = self._state.item(9)/normE

        # update the message class for the true state
        self._update_true_state()

    ###################################
    # private functions
    def _derivatives(self, state, forces_moments):
        """
        for the dynamics xdot = f(x, u), returns f(x, u)
        """
        # extract the states
        pn = state.item(0)
        pe = state.item(1)
        pd = state.item(2)
        u = state.item(3)
        v = state.item(4)
        w = state.item(5)
        phi = state.item(6)
        theta = state.item(7)
        psi = state.item(8)
        p = state.item(9)
        q = state.item(10)
        r = state.item(11)
        #   extract forces/moments
        fx = forces_moments.item(0)
        fy = forces_moments.item(1)
        fz = forces_moments.item(2)
        l = forces_moments.item(3)
        m = forces_moments.item(4)
        n = forces_moments.item(5)

        # position kinematics
        pn_dot = ((math.cos(theta)) * (math.cos(psi)) * u +
                  ((math.sin(phi)) * (math.sin(theta)) * (math.cos(psi)) - (math.cos(phi)) * (math.sin(psi))) * v +
                  ((math.cos(phi)) * (math.sin(theta)) * (math.cos(psi)) + (math.sin(phi)) * (math.sin(psi))) * w)

        pe_dot = ((math.cos(theta)) * (math.sin(psi)) * u +
                  ((math.sin(phi)) * (math.sin(theta)) * (math.sin(psi)) + (math.cos(phi)) * (math.cos(psi))) * v +
                  ((math.cos(phi)) * (math.sin(theta)) * (math.sin(psi)) - (math.sin(phi)) * (math.cos(psi))) * w)

        pd_dot = ((-math.sin(theta)) * u + ((math.sin(phi)) * (math.cos(theta))) * v +
                  ((math.cos(phi)) * (math.cos(theta))) * w)

        # position dynamics
        u_dot = (r * v - q * w) + (1 / MAV.mass) * fx
        v_dot = (p * w - r * u) + (1 / MAV.mass) * fy
        w_dot = (q * u - p * v) + (1 / MAV.mass) * fz

        # rotational kinematics
        phi_dot = p + ((math.sin(phi)) * (math.tan(theta))) * q + ((math.cos(phi)) * (math.tan(theta))) * r
        theta_dot = (math.cos(phi)) * q + (-math.sin(phi)) * r
        psi_dot = ((math.sin(phi)) / (math.cos(theta))) * q + ((math.cos(phi)) / (math.cos(theta))) * r

        # rotational dynamics
        p_dot = MAV.gamma1 * p * q - MAV.gamma2 * q * r + MAV.gamma3 * l + MAV.gamma4 * n
        q_dot = MAV.gamma5 * p * r - MAV.gamma6 * (p ** 2 - r ** 2) + m / MAV.Jy
        r_dot = MAV.gamma7 * p * q - MAV.gamma1 * q * r + MAV.gamma4 * l + MAV.gamma8 * n

        # collect the derivative of the states
        x_dot = np.array([[pn_dot, pe_dot, pd_dot, u_dot, v_dot, w_dot,
                           phi_dot, theta_dot, psi_dot, p_dot, q_dot, r_dot]]).T
        return x_dot

    def _update_true_state(self):
        # update the true state message:
        # phi, theta, psi = Quaternion2Euler(self._state[6:10])
        self.true_state.pn = self._state.item(0)
        self.true_state.pe = self._state.item(1)
        self.true_state.h = -self._state.item(2)
        self.true_state.phi = self._state.item(6)
        self.true_state.theta = self._state.item(7)
        self.true_state.psi = self._state.item(8)
        self.true_state.p = self._state.item(9)
        self.true_state.q = self._state.item(10)
        self.true_state.r = self._state.item(11)
