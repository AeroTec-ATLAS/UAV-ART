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
    def __init__(self, ps=9999*np.ones((3,1)), chis=9999,
                 pe=9999*np.ones((3,1)), chie=9999, R=9999):
        if R == 9999:
            L = R
            cs = ps
            lams = R
            ce = ps
            lame = R
            w1 = ps
            q1 = ps
            w2 = ps
            w3 = ps
            q3 = ps
        else:
            L, cs, lams, ce, lame, w1, q1, w2, w3, q3 \
                = self.compute_parameters(ps, chis, pe, chie, R)
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
        self.r1 = w1
        self.n1 = q1
        self.r2 = w2
        self.r3 = w3
        self.n3 = q3

    def update(self, ps, chis, pe, chie, R):
         L, cs, lams, ce, lame, w1, q1, w2, w3, q3 \
            = self.compute_parameters(ps, chis, pe, chie, R)
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
         self.r1 = w1
         self.n1 = q1
         self.r2 = w2
         self.r3 = w3
         self.n3 = q3


    def compute_parameters(self, ps, chis, pe, chie, R):
        # calcular distancia entre circulos
        ell = np.linalg.norm(ps-pe)
        e1 = np.array([[1,0,0]]).T
        print (ps)
        print (pe)
        print (chis)
        print (chie)
        print (R)

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
            L2 = np.sqrt(ell**2-4*R**2) + R * self.mod(pi2*4 + self.mod(theta2) - self.mod(chis - pi2)) + R * self.mod(4*pi2 + self.mod(theta2 + np.pi)- self.mod(chie + pi2)) 
            
            # compute L3
            ell = np.linalg.norm(cre-cls)
            theta = self.angle2d(cls,cre)
            theta2 = np.arccos (2*R/ell)
            L3 = np.sqrt(ell**2 - 4*R**2) + R*self.mod(4*pi2 + self.mod(chis + pi2) - self.mod(theta+theta2)) + R*self.mod(4*pi2 + self.mod(chie-pi2) - self.mod(theta+theta2-np.pi))        
            
            # compute L4
            ell = np.linalg.norm(cls-cle)
            theta = self.angle2d(cls,cle)
            L4 = ell + R*self.mod(4*pi2 + self.mod(chis + pi2) - self.mod(theta + pi2)) + R*self.mod(4*pi2 + self.mod(theta + pi2) - self.mod(chie + pi2))
            
            # L is the minimum distance
            L = np.min([L1, L2, L3, L4])
            idx = np.argmin([L1, L2, L3, L4])
            if idx == 0:
                cs = crs
                lams = 1
                ce = cre
                lame = 1
                q1 = (ce-cs)/np.linalg.norm(ce-cs)
                w1 = cs + R*self.rotz(-pi2)*q1
                w2 = ce + R*self.rotz(-pi2)*q1
            elif idx == 1:
                cs = crs
                lams = 1    
                ce = cle
                lame = -1
                
                ell = np.linalg.norm(ce-cs)
                v  = self.angle2d(ce,cs)
                v2 = v - pi2 + np.arcsin(2*R/ell)
                
                q1 = self.rotz(v2+pi2)*e1
                w1 = cs + R*self.rotz(v2)*e1
                w2 = ce + R*self.rotz(v2+np.pi)*e1
            elif idx == 2:
                cs = cls
                lams = -1
                ce = cre
                lame = 1
                
                ell = np.linalg.norm(ce-cs)
                v = self.angle2d(ce,cs)
                v2 = np.arccos(2*R/ell)

                q1 = self.rotz(v+v2-pi2)*e1
                w1 = cs + R*self.rotz(v+v2)*e1
                w2 = ce + R*self.rotz(v+v2-np.pi)*e1
            elif idx == 3:
                cs = cls
                lams = -1
                ce = cle
                lame = -1
                q1 = (ce-cs)*np.linalg.norm(ce-cs)
                w1 = cs + R*self.rotz(pi2)*q1
                w2 = ce + R*self.rotz(pi2)*q1
            w3 = pe
            q3 = self.rotz(chie)*e1
            
            return L, cs, lams, ce, lame, w1, q1, w2, w3, q3

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
        return np.arctan2(x.item(1)-y.item(1), x.item(0)-y.item(0))
