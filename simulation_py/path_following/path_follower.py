import numpy as np
from math import sin, cos, atan, atan2, sqrt, asin
import sys

sys.path.append('..')
from message_types.msg_autopilot import msgAutopilot

class path_follower:
    def __init__(self):
        self.chi_inf = np.pi / 4  # approach angle for large distance from straight-line path
        self.k_path = 0.05  # proportional gain for straight-line path following
        self.k_orbit = 5  # proportional gain for orbit following
        self.gravity = 9.8
        self.autopilot_commands = msgAutopilot()  # message sent to autopilot

    def update(self, path, state):
        if path.type=='line':
            self._follow_straight_line(path, state)
        elif path.type=='orbit':
            self._follow_orbit(path, state)
        return self.autopilot_commands

    def _follow_straight_line(self, path, state):
        p = np.array([[state.pn, state.pe, -state.h]]).T
        r = path.line_origin
        q = path.line_direction / np.linalg.norm(path.line_direction)
        chi_q = atan2(path.line_direction.item(1), path.line_direction.item(0))
        chi_q = self._wrap(chi_q, state.chi)
        e_p = self._rotateToPath(chi_q) @ (p-r)
        n = np.cross(q.T, np.array([[0, 0, 1]])).T / np.linalg.norm(np.outer(q.T, np.array([[0, 0, 1]])))
        s = e_p - np.inner(e_p, n) * n

        self.autopilot_commands.airspeed_command = path.airspeed
        self.autopilot_commands.course_command = chi_q-self.chi_inf*2/np.pi*atan(self.k_path*e_p.item(1))
        self.autopilot_commands.altitude_command = -r.item(2) - sqrt(s.item(0)**2+s.item(1)**2)*q.item(2)/sqrt(q.item(0)**2+q.item(1)**2)
        self.autopilot_commands.phi_feedforward = 0

    def _follow_orbit(self, path, state):
        Lambda = 0
        c = path.orbit_center
        rho = path.orbit_radius
        if path.orbit_direction == 'CW':
            Lambda = 1
        elif path.orbit_direction == 'CCW':
            Lambda = -1
        p = np.array([[state.pn, state.pe, -state.h]]).T
        d = np.linalg.norm(p - c)
        phi = atan2(p.item(1)-c.item(1), p.item(0)-c.item(0))
        phi = self._wrap(phi, 0)
        self.autopilot_commands.airspeed_command = path.airspeed
        self.autopilot_commands.course_command = phi + Lambda*(np.pi/2+atan(self.k_orbit*(d-rho)/rho))
        self.autopilot_commands.altitude_command = -c.item(2)
        R = rho
        try:
            self.autopilot_commands.phi_feedforward = Lambda*atan(((state.wn*cos(state.chi)+state.we*sin(state.chi))+sqrt(state.Va**2-(state.wn*sin(state.chi)-state.we*cos(state.chi))**2-state.wd**2))**2/(self.gravity*R*sqrt((state.Va**2-(state.wn*sin(state.chi)-state.we*cos(state.chi))**2-state.wd**2)/(state.Va**2-state.wd**2))))
        except:
            self.autopilot_commands.phi_feedforward = 0

    def _wrap(self, chi_c, chi):
        while chi_c-chi > np.pi:
            chi_c = chi_c - 2.0 * np.pi
        while chi_c-chi < -np.pi:
            chi_c = chi_c + 2.0 * np.pi
        return chi_c

    def _rotateToPath(self, chi_q):
        return np.array([[cos(chi_q), sin(chi_q), 0],
                  [-sin(chi_q), cos(chi_q), 0],
                  [0, 0, 1]])

