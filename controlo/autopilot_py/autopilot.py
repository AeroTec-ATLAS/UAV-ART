"""
autopilot
"""

import pidControl
import parameters as AP

class autopilot:
	
	def __init__(self, ts_control):
		# instantiate lateral controllers
		
		self.roll_from_aileron = pidControl(kp=AP.roll_kp, ki=0, kd=AP.roll_kd, Ts=ts_control, sigma= 0.05, limit = np.radians(45))
						
        self.course_from_roll = pidControl(kp=AP.course_kp, ki=AP.course_ki, kd=0, Ts=ts_control, sigma= 0.05, limit=np.radians(30))
 
		"""
        # instantiate longitudinal controllers
        
        self.pitch_from_elevator = pidControl(
                        kp=AP.pitch_kp,
                        kd=AP.pitch_kd,
                        limit=np.radians(45))
                        
        self.altitude_from_pitch = pidControl(
                        kp=AP.altitude_kp,
                        ki=AP.altitude_ki,
                        Ts=ts_control,
                        limit=np.radians(30))
                        
        self.airspeed_from_throttle = pidControl(
                        kp=AP.airspeed_throttle_kp,
                        ki=AP.airspeed_throttle_ki,
                        Ts=ts_control,
                        limit=1.0)
                        
        #self.commanded_state = msgState()
		"""
		
	def update(self, cmd, state):

		if ts_control = 0
			reset_flag = 1
		else
			reset_flag = 0
        # lateral autopilot
			chi_c =	#vem do cmd
			phi_c = roll_from_aileron.update(chi_c, chi, reset_flag)
			delta_a = course_from_roll.update_with_rate(phi_c, phi, p, reset_flag) #phi e p(roll rate) dos states "da classe veículo aka sensores"
			delta_r = 0
