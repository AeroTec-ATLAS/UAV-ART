import numpy as np
from math import sin, cos, atan, atan2, sqrt
import sys

sys.path.append('..')
from message_types.msg_autopilot import msgAutopilot

class path_follower:
    def __init__(self):
        self.chi_inf = np.pi/4  # approach angle for large distance from straight-line path
        self.k_path = 0.05  # proportional gain for straight-line path following
        self.k_orbit = 0  # proportional gain for orbit following
        self.gravity = 9.8
        self.autopilot_commands = msgAutopilot()  # message sent to autopilot

    def update(self, path, state):
        if path.flag=='line':
            self._follow_straight_line(path, state)
        elif path.flag=='orbit':
            self._follow_orbit(path, state)
        return self.autopilot_commands

    def _follow_straight_line(self, path, state):
        p = np.array([[state.pn, state.pe, -state.h]]).T
        r = path.line_origin
        q = path.line_direction
        chi_q = atan2(path.line_direction.item(1), path.line_direction.item(0))
        chi_q = self._wrap(chi_q, state.chi)
        e_p = self._rotateToPath(chi_q) @ (p-r)
        n = np.cross(q.T, np.array([[0, 0, -1]])).T / np.linalg.norm(np.outer(q, np.array([[0, 0, -1]]).T))
        s = e_p - np.inner(e_p, n) * n

        self.autopilot_commands.airspeed_command = 35
        self.autopilot_commands.course_command = chi_q-self.chi_inf*2/np.pi*atan(self.k_path*e_p.item(1))
        self.autopilot_commands.altitude_command = -path.line_origin.item(2) + sqrt(s.item(0)**2+s.item(1)**2)*path.line_direction.item(2)/sqrt(path.line_direction.item(0)**2+path.line_direction.item(1)**2)
        self.autopilot_commands.phi_feedforward = 0

    def _follow_orbit(self, path, state):
        self.autopilot_commands.airspeed_command = 0
        self.autopilot_commands.course_command = 0
        self.autopilot_commands.altitude_command = 0
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

