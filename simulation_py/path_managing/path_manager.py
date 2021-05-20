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
        self.num_waypoints = waypoints.num_waypoints
        if waypoints.flag_waypoints_changed:
            self.initialize_pointers()
            self.manager_state= 1 
        if waypoints.num_waypoints == 0:
            self.manager_requests_waypoints = True
        if self.manager_requests_waypoints is True \
                and waypoints.flag_waypoints_changed is True:
            self.manager_requests_waypoints = False
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
        wi_prev = waypoints.ned[:, self.ptr_previous].reshape(3,1)
        wi = waypoints.ned[:, self.ptr_current].reshape(3,1)
        wi_next = waypoints.ned[:, self.ptr_next].reshape(3,1)

        self.halfspace_r = wi
        qi_prev = wi - wi_prev
        qi_prev = qi_prev / np.linalg.norm(qi_prev)
        qi = wi_next - wi
        qi = qi / np.linalg.norm(qi)
        ni = (qi_prev - qi) / np.linalg.norm(qi_prev - qi)
        self.halfspace_n = ni
        # if the waypoints have changed, update the waypoint pointer
        if self.inHalfSpace(mav_pos) and self.ptr_current < self.num_waypoints - 2:
            self.increment_pointers()
        # state machine for line path
        self.path.type = 'line'
        self.path.line_origin = wi_prev
        self.path.line_direction = qi_prev
        self.path.airspeed = waypoints.airspeed[self.ptr_current]

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
        wi_prev = waypoints.ned[:, self.ptr_previous].reshape(3,1)
        wi = waypoints.ned[:, self.ptr_current].reshape(3,1)
        wi_next = waypoints.ned[:, self.ptr_next].reshape(3,1)

        qi_prev = wi - wi_prev
        qi_prev = qi_prev / np.linalg.norm(qi_prev)
        qi = wi_next - wi
        qi = qi / np.linalg.norm(qi)
        rho = np.arccos(-qi_prev.T @ qi)

        if self.manager_state == 1:
            self.path.type = 'line'
            self.halfspace_r = wi - (radius/np.tan(rho/2.))*qi_prev
            self.halfspace_n = qi_prev
            self.path.line_origin = wi_prev
            self.path.line_direction = qi_prev
            if self.inHalfSpace(mav_pos):
                self.manager_state = 2
                self.path.flag_path_changed = True
        elif  self.manager_state == 2:
            self.path.type = 'orbit'
            self.halfspace_r = wi + (radius/np.tan(rho/2))*qi
            self.halfspace_n = qi
            self.path.orbit_center = wi - radius/np.sin(rho/2.)*(qi_prev-qi)/np.linalg.norm(qi_prev-qi)
            self.path.orbit_radius = radius
            self.path.signToDirection(np.sign((qi_prev.item(0)*qi.item(1))-(qi_prev.item(1)*qi.item(0))))
            if self.inHalfSpace(mav_pos):
                if self.ptr_current < self.num_waypoints - 2:
                    self.increment_pointers()
                self.manager_state = 1
                self.path.flag_path_changed = True
                if self.ptr_next == self.num_waypoints: # if reaching last waypoint, generates the last path
                    wi = waypoints.ned[:, self.ptr_current].reshape(3,1)
                    wi_prev = waypoints.ned[:, self.ptr_previous].reshape(3,1)
                    qi_prev = wi - wi_prev
                    qi_prev = qi_prev / np.linalg.norm(qi_prev)
                    self.path.type = 'line'
                    self.path.line_origin = wi_prev
                    self.path.line_direction = qi_prev
        self.path.airspeed = waypoints.airspeed[self.ptr_current]
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
        mav_pos = np.array([[state.pn, state.pe, -state.h]]).T
        self.dubins_path.update(waypoints.ned[:,self.ptr_previous].reshape(3,1), waypoints.course.item(self.ptr_previous), waypoints.ned[:,self.ptr_current].reshape(3,1), waypoints.course.item(self.ptr_current), radius)
        if self.manager_state == 1:
            self.path.type = 'orbit'
            self.path.orbit_center = self.dubins_path.center_s
            self.path.orbit_radius = self.dubins_path.radius
            self.path.signToDirection(self.dubins_path.dir_s)
            
            self.halfspace_r = self.dubins_path.r1
            self.halfspace_n = -self.dubins_path.n1
            if self.inHalfSpace(mav_pos):
                self.manager_state = 2
                self.path.flag_path_changed = True

        elif self.manager_state == 2:          
            self.halfspace_r = self.dubins_path.r1
            self.halfspace_n = self.dubins_path.n1
            if self.inHalfSpace(mav_pos):
                self.manager_state = 3
                self.path.flag_path_changed = True

        elif self.manager_state == 3:
            self.path.type = 'line'
            self.path.line_origin = self.dubins_path.r1
            self.path.line_direction = self.dubins_path.n1

            self.halfspace_r = self.dubins_path.r2
            self.halfspace_n = self.dubins_path.n1
            if self.inHalfSpace(mav_pos):
                self.manager_state = 4
                self.path.flag_path_changed = True

        elif self.manager_state == 4:
            self.path.type='orbit'
            self.path.orbit_center = self.dubins_path.center_e
            self.path.orbit_radius = self.dubins_path.radius
            self.path.signToDirection(self.dubins_path.dir_e)

            self.halfspace_r = self.dubins_path.r3
            self.halfspace_n = -self.dubins_path.n3
            if self.inHalfSpace(mav_pos):
                self.manager_state = 5
                self.path.flag_path_changed = True

        elif self.manager_state == 5:
            self.halfspace_r = self.dubins_path.r3
            self.halfspace_n = self.dubins_path.n3
            if self.inHalfSpace(mav_pos):
                self.manager_state = 1
                self.path.flag_path_changed = True
                if self.ptr_current < self.num_waypoints - 2:
                    self.increment_pointers()
                self.dubins_path.update(waypoints.ned[:,self.ptr_previous].reshape(3,1), waypoints.course.item(self.ptr_previous), waypoints.ned[:,self.ptr_current].reshape(3,1), waypoints.course.item(self.ptr_current), radius)
        self.path.airspeed = waypoints.airspeed[self.ptr_current]


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
