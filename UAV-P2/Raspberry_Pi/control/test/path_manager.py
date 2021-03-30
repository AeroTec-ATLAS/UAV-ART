import numpy as np
import sys
sys.path.append('..')
from dubins_parameters import DubinsParameters
from message_types.msg_path import MsgPath

class PathManager:
    def __init__(self):
        # message sent to path follower
        self.path = MsgPath()
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
        self.dubins_path = DubinsParameters()
        self.line_Vector_current = np.zeros(3).T
        self.line_Vector_previous = np.zeros(3).T

    def update(self, waypoints, radius, state):
        if waypoints.num_waypoints == 0:
            self.manager_requests_waypoints = True
			#WHAT DO WHILE NO WAYPOINTS?

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
        self.num_waypoints = waypoints.num_waypoints
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
        if (np.vdot(pos-self.halfspace_r, self.halfspace_n) <= 0):
            return True
        else:
            return False

    def line_manager(self, waypoints, state):
       
	   mav_pos = np.array([[state.pn, state.pe, -state.h]]).T
        if (waypoints.flag_waypoints_changed):
            initialize_pointers()

		# STEPs 4 to 7 of ALGO 5
        self.halfspace_r = waypoints.ned[:,ptr_previous]
        self.line_Vector_previous=(waypoints.ned[:,ptr_current]-waypoints.ned[:,ptr_previous])/np.linalg.norm(waypoints.ned[:,ptr_current]-waypoints.ned[:,ptr_previous])
        self.line_Vector_current=(waypoints.ned[:,ptr_next]-waypoints.ned[:,ptr_current])/np.linalg.norm(waypoints.ned[:,ptr_next]-waypoints.ned[:,ptr_current])
        self.halfspace_n =(self.line_Vector_previous+self.line_Vector_current)/np.linalg.norm(self.line_Vector_previous+self.line_Vector_current)
        # STEP 8
        # if the waypoints have changed, update the waypoint pointer
        if (inHalfSpace(mav_pos)):
			construct_line(waypoints)

		# state machine for line path
		
    def construct_line(self, waypoints):
       # previous = waypoints.ned[:, self.ptr_previous:self.ptr_previous+1]
        if self.ptr_next == self.num_waypoints:
			initialize_pointers(waypoints)
        else:
			increment_pointers()
		#update path variables
        self.path.line_origin = halfspace_r
        self.path.line_direction = self.line_Vector_previous
        self.path.airspeed = waypoints.airspeed()

    def fillet_manager(self, waypoints, radius, state):
        mav_pos = np.array([[state.north, state.east, -state.altitude]]).T
        # if the waypoints have changed, update the waypoint pointer

        # state machine for fillet path

    def construct_fillet_line(self, waypoints, radius):
        previous = waypoints.ned[:, self.ptr_previous:self.ptr_previous+1]
        if self.ptr_current == 9999:
            current =
        else:
            current =
        if self.ptr_next == 9999:
            next =
        else:
            next =
        #update path variables

    def construct_fillet_circle(self, waypoints, radius):
        previous = waypoints.ned[:, self.ptr_previous:self.ptr_previous+1]
        if self.ptr_current == 9999:
            current =
        else:
            current =
        if self.ptr_next == 9999:
            next =
        else:
            next =
         #update path variables

    def dubins_manager(self, waypoints, radius, state):
        mav_pos = np.array([[state.north, state.east, -state.altitude]]).T
        # if the waypoints have changed, update the waypoint pointer

        # state machine for dubins path

    def construct_dubins_circle_start(self, waypoints, dubins_path):
        #update path variables

    def construct_dubins_line(self, waypoints, dubins_path):
        #update path variables

    def construct_dubins_circle_end(self, waypoints, dubins_path):
        #update path variables

