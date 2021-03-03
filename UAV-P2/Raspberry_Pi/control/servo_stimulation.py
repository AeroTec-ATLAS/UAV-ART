import sys
sys.path.append('..')
import numpy as np
from adafruit_servokit import ServoKit

class servo_stimulation:
	
	def __init__(self):
		self.kit = ServoKit(channels=16)	
		self.servo_de = self.kit.servo[4]
		self.servo_da = self.kit.servo[8]
		self.servo_dr = self.kit.servo[12]


	def stimulation(self, u):
		self.servo_de.angle = np.degrees(u[0]) + 90
		self.servo_da.angle = np.degrees(u[1]) + 90
		self.servo_dr.angle = np.degrees(u[2]) + 90












