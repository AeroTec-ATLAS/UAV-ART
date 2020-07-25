"""
autopilot - Controlar automaticamente a dinâmica e atitude do aeromodelo.
	Inputs: msgAutopilot; delta_throttle; mavDynamics.true_state; SIM.start_time
	Outputs: msgState; msgDelta
"""

import sys
sys.path.append('..')

import numpy as np
from pidControl	import pidControl
from parameters import control_parameters as AP
from message_types.msg_state import msgState
from message_types.msg_delta import msgDelta
import math


class autopilot:
	
	def __init__(self, ts_control):
		# instantiate lateral controllers
		
		self.aileron_from_roll = pidControl(kp=AP.roll_kp, ki=AP.roll_ki, kd=AP.roll_kd, Ts=ts_control, sigma= 0.05, low_limit = -AP.delta_a_max, high_limit = AP.delta_a_max)
		
		self.roll_from_course = pidControl(kp=AP.course_kp, ki=AP.course_ki, kd=0, Ts=ts_control, sigma= 0.05, low_limit = -AP.delta_a_max, high_limit=AP.delta_a_max)
		
        # instantiate longitudinal controllers
		self.elevator_from_pitch = pidControl(kp=AP.pitch_kp, ki=0, kd=AP.pitch_kd, Ts=ts_control, sigma= 0.05, low_limit=-AP.delta_e_max , high_limit=AP.delta_e_max)
		
		self.throttle_from_airspeed = pidControl(kp=AP.airspeed_throttle_kp, ki=AP.airspeed_throttle_ki, kd=0, Ts=ts_control, sigma= 0.05, low_limit=0, high_limit= AP.throttle_max)
		
		self.pitch_from_airspeed = pidControl(kp=AP.airspeed_pitch_kp, ki=AP.airspeed_pitch_ki, kd=0, Ts=ts_control, sigma= 0.05, low_limit = -AP.delta_a_max, high_limit = AP.delta_a_max)   
		               
		self.pitch_from_altitude = pidControl(kp=AP.altitude_kp, ki=AP.altitude_ki, kd=0, Ts=ts_control, sigma= 0.05, low_limit= -AP.delta_a_max, high_limit= AP.delta_a_max)
                               
        # inicialize message        
              
		self.commanded_state = msgState()
		self.delta= msgDelta()
		
		
	def update(self, cmd, state, previous_t, ts_control):			
		
		
		#pn = state.pn;  		# inertial North position
		#pe = state.pe;  		# inertial East position
		h = state.h;  			# altitude
		Va = state.Va;  		# airspeed
		#alpha = state.alpha; 	# angle of attack
		#beta = state.beta;  	# side slip angle
		phi = state.phi;  		# roll angle
		theta = state.theta;  	# pitch angle
		chi = state.chi;  		# course angle
		p = state.p; 			# body frame roll rate
		q = state.q; 			# body frame pitch rate
		#r = state.r; 			# body frame yaw rate
		#Vg = state.Vg; 		# ground speed
		#wn = state.wn; 		# wind North
		#we = state.we; 		# wind East
		#psi = state.psi; 		# heading
		#bx = state.bx; 		# x-gyro bias
		#by = state.by; 		# y-gyro bias
		#bz = state.bz; 		# z-gyro bias
			
		Va_c = cmd.airspeed_command;  		# commanded airspeed (m/s)
		h_c = cmd.altitude_command;  		# commanded altitude (m)
		chi_c = cmd.course_command; 		# commanded course (rad)


		if ts_control == 0:
			reset_flag = 1
		else:
			reset_flag = 0

        # lateral autopilot
        
		phi_c = self.roll_from_course.update(0, chi_c, chi, reset_flag)
		delta_a = self.aileron_from_roll.update_with_rate(phi_c, phi, p, reset_flag) 
		delta_r = 0

		# longitudinal autopilot
		# saturate the altitude command
		
		#state machine
		
		#take_off_zone	
		if h <= AP.altitude_take_off_zone: 
			if AP.altitude_state != 1:
				reset_flag = 1;
			AP.altitude_state = 1;
			delta_t = AP.throttle_max;
			theta_c = AP.theta_c_climb*(1-math.exp(-ts_control));
		
		#climb_zone	
		elif h <= h_c-AP.altitude_hold_zone: 
			if AP.altitude_state != 2:
				reset_flag = 1; 
			AP.altitude_state = 2;
			delta_t = AP.throttle_max;
			theta_c = self.pitch_from_airspeed.update(0, Va_c, Va, reset_flag);
		
		#descend_zone	
		elif h >= h_c+AP.altitude_hold_zone: 
			if AP.altitude_state != 3:
				reset_flag = 1; 
			AP.altitude_state = 3;
			delta_t = 0;
			theta_c = self.pitch_from_airspeed.update(0, Va_c, Va, reset_flag); 
			
		#altitude_hold_zone
		else: 
			if AP.altitude_state != 4:
				reset_flag = 1; 	
			AP.altitude_state = 4;
			theta_c = self.pitch_from_altitude.update(0, h_c, h, reset_flag); 
			delta_t = self.throttle_from_airspeed.update(previous_t, Va_c, Va, reset_flag); 
				
		delta_e = self.elevator_from_pitch.update_with_rate(theta_c, theta, q, reset_flag)
		
		
		print(AP.altitude_state)
		print(delta_t)	
		# construct output and commanded states
			
		u = np.array([[delta_e], [delta_a], [delta_r], [delta_t]])
		self.delta.from_array(u)
        
		self.commanded_state.h = cmd.altitude_command
		self.commanded_state.Va = cmd.airspeed_command
		self.commanded_state.phi = phi_c
		self.commanded_state.theta = theta_c
		self.commanded_state.chi = cmd.course_command
        
        
		return self.delta, self.commanded_state
