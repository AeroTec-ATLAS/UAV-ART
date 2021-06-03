"""
mavsim_python
    - Chapter 10 assignment for Beard & McLain, PUP, 2012
    - Last Update:
        3/11/2019 - RWB
"""
import numpy as np
import sys
import time
sys.path.append('..')
from tools.log import log
from dynamics.mav_dynamics import mavDynamics
import parameters.simulation_parameters as SIM
import parameters.sensor_parameters as SEN
localIP='192.168.1.237'
raspIP='192.168.1.38'
# initialize elements of the architecture
logger = log('Test flight.txt')
from message_types.msg_state import msgState
from message_types.msg_delta import msgDelta
state = msgState()  # instantiate state message
delta = msgDelta() 
mav = mavDynamics(SIM.ts_simulation,'' ,'')
# initialize the time keeping
flight_time = 0
start_time = time.time()
# main loop
while True:
    # -------physical system-------------
    time.sleep(SEN.ts_sensors)
    mav.update(mav.delta, None, simulation=False)  # propagate the MAV dynamics
    flight_time = time.time() - start_time
    logger.addEntry(mav.true_state, mav.delta, mav.sensors, flight_time)
