import numpy as np
import sys
sys.path.append('..')
#from path_following.dubins_parameters import DubinsParameters
from message_types.msg_path import msgPath

class PathManager:
    def __init__(self):
        # message sent to path follower
        self.i = 0
        self.path = msgPath()
        # pointers to previous, current, and next waypoints
        self.ptr_previous = 0
        self.ptr_current = 1
        self.ptr_next = 2
        self.halfspace_n = np.inf * np.ones((3,1))
        self.halfspace_r = np.inf * np.ones((3,1))
        # state of the manager state machine
        self.manager_state = 1
        self.manager_requests_waypoints = True
        #self.dubins_path = DubinsParameters()
        self.line_Vector_current = np.zeros(3).T
        self.line_Vector_previous = np.zeros(3).T
        
    def update(self, waypoints, radius, state):
        self.i+=1
        if waypoints.num_waypoints == 0:
            self.manager_requests_waypoints = True #WHAT DO WHILE NO WAYPOINTS?

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

    def initialize_pointers(self, waypoints):
        if waypoints.num_waypoints >= 3:
            self.ptr_previous = 0
            self.ptr_current = 1
            self.ptr_next = 2
        else:
            print('Error Path Manager: need at least three waypoints')

    def increment_pointers(self):
        self.ptr_previous += 1
        self.ptr_current += 1
        self.ptr_next += 1

    def line_manager(self, waypoints, state):
        mav_pos = np.array([[state.pn, state.pe, -state.h]]).T
        if (waypoints.flag_waypoints_changed):
            print("initialized first time\n")
            self.initialize_pointers(waypoints)
            waypoints.flag_waypoints_changed=False
        # STEPs 4 to 7 of ALGO 5
        self.halfspace_r = waypoints.ned[:,self.ptr_current]#???????????????????
        self.line_Vector_previous=(waypoints.ned[:,self.ptr_current]-waypoints.ned[:,self.ptr_previous])/np.linalg.norm(waypoints.ned[:,self.ptr_current]-waypoints.ned[:,self.ptr_previous])
        self.line_Vector_current=(waypoints.ned[:,self.ptr_next]-waypoints.ned[:,self.ptr_current])/np.linalg.norm(waypoints.ned[:,self.ptr_next]-waypoints.ned[:,self.ptr_current])
        self.halfspace_n =(self.line_Vector_previous+self.line_Vector_current)/np.linalg.norm(self.line_Vector_previous+self.line_Vector_current)
        # STEP 8
        # if the waypoints have changed, update the waypoint pointer
        self.construct_line(waypoints, mav_pos)
        # state machine for line path
		
    def construct_line(self, waypoints, pos):
        #update path variables
        self.halfspace_r = self.halfspace_r.reshape(3,1)
        self.halfspace_n = self.halfspace_n.reshape(3,1)
        self.line_Vector_previous = self.line_Vector_previous.reshape(3,1)
        self.path.line_origin = self.halfspace_r 
        self.path.line_direction = self.line_Vector_previous
        self.path.airspeed = waypoints.airspeed[self.ptr_current]
        #check for entry into H space
        if (np.vdot(pos-self.halfspace_r, self.halfspace_n)>=0):
            print("pos- ", pos, "\n r= ", self.halfspace_r, "\n = ", pos-self.halfspace_r)
            print("N= ",self.halfspace_n)
            if self.ptr_next < waypoints.num_waypoints-2:
                self.increment_pointers()
                #print("Pointer: ", self.ptr_current)
            else:
                self.initialize_pointers(waypoints)
                print("Re-initialized Waypoints")  
            print("updated waypoint to number: ",self.ptr_current) 
        if self.i == 100:
            print("POS: ", pos)
            print("WP: ",waypoints.ned[:,self.ptr_current])
            print("P")
            print("\n\n")
            self.i=0    
