import numpy as np
import sys
sys.path.append('..')
from path_managing.dubins_parameters import dubinsParameters
from message_types.msg_path import msgPath


class pathManager:
    def __init__(self):
        # message sent to path follower
        self.path = msgPath()
        # pointers to previous, current, and next waypoints
        self.ptr_previous = 0
        self.ptr_current = 1
        self.ptr_next = 2
        self.num_waypoints = 0
        self.halfspace_n = np.inf * np.ones((3,1))
        self.halfspace_r = np.inf * np.ones((3,1))
        # state of the manager state machine
        self.manager_state = 1
        self.manager_requests_waypoints = True
        self.dubins_path = dubinsParameters()

    def update(self, waypoints, radius, state):
        if waypoints.flag_waypoints_changed:
            self.initialize_pointers()
        self.num_waypoints = waypoints.num_waypoints
        if waypoints.num_waypoints == 0:
            self.manager_requests_waypoints = True
        if self.manager_requests_waypoints is True \
                and waypoints.flag_waypoints_changed is True:
            self.manager_requests_waypoints = False
        if self.ptr_next <= self.num_waypoints - 1:
            if waypoints.type == 'straight_line':
                self.line_manager(waypoints, state)
            elif waypoints.type == 'fillet':
                self.fillet_manager(waypoints, radius, state)
            elif waypoints.type == 'dubins':
                self.dubins_manager(waypoints, radius, state)
            else:
                print('Error in Path Manager: Undefined waypoint type.')
        return self.path

    def initialize_pointers(self):
        if self.num_waypoints >= 3:
            self.ptr_previous = 0
            self.ptr_current = 1
            self.ptr_next = 2
        else:
            print('Error Path Manager: need at least three waypoints')

    def increment_pointers(self):
        self.ptr_previous += 1
        self.ptr_current += 1
        self.ptr_next += 1

    def inHalfSpace(self, pos):
        if ((pos-self.halfspace_r).T @ self.halfspace_n) >= 0: #implement code here
            return True
        else:
            return False

    def line_manager(self, waypoints, state):
        mav_pos = np.array([[state.pn, state.pe, -state.h]]).T
        wi_prev = waypoints.ned[:, self.ptr_previous]
        wi = waypoints.ned[:, self.ptr_current]
        wi_next = waypoints.ned[:, self.ptr_next]

        self.halfspace_r = np.array([wi]).T
        qi_prev = wi - wi_prev
        qi_prev = qi_prev / np.linalg.norm(qi_prev)
        qi = wi_next - wi
        qi = qi / np.linalg.norm(qi)
        ni = (qi_prev - qi) / np.linalg.norm(qi_prev - qi)
        self.halfspace_n = np.array([ni]).T
        # if the waypoints have changed, update the waypoint pointer
        if self.inHalfSpace(mav_pos):
            self.increment_pointers()
        # state machine for line path
        self.path.type = 'line'
        self.path.line_origin = np.array([wi_prev]).T
        self.path.line_direction = np.array([qi_prev]).T

    def construct_line(self, waypoints):
        previous = waypoints.ned[:, self.ptr_previous:self.ptr_previous+1]
        if self.ptr_current == 9999:
            current = NotImplemented
        else:
            current = NotImplemented
        if self.ptr_next == 9999:
            next = NotImplemented
        else:
            next = NotImplemented
        #update path variables

    def fillet_manager(self, waypoints, radius, state):
        mav_pos = np.array([[state.pn, state.pe, -state.h]]).T
        wi_prev = waypoints.ned[:, self.ptr_previous]
        wi = waypoints.ned[:, self.ptr_current]
        wi_next = waypoints.ned[:, self.ptr_next]

        qi_prev = wi - wi_prev
        qi_prev = qi_prev / np.linalg.norm(qi_prev)
        qi = wi_next - wi
        qi = qi / np.linalg.norm(qi)
        rho = np.arccos(-qi_prev.T @ qi)

        if self.manager_state == 1:
            self.path.type = 'line'
            self.halfspace_r = np.array([wi - (radius/np.tan(rho/2.))*qi_prev]).T
            self.halfspace_n = np.array([qi_prev]).T
            self.path.line_origin = np.array([wi_prev]).T
            self.path.line_direction = np.array([qi_prev]).T
            if self.inHalfSpace(mav_pos):
                self.manager_state = 2
                self.path.flag_path_changed = True
        elif  self.manager_state == 2:
            self.path.type = 'orbit'
            self.halfspace_r = np.array([wi + (radius/np.tan(rho/2))*qi]).T
            self.halfspace_n = np.array([qi]).T
            self.path.orbit_center = wi - radius/np.sin(rho/2.)*(qi_prev-qi)/np.linalg.norm(qi_prev-qi)
            self.path.orbit_radius = radius
            self.path.signToDirection(np.sign((qi_prev.item(0)*qi.item(1))-(qi_prev.item(1)*qi.item(0))))
            a=np.sign((qi_prev.item(0)*qi.item(1))-(qi_prev.item(1)*qi.item(0)))
            if self.inHalfSpace(mav_pos):
                self.increment_pointers()
                self.manager_state = 1
                self.path.flag_path_changed = True
        # if the waypoints have changed, update the waypoint pointer

        # state machine for fillet path

    def construct_fillet_line(self, waypoints, radius):
        previous = waypoints.ned[:, self.ptr_previous:self.ptr_previous+1]
        if self.ptr_current == 9999:
            current = NotImplemented
        else:
            current = NotImplemented
        if self.ptr_next == 9999:
            next = NotImplemented
        else:
            next = NotImplemented
        #update path variables
       

    def construct_fillet_circle(self, waypoints, radius):
        previous = waypoints.ned[:, self.ptr_previous:self.ptr_previous+1]
        if self.ptr_current == 9999:
            current = NotImplemented
        else:
            current = NotImplemented
        if self.ptr_next == 9999:
            next = NotImplemented
        else:
            next = NotImplemented
         #update path variables

    def dubins_manager(self, waypoints, radius, state):
        mav_pos = np.array([[state.north, state.east, -state.altitude]]).T
        # if the waypoints have changed, update the waypoint pointer

        # state machine for dubins path

    def construct_dubins_circle_start(self, waypoints, dubins_path):
        #update path variables
        pass
    def construct_dubins_line(self, waypoints, dubins_path):
        #update path variables
        pass
    def construct_dubins_circle_end(self, waypoints, dubins_path):
        #update path variables
        pass
