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
from message_types.msg_sensors import msgSensors

import parameters.aerosonde_parameters as MAV
from tools.rotations import Quaternion2Rotation, Quaternion2Euler, Euler2Rotation, Euler2Rotation2
from tools.telemetry_Data import telemetryData

class mavDynamics:
    def __init__(self, Ts, localIP='', raspIP=''):
        self._ts_simulation = Ts
        # set initial states based on parameter file
        # _state is the 13x1 internal state of the aircraft that is being propagated:
        # _state = [pn, pe, pd, u, v, w, e0, e1, e2, e3, p, q, r]
        # We will also need a variety of other elements that are functions of the _state and the wind.
        # self.true_state is a 19x1 vector that is estimated and used by the autopilot to control the aircraft:
        # true_state = [pn, pe, h, Va, alpha, beta, phi, theta, chi, p, q, r, Vg, wn, we, psi, gyro_bx, gyro_by, gyro_bz]
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
        # store wind data for fast recall since it is used at various points in simulation
        self._wind = np.array([[0.], [0.], [0.]])  # wind in NED frame in meters/sec
        self._update_velocity_data()
        # store forces to avoid recalculation in the sensors function
        self._forces = np.array([[], [], []])
        self._Va = math.sqrt(self._state.item(3)**2 + self._state.item(4)**2 + self._state.item(5)**2)
        self._alpha = np.arctan2(self._state.item(5), self._state.item(3))
        self._beta = np.arcsin(self._state.item(4) / self._Va)
        # initialize true_state message
        self.true_state = msgState()
        self.telemetry = telemetryData(localIP, raspIP)
        self.sensors = msgSensors()

    ###################################
    # public functions
    def update(self, delta, wind):
        """
            Integrate the differential equations defining dynamics, update sensors
            delta = (delta_a, delta_e, delta_r, delta_t) are the control inputs
            wind is the wind vector in inertial coordinates
            Ts is the time step between function calls.
        """
        gustInInertial = Euler2Rotation(self._state.item(6), self._state.item(7), self._state.item(8)) @ wind[3:6]
        self._wind = wind[0:3] + gustInInertial
        # get forces and moments acting on rigid bod
        forces_moments = self._forces_moments(delta)

        # Integrate ODE using Runge-Kutta RK4 algorithm
        time_step = self._ts_simulation
        k1 = self._derivatives(self._state, forces_moments)
        k2 = self._derivatives(self._state + time_step / 2. * k1, forces_moments)
        k3 = self._derivatives(self._state + time_step / 2. * k2, forces_moments)
        k4 = self._derivatives(self._state + time_step * k3, forces_moments)
        self._state += time_step / 6 * (k1 + 2 * k2 + 2 * k3 + k4)

        # normalize the quaternion
        '''e0 = self._state.item(6)
        e1 = self._state.item(7)
        e2 = self._state.item(8)
        e3 = self._state.item(9)
        normE = np.sqrt(e0**2 + e1**2 + e2**2 + e3**2)
        self._state[6][0] = self._state.item(6) / normE
        self._state[7][0] = self._state.item(7) / normE
        self._state[8][0] = self._state.item(8) / normE
        self._state[9][0] = self._state.item(9) / normE'''

        # update the airspeed, angle of attack, and side slip angles using new state
        self._update_velocity_data(wind)

        # update the message class for the true state
        self._update_sensors()
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

        # transforma os quarterniões em angulos de euler de modo a calcular as variaveis cinematicas
        # phi, theta, psi = Quaternion2Euler(self._state[6:10])
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

    def _update_velocity_data(self, wind=np.zeros((6, 1))):
        steady_state = wind[0:3]
        gust = wind[3:6]
        steadyStateInBody = Euler2Rotation2(MAV.phi0, MAV.theta0, MAV.psi0) @ steady_state
        u_w = steadyStateInBody.item(0) + gust.item(0)
        v_w = steadyStateInBody.item(1) + gust.item(1)
        w_w = steadyStateInBody.item(2) + gust.item(2)
        u_r = self._state.item(3) - u_w
        v_r = self._state.item(4) - v_w
        w_r = self._state.item(5) - w_w
        self._Va = math.sqrt(u_r**2 + v_r**2 + w_r**2)
        self._alpha = np.arctan2(w_r, u_r)
        self._beta = np.arcsin(v_r / self._Va)

    def _forces_moments(self, delta):
        """
        return the forces on the UAV based on the state, wind, and control surfaces
        :param delta: np.matrix(delta_a, delta_e, delta_r, delta_t)
        :return: Forces and Moments on the UAV np.matrix(Fx, Fy, Fz, Ml, Mn, Mm)
        """
        phi = self._state.item(6)
        theta = self._state.item(7)
        psi = self._state.item(8)
        p = self._state.item(9)
        q = self._state.item(10)
        r = self._state.item(11)
        Va = self._Va
        alpha = self._alpha
        beta = self._beta

        delta_e = delta.elevator
        delta_a = delta.aileron
        delta_r = delta.rudder
        delta_t = delta.throttle

        mass = MAV.mass
        g = MAV.gravity

        sigma = (1 + math.exp(-MAV.M * (alpha - MAV.alpha0)) + math.exp(MAV.M * (alpha + MAV.alpha0))) / \
                ((1 + math.exp(-MAV.M * (alpha - MAV.alpha0))) * (1 + math.exp(MAV.M * (alpha + MAV.alpha0))))
        C_L = (1 - sigma) * (MAV.C_L_0 + MAV.C_L_alpha * alpha) + sigma * 2 * np.sign(alpha) * ((math.sin(alpha))**2) * math.cos(alpha)
        C_D = MAV.C_D_p + (MAV.C_L_0 + MAV.C_L_alpha * alpha)**2 / (math.pi * MAV.e * MAV.AR)
        C_X = -C_D * math.cos(alpha) + C_L * math.sin(alpha)
        C_X_q = -MAV.C_D_q * math.cos(alpha) + MAV.C_L_q * math.sin(alpha)
        C_X_delta_e = -MAV.C_D_delta_e * math.cos(alpha) + MAV.C_L_delta_e * math.sin(alpha)
        C_Z = -C_D * math.sin(alpha) - C_L * math.cos(alpha)
        C_Z_q = -MAV.C_D_q * math.sin(alpha) - MAV.C_L_q * math.cos(alpha)
        C_Z_delta_e = -MAV.C_D_delta_e * math.sin(alpha) - MAV.C_L_delta_e * math.cos(alpha)

        S_prop = math.pi * (MAV.D_prop / 2)**2

        f_grav = np.array([-mass * g * math.sin(theta),
                           mass * g * math.cos(theta) * math.sin(phi),
                           mass * g * math.cos(theta) * math.cos(phi)])

        f_aero = 0.5 * MAV.rho * (Va**2) * MAV.S_wing * \
            np.array([C_X + C_X_q * MAV.c / (2 * Va) * q + C_X_delta_e * delta_e,
                      MAV.C_Y_0 + MAV.C_Y_beta * beta + MAV.C_Y_p * MAV.b / (2 * Va) * p + MAV.C_Y_r * MAV.b / (2 * Va) * r + MAV.C_Y_delta_a * delta_a + MAV.C_Y_delta_r * delta_r,
                      C_Z + C_Z_q * MAV.c / (2 * Va) * q + C_Z_delta_e * delta_e])
        m_aero = 0.5 * MAV.rho * (Va**2) * MAV.S_wing * \
            np.array([MAV.b * (MAV.C_ell_0 + MAV.C_ell_beta * beta + MAV.C_ell_p * MAV.b / (2 * Va) * p + MAV.C_ell_r * MAV.b / (2 * Va) * r + MAV.C_ell_delta_a * delta_a + MAV.C_ell_delta_r * delta_r),
                      MAV.c * (MAV.C_m_0 + MAV.C_m_alpha * alpha + MAV.C_m_q * MAV.c / (2 * Va) * q + MAV.C_m_delta_e * delta_e),
                      MAV.b * (MAV.C_n_0 + MAV.C_n_beta * beta + MAV.C_n_p * MAV.b / (2 * Va) * p + MAV.C_n_r * MAV.b / (2 * Va) * r + MAV.C_n_delta_a * delta_a + MAV.C_n_delta_r * delta_r)])

        T_p, Q_p = self._motor_thrust_torque(Va, delta_t)
        f_prop = np.array([T_p,
                           0,
                           0]).T
        m_prop = np.array([Q_p,
                           0,
                           0]).T

        f_sum = f_grav + f_aero + f_prop
        moments = m_aero + m_prop
        fx = f_sum.item(0)
        fy = f_sum.item(1)
        fz = f_sum.item(2)
        l = moments.item(0)
        m = moments.item(1)
        n = moments.item(2)

        self._forces[0] = fx
        self._forces[1] = fy
        self._forces[2] = fz
        return np.array([[fx, fy, fz, l, m, n]]).T

    def _motor_thrust_torque(self, Va, delta_t):
        V_in = MAV.V_max * delta_t
        a = MAV.rho * MAV.D_prop**5 / (2 * math.pi)**2 * MAV.C_Q0
        b = MAV.rho * MAV.D_prop**4 / (2 * math.pi) * MAV.C_Q1 * Va + MAV.KQ**2 / MAV.R_motor
        c = MAV.rho * MAV.D_prop**3 * MAV.C_Q2 * Va**2 - MAV.KQ / MAV.R_motor * V_in + MAV.KQ * MAV.i0
        sigma_p = (-b + math.sqrt(b**2 - 4 * a * c)) / (2 * a)

        T_p = 0.5 * MAV.rho * MAV.S_prop * MAV.C_prop * ((MAV.K_motor * delta_t)**2 - Va**2)
        Q_p = -MAV.K_tp * (MAV.K_omega * delta_t)**2
        #T_p = MAV.rho * MAV.C_T0 * MAV.D_prop**4 / (4 * math.pi**2) * sigma_p**2 + MAV.rho * MAV.C_T1 * Va * MAV.D_prop**3 / (2 * math.pi) * sigma_p + MAV.rho * MAV.C_T2 * MAV.D_prop**2 * Va**2
        #Q_p = MAV.rho * MAV.C_Q0 * MAV.D_prop**5 / (4 * math.pi**2) * sigma_p**2 + MAV.rho * MAV.C_Q1 * Va * MAV.D_prop**4 / (2 * math.pi) * sigma_p + MAV.rho * MAV.C_Q2 * MAV.D_prop**3 * Va**2
        return T_p, Q_p

    def _update_true_state(self):
        # update the class structure for the true state:
        #   [pn, pe, h, Va, alpha, beta, phi, theta, chi, p, q, r, Vg, wn, we, psi, gyro_bx, gyro_by, gyro_bz]
        # phi, theta, psi = Quaternion2Euler(self._state[6:10])
        # pdot = Quaternion2Rotation(self._state[6:10]) @ self._state[3:6]
        pdot = Euler2Rotation(self._state[6], self._state[7], self._state[8]) @ self._state[3:6]
        self.true_state.pn = self._state.item(0)
        self.true_state.pe = self._state.item(1)
        self.true_state.h = -self._state.item(2)
        self.true_state.Va = self._Va
        self.true_state.alpha = self._alpha
        self.true_state.beta = self._beta
        self.true_state.phi = self._state.item(6)
        self.true_state.theta = self._state.item(7)
        self.true_state.psi = self._state.item(8)
        self.true_state.Vg = np.linalg.norm(pdot)
        self.true_state.gamma = np.arcsin(pdot.item(2) / self.true_state.Vg)
        self.true_state.chi = np.arctan2(pdot.item(1), pdot.item(0))
        self.true_state.p = self._state.item(9)
        self.true_state.q = self._state.item(10)
        self.true_state.r = self._state.item(11)
        self.true_state.wn = self._wind.item(0)
        self.true_state.we = self._wind.item(1)
        self.true_state.wd = self._wind.item(2)

    def _update_sensors(self):
        vehicle = self.telemetry.vehicle
        self.sensors.gyro_x = vehicle.highres_imu.xgyro
        self.sensors.gyro_y = vehicle.highres_imu.ygyro
        self.sensors.gyro_z = vehicle.highres_imu.zgyro
        self.sensors.accel_x = vehicle.highres_imu.xacc
        self.sensors.accel_y = vehicle.highres_imu.yacc
        self.sensors.accel_z = vehicle.highres_imu.zacc
        self.sensors.mag_x = vehicle.highres_imu.xmag
        self.sensors.mag_y = vehicle.highres_imu.ymag
        self.sensors.mag_z = vehicle.highres_imu.zmag
        self.sensors.abs_pressure = vehicle.highres_imu.abs_pressure
        self.sensors.diff_pressure = vehicle.highres_imu.diff_pressure
        self.sensors.gps_n = vehicle.gps_raw_int.lat
        self.sensors.gps_e = vehicle.gps_raw_int.lon
        self.sensors.gps_h = vehicle.gps_raw_int.alt
        self.sensors.gps_Vg = vehicle.gps_raw_int.vel
        self.sensors.gps_course = vehicle.gps_raw_int.cog