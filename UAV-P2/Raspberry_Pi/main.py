"""
mavsim_python
    - Chapter 10 assignment for Beard & McLain, PUP, 2012
    - Last Update:
        3/11/2019 - RWB
"""
import numpy as np
import sys
sys.path.append('..')
from tools.log import log
from dynamics.mav_dynamics import mavDynamics
import parameters.simulation_parameters as SIM
localIP='192.168.1.237'
raspIP='192.168.1.38'
# initialize elements of the architecture
logger = log('Test flight.txt')
from message_types.msg_state import msgState
from message_types.msg_delta import msgDelta
state = msgState()  # instantiate state message
delta = msgDelta() 
mav = mavDynamics(SIM.ts_simulation, localIP, raspIP)
# initialize the simulation time
sim_time = 0
# main simulation loop
import time
while True:
	# Missing delta fetch from Pixhawk
    logger.addEntry(mav.true_state, delta, mav.sensors, sim_time)
    # -------physical system-------------
    time.sleep(0.01)
    mav.update(delta, None, simulation=False)  # propagate the MAV dynamics
    # -------increment time-------------
    sim_time += 0.01
