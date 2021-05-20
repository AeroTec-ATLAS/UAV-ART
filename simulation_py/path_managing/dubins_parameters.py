# dubins_parameters
#   - Dubins parameters that define path between two configurations
#
# mavsim_matlab 
#     - Beard & McLain, PUP, 2012
#     - Update history:  
#         3/26/2019 - RWB
#         4/2/2020 - RWB

import numpy as np
import sys
sys.path.append('..')


class dubinsParameters:
    def __init__(self, ps=9999*np.array([[1,1,1]]).T, chis=9999,
                 pe=9999*np.array([[1,1,1]]).T, chie=9999, R=9999):
        if R == 9999:
            L = R
            cs = ps
            lams = R
            ce = ps
            lame = R
            z1 = ps
            q1 = ps
            z2 = ps
            z3 = ps
            q3 = ps
        else:
            L, cs, lams, ce, lame, z1, q1, z2, z3, q3 \
                = compute_parameters(ps, chis, pe, chie, R)
        self.p_s = ps
        self.chi_s = chis
        self.p_e = pe
        self.chi_e = chie
        self.radius = R
        self.length = L
        self.center_s = cs
        self.dir_s = lams
        self.center_e = ce
        self.dir_e = lame
        self.r1 = z1
        self.n1 = q1
        self.r2 = z2
        self.r3 = z3
        self.n3 = q3

    def update(self, ps, chis, pe, chie, R):
         L, cs, lams, ce, lame, z1, q1, z2, z3, q3 \
            = compute_parameters(ps, chis, pe, chie, R)
         self.p_s = ps
         self.chi_s = chis
         self.p_e = pe
         self.chi_e = chie
         self.radius = R
         self.length = L
         self.center_s = cs
         self.dir_s = lams
         self.center_e = ce
         self.dir_e = lame
         self.r1 = z1
         self.n1 = q1
         self.r2 = z2
         self.r3 = z3
         self.n3 = q3


def compute_parameters(ps, chis, pe, chie, R):
        # distance between orbits
        ell = np.linalg.norm(ps-pe)
        e1 = np.array([[1,0,0]]).T

        if ell < 3 * R:
            print('Error in Dubins Parameters: The distance between nodes must be larger than 2R.')
        else:
            # compute start and end circles
            crs = ps + R * rotz(np.pi/2.) @ np.array([[np.cos(chis), np.sin(chis), 0 ]]).T
            cls = ps + R * rotz(-np.pi/2.) @ np.array([[np.cos(chis), np.sin(chis), 0 ]]).T
            cre = pe + R * rotz(np.pi/2.) @ np.array([[np.cos(chie), np.sin(chie), 0 ]]).T
            cle = pe + R * rotz(-np.pi/2.) @ np.array([[np.cos(chie), np.sin(chie), 0 ]]).T
            # compute L1,
            v = angle2d(crs,cre)
            L1 = np.linalg.norm(crs-cre) + R*mod(2*np.pi + mod(v - np.pi/2.) - mod(chis - np.pi/2.)) + R*mod(2*np.pi + mod(chie - np.pi/2.) - mod(v - np.pi/2.))

            # compute L2
            ell = np.linalg.norm(cle-crs)
            v = angle2d(crs,cle)
            v2 = v - np.pi/2. + np.arcsin(2*R/ell)
            L2 = np.sqrt(ell**2-4*R**2) + R * mod(2*np.pi + mod(v2) - mod(chis - np.pi/2.)) + R * mod(2*np.pi + mod(v2 + np.pi)- mod(chie + np.pi/2.)) 

            # compute L3
            ell = np.linalg.norm(cre-cls)
            v = angle2d(cls,cre)
            v2 = np.arccos (2*R/ell)
            L3 = np.sqrt(ell**2 - 4*R**2) + R * mod(2*np.pi + mod(chis + np.pi/2.) - mod(v+v2)) + R*mod(2*np.pi + mod(chie-np.pi/2.) - mod(v+v2-np.pi)) 

            # compute L4
            ell = np.linalg.norm(cls-cle)
            v = angle2d(cls,cle)
            L4 = ell + R * mod(2*np.pi + mod(chis + np.pi/2.) - mod(v + np.pi/2.)) + R*mod(2*np.pi + mod(v + np.pi/2.) - mod(chie + np.pi/2.))

            # L is the minimum distance
            L = np.min([L1, L2, L3, L4])
            argmin = np.argmin([L1, L2, L3, L4])
            if argmin == 0:
                cs = crs
                lams = 1
                ce = cre
                lame = 1
                q1 = (ce-cs)/np.linalg.norm(ce-cs)
                z1 = cs + R*rotz(-np.pi/2.) @ q1
                z2 = ce + R*rotz(-np.pi/2.) @ q1
            elif argmin == 1:
                cs = crs
                lams = 1    
                ce = cle
                lame = -1

                ell = np.linalg.norm(ce-cs)
                v  = angle2d(cs,ce)
                v2 = v - np.pi/2. + np.arcsin(2*R/ell)

                q1 = rotz(v2+np.pi/2.) @ e1
                z1 = cs + R*rotz(v2) @ e1
                z2 = ce + R*rotz(v2+np.pi) @ e1
            elif argmin == 2:
                cs = cls
                lams = -1
                ce = cre
                lame = 1

                ell = np.linalg.norm(ce-cs)
                v = angle2d(cs,ce)
                v2 = np.arccos(2*R/ell)

                q1 = rotz(v+v2-np.pi/2.) @ e1
                z1 = cs + R*rotz(v+v2) @ e1
                z2 = ce + R*rotz(v+v2-np.pi) @ e1
            elif argmin == 3:
                cs = cls
                lams = -1
                ce = cle
                lame = -1
                q1 = (ce-cs)/np.linalg.norm(ce-cs)
                z1 = cs + R*rotz(np.pi/2.) @ q1
                z2 = ce + R*rotz(np.pi/2.) @ q1
            z3 = pe
            q3 = rotz(chie) @ e1
            return L, cs, lams, ce, lame, z1, q1, z2, z3, q3


def rotz(theta):
    return np.array([[np.cos(theta), -np.sin(theta), 0],
                    [np.sin(theta), np.cos(theta), 0],
                    [0, 0, 1]])


def mod(x):
    while x < 0:
        x += 2*np.pi
    while x > 2*np.pi:
        x -= 2*np.pi
    return x

def angle2d(x, y):
        return np.pi/2 - np.arctan2(y.item(0)-x.item(0), y.item(1)-x.item(1))
