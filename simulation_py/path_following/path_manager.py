import numpy as np
import sys
import math
sys.path.append('..')
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
        self.maneuverStep = 0
        self.line_Vector_current = np.zeros(3).T
        self.line_Vector_previous = np.zeros(3).T
        self.Waypoint0 = [0,0,0]
        self.Waypoint1 = self.Waypoint0
        
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
            self.Waypoint0 = waypoints.ned[:,self.ptr_previous]
            self.Waypoint1 = waypoints.ned[:,self.ptr_current]
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
        self.path.line_direction = self.line_Vector_previous#q<-qi-1
        self.path.airspeed = waypoints.airspeed[self.ptr_current]
        #check for entry into H space
        if (np.vdot(pos-self.halfspace_r, self.halfspace_n)>=0):
            if self.ptr_next < waypoints.num_waypoints-1:
                self.increment_pointers()
                #print("Pointer: ", self.ptr_current)
            else:           
                self.initialize_pointers(waypoints)
                print("Re-initialized Waypoints")  
            print("updated waypoint to number: ",self.ptr_current) 
        if self.i == 200:
            print("POS: ", pos)
            print("WP: ",waypoints.ned[:,self.ptr_current])
            print("P")
            print("\n\n")
            self.i=0
                 
    def fillet_manager(self, waypoints, filletRadius, state):
        self.i+=1
        mav_pos = np.array([[state.pn, state.pe, -state.h]]).T
        if (waypoints.flag_waypoints_changed):
            print("initialized first time\n")
            self.initialize_pointers(waypoints)
            waypoints.flag_waypoints_changed=False
            self.maneuverStep = 1

        self.line_Vector_previous=(waypoints.ned[:,self.ptr_current]-waypoints.ned[:,self.ptr_previous])/np.linalg.norm(waypoints.ned[:,self.ptr_current]-waypoints.ned[:,self.ptr_previous])
        self.line_Vector_current=(waypoints.ned[:,self.ptr_next]-waypoints.ned[:,self.ptr_current])/np.linalg.norm(waypoints.ned[:,self.ptr_next]-waypoints.ned[:,self.ptr_current])
        angleBetweenWaypoints = math.acos(np.vdot(-self.line_Vector_previous.T,self.line_Vector_current))        

        if self.maneuverStep == 1:
            flag = 1
            self.halfspace_r = waypoints.ned[:,self.ptr_current]# r <--wi-1
            self.halfspace_r = self.halfspace_r.reshape(3,1)
            self.path.line_origin = self.halfspace_r

            z = waypoints.ned[:,self.ptr_current] - (filletRadius/ (math.tan(angleBetweenWaypoints/2))*self.line_Vector_previous)

            self.line_Vector_previous = self.line_Vector_previous.reshape(3,1)
            self.path.line_direction = self.line_Vector_previous#q<-qi-1
            self.path.airspeed = waypoints.airspeed[self.ptr_current]
            self.path.type = 'line'

            if np.dot(mav_pos.T-z, self.line_Vector_previous)>=0:
                self.maneuverStep = 2
                print("STEP 2")

        elif self.maneuverStep == 2:
            flag = 2
            
            dQnorm = (self.line_Vector_previous-self.line_Vector_current)/np.linalg.norm(self.line_Vector_previous-self.line_Vector_current) 
            c = waypoints.ned[:,self.ptr_current] - (filletRadius/math.sin(angleBetweenWaypoints/2))*dQnorm
            lambdaSign = np.sign(self.line_Vector_previous[0]*self.line_Vector_current[1]-self.line_Vector_previous[1]*self.line_Vector_current[0])
            
            z = waypoints.ned[:,self.ptr_current] + (filletRadius/math.tan(angleBetweenWaypoints/2))*self.line_Vector_current
            self.path.type = 'orbit'
            self.path.orbit_center = c
            self.path.orbit_radius = filletRadius
            self.path.orbit_direction = lambdaSign
            if np.dot(mav_pos.T - z, self.line_Vector_current)>=0:
                self.maneuverStep = 1
                if self.ptr_next < waypoints.num_waypoints-2:
                    self.increment_pointers()
                    #print("Posinter: ", self.ptr_current)
                else:
                    self.initialize_pointers(waypoints)
                    print("Re-initialized Waypoints")  
                print("updated waypoint to number: ",self.ptr_current) 
        if self.i == 300:
            print("POS: ", mav_pos)
            print("WP: ",waypoints.ned[:,self.ptr_current])
            print("ManeuverStep", self.maneuverStep)
            print("\n\n")
            print(np.dot(mav_pos.T-z, self.line_Vector_previous))
            self.i=0

    def dubins_manager(self, waypoints, radius, state):
        self.i=self.i+1    
        mav_pos = np.array([[state.pn, state.pe, -state.h]]).T
        # if the waypoints have changed, update the waypoint pointer
        if (waypoints.flag_waypoints_changed):
            print("initialized first time\n")
            self.initialize_pointers(waypoints)
            waypoints.flag_waypoints_changed=False
        # state machine for dubins path
            self.manager_state = 1
        
        GetDubins = self.compute_parameters(waypoints.ned[:,self.ptr_previous], 
                                                                   waypoints.course[self.ptr_previous], 
                                                                   waypoints.ned[:,self.ptr_current], 
                                                                   waypoints.course[self.ptr_next], radius)
        if self.manager_state == 1:
            flag = 2
            self.path.type = 'orbit'
            self.path.orbit_center = GetDubins[1]# cs
            self.path.orbit_radius = radius
            self.path.orbit_direction = GetDubins[2]#lambda_s
            print(mav_pos,"\n\n", GetDubins[5])
            input("nut\n")
            if np.vdot(mav_pos-GetDubins[5],-1*GetDubins[6])>=0:
                self.manager_state = 2
            
        elif self.manager_state == 2:
            if np.vdot(mav_pos-GetDubins[5], GetDubins[6])>=0:           
                self.manager_state = 3
        
        elif self.manager_state == 3:
            flag = 1
            self.path.type = 'line'
            self.path.line_origin = GetDubins[5]#z1
            self.path.line_direction = GetDubins[6]#q1
            if np.vdot(mav_pos-GetDubins[7], GetDubins[6]):
                self.manager_state = 4
        
        elif self.manager_state == 4:
            flag = 2
            self.path.type='orbit'
            self.path.orbit_center = GetDubins[3]#ce
            self.path.orbit_radius = radius
            self.path.orbit_direction = GetDubins[4]#lambda_e
            if np.vdot(mav_pos.T-GetDubins[8], -GetDubins[9])>=0:
                self.manager_state = 5

        elif self.manager_state == 5:
            if np.vdot(mav_pos.T-GetDubins[8], GetDubins[9])>=0:
                self.manager_state = 1
                self.increment_pointers()
                GetDubins = self.compute_parameters(waypoints.ned[:,self.ptr_previous], 
                                                        waypoints.course[self.ptr_previous], 
                                                        waypoints.ned[:,self.ptr_current], 
                                                        waypoints.course[self.ptr_next], radius)
        if self.i == 300:
            print("POS: ", mav_pos)
            print("WP: ", waypoints.ned[:,self.ptr_current])
            print ("STATE:", self.manager_state)
            print("\n\n")
            input("\n")
            self.i=0

    def compute_parameters(self, ps, chis, pe, chie, R):
        # calcular distancia entre circulos
        ell = np.linalg.norm(ps-pe)
        e1 = np.array([[1,0,0]]).T
        if ell < 2 * R:
            print('Error in Dubins Parameters: The distance between nodes must be larger than 2R.')
        else:
            pi2 = np.pi/2
            # compute start and end circles
            crs = ps + R*np.array([np.cos(chis + pi2), np.sin(chis + pi2), 0 ])
            cls = ps + R*np.array([np.cos(chis - pi2), np.sin(chis - pi2), 0 ])
            cre = pe + R*np.array([np.cos(chie + pi2), np.sin(chis + pi2), 0 ])
            cle = pe + R*np.array([np.cos(chie - pi2), np.sin(chis - pi2), 0 ])
            
            # compute L1,
            v = self.angle2d(crs,cre)
            L1 = np.linalg.norm(crs-cre) + R*self.mod(4*pi2 + self.mod(v - pi2) - self.mod(chis - pi2)) + R*self.mod(4*pi2 + self.mod(chie - pi2) - self.mod(v - pi2))
            
            # compute L2
            ell = np.linalg.norm(cle-crs)
            theta = self.angle2d(crs,cle)
            theta2 = theta - pi2 + np.arcsin(2*R/ell)
            L2 = np.sqrt(ell*ell-4*R*R) + R * self.mod(pi2*4 + self.mod(theta2) - self.mod(chis - pi2)) + R * self.mod(4*pi2 + self.mod(theta2 + np.pi)- self.mod(chie + pi2)) 
            
            # compute L3
            ell = np.linalg.norm(cre-cls)
            theta = self.angle2d(cls,cre)
            theta2 = np.arccos (2*R/ell)
            L3 = np.sqrt(ell*ell - 4*R*R) + R*self.mod(4*pi2 + self.mod(chis + pi2) - self.mod(theta+theta2)) + R*self.mod(4*pi2 + self.mod(chie-pi2) - self.mod(theta+theta2-np.pi))        
            
            # compute L4
            ell = np.linalg.norm(cls-cle)
            theta = self.angle2d(cls,cle)
            L4 = ell + R*self.mod(4*pi2 + self.mod(chis + pi2) - self.mod(theta + pi2)) + R*self.mod(4*pi2 + self.mod(theta + pi2) - self.mod(chie + pi2))
            
            # L is the minimum distance
            L = np.min([L1, L2, L3, L4])
            idx = np.argmin([L1, L2, L3, L4])
            print("idx=",idx)
            if idx == 0:
                cs = crs
                lams = 1
                ce = cre
                lame = 1
                q1 = ((ce-cs)/np.linalg.norm(ce-cs)).T
                w1 = cs + R*np.dot(self.rotz(-pi2),q1)
                w2 = ce + R*np.dot(self.rotz(-pi2),q1)
            elif idx == 1:
                cs = crs
                lams = 1    
                ce = cle
                lame = -1
                
                ell = np.linalg.norm(ce-cs)
                v  = self.angle2d(ce,cs)
                v2 = v - pi2 + np.arcsin(2*R/ell)
                
                q1 = (np.dot(self.rotz(v2+pi2), e1)).T
               
                w1 = cs + (R*np.dot(self.rotz(v2), e1)).T
                w2 = ce + (R*np.dot(self.rotz(v2+np.pi), e1)).T
            elif idx == 2:
                cs = cls
                lams = -1
                ce = cre
                lame = 1
                
                ell = np.linalg.norm(ce-cs)
                v = self.angle2d(ce,cs)
                v2 = np.arccos(2*R/ell)

                q1 = (np.dot(self.rotz(v+v2-pi2),e1)).T
                w1 = cs + R*np.dot(self.rotz(v+v2),e1)
                w2 = ce + R*np.dot(self.rotz(v+v2-np.pi),e1)
            elif idx == 3:
                cs = cls
                lams = -1
                ce = cle
                lame = -1
                q1 = ((ce-cs)*np.linalg.norm(ce-cs)).T
                w1 = cs + R*np.dot(self.rotz(pi2),q1)
                w2 = ce + R*np.dot(self.rotz(pi2),q1)
            w3 = pe
            q3 = np.dot(self.rotz(chie), e1)
            dubinsParams = np.array([L,cs.T,lams,ce.T,lame,w1.T,q1.T,w2.T,w3.T,q3.T])
            print ("SET", dubinsParams,"\n\n")
            return dubinsParams 
            #return L, cs, lams, ce, lame, w1, q1, w2, w3, q3

    def rotz(self, theta):
        return np.array([[np.cos(theta), -np.sin(theta), 0],
                            [np.sin(theta), np.cos(theta), 0],
                            [0, 0, 1]])

    def mod(self, x):
        while x < 0:
            x += 2*np.pi
        while x > 2*np.pi:
            x -= 2*np.pi
        return x

    def angle2d(self, x, y):
        return np.arctan2(x[1]-y[1], x[0]-y[0])