"""
parameters
"""

import sys
sys.path.append('..')

class parameters:
	
	#----------roll loop-------------
	# get transfer function data for delta_a to phi
	self.wn_roll =
	self.zeta_roll =
	self.roll_kp =
	self.roll_kd =

	#----------course loop-------------
	self.wn_course =
	self.zeta_course =
	self.course_kp = 5.8067
	self.course_ki = 0.7285
	
	#----------yaw damper-------------
	self.yaw_damper_tau_r =
	self.yaw_damper_kp =

	#----------pitch loop-------------
	self.wn_pitch =
	self.zeta_pitch =
	self.pitch_kp =
	self.pitch_kd =
	self.K_theta_DC =

	#----------altitude loop-------------
	self.wn_altitude =
	self.zeta_altitude =
	self.altitude_kp =
	self.altitude_ki =
	self.altitude_zone =   # moving saturation limit around current altitude

	#---------airspeed hold using throttle---------------
	self.wn_airspeed_throttle =
	self.zeta_airspeed_throttle =
	self.airspeed_throttle_kp =
	self.airspeed_throttle_ki =
	
	#----------sideslip-------------
	self.sideslip_kp: 3
	self.sideslip_ki: 2.5378
