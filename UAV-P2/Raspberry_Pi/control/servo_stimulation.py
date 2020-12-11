import sys
sys.path.append('..')
import numpy as np
from gpiozero import AngularServo
from time import sleep

class servo_stimulation:
	
	porta_de = 14
	porta_da = 15
	porta_dr = 18
	min_de=-45
	min_da=-60
	min_dr=-40
	max_de=45
	max_da=30
	max_dr=30
	prev_de=0
	prev_da=0
	prev_dr=0
	
	def __init__(self):	
		self.servo_de = AngularServo(14, min_angle=-45, max_angle=45)
		self.servo_da = AngularServo(15, min_angle=self.min_da, max_angle=self.max_da)
		self.servo_dr = AngularServo(18, min_angle=self.min_dr, max_angle=self.max_dr)


	def stimulation(self, u):
		if prev_de != u[0]:
			self.servo_de.angle = np.degrees(u[0])
			self.prev_de = u[0]
		if prev_da != u[1]:
			self.servo_da.angle = np.degrees(u[1])
			self.prev_da = u[1]
		if prev_dr != u[2]:
			self.servo_dr.angle = np.degrees(u[2])
			self.prev_da = u[2]












