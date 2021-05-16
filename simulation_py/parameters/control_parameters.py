"""
parameters for the controller
"""

import sys
sys.path.append('..')

import numpy as np
import dynamics_linear.model_coef as TF
import parameters.aerosonde_parameters as MAV

gravity = MAV.gravity  # gravity constant
rho = MAV.rho  # density of air
sigma =  0.5 # low pass filter gain for derivative
#Va0 = TF.Va_trim

#----------roll loop-------------
# get transfer function data for delta_a to phi
#wn_roll =
#zeta_roll =
roll_kp = 1
roll_ki = 0.4000
roll_kd = 0.1209

#----------course loop-------------
#wn_course =
#zeta_course =
course_kp = 5.8067
course_ki = 0.7285

#----------yaw damper-------------
#yaw_damper_tau_r =
#yaw_damper_kp =

#----------pitch loop-------------
#wn_pitch =
#zeta_pitch =
pitch_kp = -3
pitch_kd = -1.1622
#K_theta_DC =
theta_c_climb = 0.5236
delta_e_max = 0.5236

#----------altitude loop-------------
#wn_altitude =
#zeta_altitude =
altitude_state = 0
altitude_kp = 0.0190
altitude_ki = 6.3312e-04
altitude_hold_zone = 25  # moving saturation limit around current altitude
altitude_take_off_zone = 40

#---------airspeed hold using throttle---------------
#wn_airspeed_throttle =
#zeta_airspeed_throttle =
airspeed_throttle_kp = 0.0049
airspeed_throttle_ki = 0.0013

#---------airspeed hold using pitch---------------
#wn_airspeed_pitch =
#zeta_airspeed_pitch =
airspeed_pitch_kp = -0.1355
airspeed_pitch_ki = -0.0270

#----------sideslip-------------
sideslip_kp: 3
sideslip_ki: 2.5378

#----------throttle-------------
throttle_trim = 0.314
throttle_max = 1

#--------surface_limits------------
delta_a_max = 0.3491
delta_r_max = 0.7854
