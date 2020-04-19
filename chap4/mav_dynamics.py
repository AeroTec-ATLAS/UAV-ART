"""
mavDynamics 
    - this file implements the dynamic equations of motion for MAV
    - use unit quaternion for the attitude state
    
part of mavPySim 
    - Beard & McLain, PUP, 2012
    - Update history:  
        12/20/2018 - RWB
        2/24/2020
"""
import sys
sys.path.append('..')
import numpy as np
import math

# load message types
from message_types.msg_state import msgState

import parameters.aerosonde_parameters as MAV
from tools.rotations import Quaternion2Rotation, Quaternion2Euler


class mavDynamics:
    def __init__(self, Ts):
        self._ts_simulation = Ts
        # set initial states based on parameter file
        # _state is the 13x1 internal state of the aircraft that is being propagated:
        # _state = [pn, pe, pd, u, v, w, e0, e1, e2, e3, p, q, r]
        # We will also need a variety of other elements that are functions of the _state and the wind.
        # self.true_state is a 19x1 vector that is estimated and used by the autopilot to control the aircraft:
        # true_state = [pn, pe, h, Va, alpha, beta, phi, theta, chi, p, q, r, Vg, wn, we, psi, gyro_bx, gyro_by, gyro_bz]
        self._state = np.array([[MAV.pn0],  # (0)
                               [MAV.pe0],   # (1)
                               [MAV.pd0],   # (2)
                               [MAV.u0],    # (3)
                               [MAV.v0],    # (4)
                               [MAV.w0],    # (5)
                               [MAV.e0],    # (6)
                               [MAV.e1],    # (7)
                               [MAV.e2],    # (8)
                               [MAV.e3],    # (9)
                               [MAV.p0],    # (10)
                               [MAV.q0],    # (11)
                               [MAV.r0]])   # (12)
        # store wind data for fast recall since it is used at various points in simulation
        self._wind = np.array([[0.], [0.], [0.]])  # wind in NED frame in meters/sec
        self._update_velocity_data()
        # store forces to avoid recalculation in the sensors function
        self._forces = np.array([[], [], []])
        self._Va = math.sqrt(self._state.item(3)**2 +  self._state.item(4)**2 + self._state.item(5)**2) #
        self._alpha = np.arctan2(self._state.item(5), self._state.item(3))
        self._beta = np.arcsin(self._state.item(4)/ self._Va)
        # initialize true_state message
        self.true_state = msgState()

    ###################################
    # public functions
    def update(self, delta, wind):
        """
            Integrate the differential equations defining dynamics, update sensors
            delta = (delta_a, delta_e, delta_r, delta_t) are the control inputs
            wind is the wind vector in inertial coordinates
            Ts is the time step between function calls.
        """
        # get forces and moments acting on rigid bod
        forces_moments = self._forces_moments(delta)

        # Integrate ODE using Runge-Kutta RK4 algorithm
        time_step = self._ts_simulation
        k1 = self._derivatives(self._state, forces_moments)
        k2 = self._derivatives(self._state + time_step/2.*k1, forces_moments)
        k3 = self._derivatives(self._state + time_step/2.*k2, forces_moments)
        k4 = self._derivatives(self._state + time_step*k3, forces_moments)
        self._state += time_step/6 * (k1 + 2*k2 + 2*k3 + k4)

        # normalize the quaternion
        e0 = self._state.item(6)
        e1 = self._state.item(7)
        e2 = self._state.item(8)
        e3 = self._state.item(9)
        normE = np.sqrt(e0**2+e1**2+e2**2+e3**2)
        self._state[6][0] = self._state.item(6)/normE
        self._state[7][0] = self._state.item(7)/normE
        self._state[8][0] = self._state.item(8)/normE
        self._state[9][0] = self._state.item(9)/normE

        # update the airspeed, angle of attack, and side slip angles using new state
        self._update_velocity_data(wind)

        # update the message class for the true state
        self._update_true_state()

    def external_set_state(self, new_state):
        self._state = new_state

    ###################################
    # private functions
    def _derivatives(self, state, forces_moments):
        """
        for the dynamics xdot = f(x, u), returns f(x, u)
        """
        # extract the states
        # pn = state.item(0)
        # pe = state.item(1)
        # pd = state.item(2)
        u = state.item(3)
        v = state.item(4)
        w = state.item(5)
        e0 = state.item(6)
        e1 = state.item(7)
        e2 = state.item(8)
        e3 = state.item(9)
        p = state.item(10)
        q = state.item(11)
        r = state.item(12)
        #   extract forces/moments
        fx = forces_moments.item(0)
        fy = forces_moments.item(1)
        fz = forces_moments.item(2)
        l = forces_moments.item(3)
        m = forces_moments.item(4)
        n = forces_moments.item(5)

        #transforma os quarterniões em angulos de euler de modo a calcular as variaveis cinematicas
        phi, theta, psi = Quaternion2Euler(self._state[6:10])
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
                           e0_dot, e1_dot, e2_dot, e3_dot, p_dot, q_dot, r_dot]]).T
        return x_dot

    def _update_velocity_data(self, wind=np.zeros((6,1))):
        steady_state = wind[0:3]
        gust = wind[3:6]
        self._Va = math.sqrt(self._state.item(3)**2 +  self._state.item(4)**2 + self._state.item(5)**2) #
        self._alpha = np.arctan2(self._state.item(5), self._state.item(3))
        self._beta = np.arcsin(self._state.item(4)/ self._Va)

    def _forces_moments(self, delta):
        """
        return the forces on the UAV based on the state, wind, and control surfaces
        :param delta: np.matrix(delta_a, delta_e, delta_r, delta_t)
        :return: Forces and Moments on the UAV np.matrix(Fx, Fy, Fz, Ml, Mn, Mm)
        """
        phi, theta, psi = Quaternion2Euler(self._state[6:10])
        p = self._state.item(10)
        q = self._state.item(11)
        r = self._state.item(12)

        delta_e = delta.item(0)
        delta_a = delta.item(1)
        delta_r = delta.item(2)
        delta_t = delta.item(3)

        Massa = MAV.mass
        g= MAV.gravity
        S_prop= (MAV.D_prop/2)*math.pi

        f_grav = np.array ([-Massa*g* math.sin(theta),
                            Massa*g* math.cos(theta)*math.sin(phi),
                            Massa*g* math.cos(theta)*math.cos(phi)])

        f_prop = np.array ([0.5 * MAV.rho * S_prop *MAV.C_prop*((MAV.K_motor*delta_t)**2-self._Va**2),
                    0,
                    0])

        fresultante = f_grav + f_prop
        fx = fresultante[0]
        fy = fresultante[1]
        fz = fresultante[2]
        Mx =0
        My =0
        Mz =0

        self._forces[0] = fx
        self._forces[1] = fy
        self._forces[2] = fz
        return np.array([[fx, fy, fz, Mx, My, Mz]]).T

    def _motor_thrust_torque(self, Va, delta_t):
        T_p = -MAV.K_tp*(MAV.K_omega*delta_t)
        #Ainda falta o Q_p mas nao sei como calcular
        return T_p, Q_p


    def _update_true_state(self):
        # update the class structure for the true state:
        #   [pn, pe, h, Va, alpha, beta, phi, theta, chi, p, q, r, Vg, wn, we, psi, gyro_bx, gyro_by, gyro_bz]
        phi, theta, psi = Quaternion2Euler(self._state[6:10])
        pdot = Quaternion2Rotation(self._state[6:10]) @ self._state[3:6]
        self.true_state.pn = self._state.item(0)
        self.true_state.pe = self._state.item(1)
        self.true_state.h = -self._state.item(2)
        self.true_state.Va = self._Va
        self.true_state.alpha = self._alpha
        self.true_state.beta = self._beta
        self.true_state.phi = phi
        self.true_state.theta = theta
        self.true_state.psi = psi
        self.true_state.Vg = np.linalg.norm(pdot)
        self.true_state.gamma = np.arcsin(pdot.item(2) / self.true_state.Vg)
        self.true_state.chi = np.arctan2(pdot.item(1), pdot.item(0))
        self.true_state.p = self._state.item(10)
        self.true_state.q = self._state.item(11)
        self.true_state.r = self._state.item(12)
        self.true_state.wn = self._wind.item(0)
        self.true_state.we = self._wind.item(1)
