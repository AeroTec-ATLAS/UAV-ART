import sys
import math
sys.path.append('..')
import numpy as np

# load message types
#from message_types.msg_state import msgState

import parameters.aerosonde_parameters as MAV
#from tools.rotations import Quaternion2Rotation, Quaternion2Euler

Massa = MAV.mass
g= MAV.gravity

f_grav = np.array ([MAV.mass*MAV.gravity* math.cos(math.pi),
                    g,
                    Massa])
print(type(f_grav[1]))

V_a = 7

f_prop = np.array ([0.5 * MAV.rho * (MAV.D_prop/2)*math.pi*MAV.C_prop*((MAV.K_motor*0)**2-(V_a)**2),
                    0,
                    0])
print(f_prop)

skrt= f_grav + f_prop
print(skrt)
print(skrt[1])
