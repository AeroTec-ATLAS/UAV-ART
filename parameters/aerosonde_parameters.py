import sys
sys.path.append('..')
import numpy as np
from tools.rotations import Euler2Quaternion

######################################################################################
                #   Initial Conditions
######################################################################################
#   Initial conditions for MAV
pn0 = 0.  # initial north position
pe0 = 0.  # initial east position
pd0 = -100.0  # initial down position
u0 = 35.  # initial velocity along body x-axis
v0 = 0.  # initial velocity along body y-axis
w0 = 0.  # initial velocity along body z-axis
phi0 = 0.  # initial roll angle
theta0 =  0.  # initial pitch angle
psi0 = 0.0  # initial yaw angle
p0 = 0  # initial roll rate
q0 = 0  # initial pitch rate
r0 = 0  # initial yaw rate
Va0 = np.sqrt(u0**2+v0**2+w0**2)
#   Quaternion State
e = Euler2Quaternion(phi0, theta0, psi0)
e0 = e.item(0)
e1 = e.item(1)
e2 = e.item(2)
e3 = e.item(3)


######################################################################################
                #   Physical Parameters
######################################################################################
mass = 25. #kg
Jx = 0.8244 #kg m^2
Jy = 1.135
Jz = 1.759
Jxz = 0.1204
S_wing = 0.55
b = 2.8956
c = 0.18994
S_prop = 0.2027
rho = 1.2682
e = 0.9
AR = (b**2) / S_wing
gravity = 9.8

######################################################################################
                #   Longitudinal Coefficients
######################################################################################
C_L_0 = 0.28
C_D_0 = 0.03
C_m_0 = -0.02338
C_L_alpha = 3.45
C_D_alpha = 0.30
C_m_alpha = -0.38
C_L_q = 0.0
C_D_q = 0.0
C_m_q = -3.6
C_L_delta_e = -0.36
C_D_delta_e = 0.0
C_m_delta_e = -0.5
M = 50.0
alpha0 = 0.47
epsilon = 0.16
C_D_p = 0.0437


######################################################################################
                #   Lateral Coefficients
######################################################################################
C_Y_0 = 0.0
C_ell_0 = 0.0
C_n_0 = 0.0
C_Y_beta = -0.98
C_ell_beta = -0.12
C_n_beta = 0.25
C_Y_p = 0.0
C_ell_p = -0.26
C_n_p = 0.022
C_Y_r = 0.0
C_ell_r = 0.14
C_n_r = -0.35
C_Y_delta_a = 0.0
C_ell_delta_a = 0.08
C_n_delta_a = 0.06
C_Y_delta_r = -0.17
C_ell_delta_r = 0.105
C_n_delta_r = -0.032

######################################################################################
                #   Propeller thrust / torque parameters (see addendum by McLain)
######################################################################################
# Prop parameters
D_prop = 20 * (0.0254)     # prop diameter in m

# Motor parameters
KV = 145.                   # from datasheet RPM/V
KQ = (1. / KV) * 60. / (2. * np.pi)  # KQ in N-m/A, V-s/rad
R_motor = 0.042              # ohms
i0 = 1.5                     # no-load (zero-torque) current (A)
K_motor = 80
K_tp = 0
K_omega = 0
C_prop = 1.0


# Inputs
ncells = 12.
V_max = 3.7 * ncells  # max voltage for specified number of battery cells

# Coefficients from prop_data fit
C_Q2 = -0.01664
C_Q1 = 0.004970
C_Q0 = 0.005230
C_T2 = -0.1079
C_T1 = -0.06044
C_T0 = 0.09357

######################################################################################
                #   Calculation Variables
######################################################################################
#   gamma parameters pulled from page 36 (dynamics)
gamma = Jx * Jz - (Jxz**2)
gamma1 = (Jxz * (Jx - Jy + Jz)) / gamma
gamma2 = (Jz * (Jz - Jy) + (Jxz**2)) / gamma
gamma3 = Jz / gamma
gamma4 = Jxz / gamma
gamma5 = (Jz - Jx) / Jy
gamma6 = Jxz / Jy
gamma7 = ((Jx - Jy) * Jx + (Jxz**2)) / gamma
gamma8 = Jx / gamma

#   C values defines on pag 62
C_p_0 = gamma3 * C_ell_0 + gamma4 * C_n_0
C_p_beta = gamma3 * C_ell_beta + gamma4 * C_n_beta
C_p_p = gamma3 * C_ell_p + gamma4 * C_n_p
C_p_r = gamma3 * C_ell_r + gamma4 * C_n_r
C_p_delta_a = gamma3 * C_ell_delta_a + gamma4 * C_n_delta_a
C_p_delta_r = gamma3 * C_ell_delta_r + gamma4 * C_n_delta_r
C_r_0 = gamma4 * C_ell_0 + gamma8 * C_n_0
C_r_beta = gamma4 * C_ell_beta + gamma8 * C_n_beta
C_r_p = gamma4 * C_ell_p + gamma8 * C_n_p
C_r_r = gamma4 * C_ell_r + gamma8 * C_n_r
C_r_delta_a = gamma4 * C_ell_delta_a + gamma8 * C_n_delta_a
C_r_delta_r = gamma4 * C_ell_delta_r + gamma8 * C_n_delta_r
