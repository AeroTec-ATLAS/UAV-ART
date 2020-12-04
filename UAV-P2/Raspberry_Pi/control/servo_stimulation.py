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
	
	def __init__(self):	
		self.servo_de = AngularServo(14, min_angle=-45, max_angle=45)
		self.servo_da = AngularServo(15, min_angle=self.min_da, max_angle=self.max_da)
		self.servo_dr = AngularServo(18, min_angle=self.min_dr, max_angle=self.max_dr)


	def stimulation(self, u):
		self.servo_de.angl= u[0]
		self.servo_da.angl= u[1]
		self.servo_dr.angl= u[2]












