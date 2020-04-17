import sys
sys.path.append('..')
import numpy as np
import chap5.model_coef as TF
import parameters.aerosonde_parameters as MAV

gravity = MAV.gravity  # gravity constant
rho = MAV.rho  # density of air
sigma =   # low pass filter gain for derivative
Va0 = TF.Va_trim

#----------roll loop-------------
# get transfer function data for delta_a to phi
wn_roll =
zeta_roll =
roll_kp =
roll_kd =

#----------course loop-------------
wn_course =
zeta_course =
course_kp =
course_ki =

#----------yaw damper-------------
yaw_damper_tau_r =
yaw_damper_kp =

#----------pitch loop-------------
wn_pitch =
zeta_pitch =
pitch_kp =
pitch_kd =
K_theta_DC =

#----------altitude loop-------------
wn_altitude =
zeta_altitude =
altitude_kp =
altitude_ki =
altitude_zone =   # moving saturation limit around current altitude

#---------airspeed hold using throttle---------------
wn_airspeed_throttle =
zeta_airspeed_throttle =
airspeed_throttle_kp =
airspeed_throttle_ki =
