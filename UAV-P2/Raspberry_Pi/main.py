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
# initialize elements of the architecture
from datetime import datetime
date = datetime.today().strftime('%Y--%m--%d-%H-%M-%S')
logger = log(date+'_Test-Flight.txt')
from message_types.msg_state import msgState
from message_types.msg_delta import msgDelta
state = msgState()  # instantiate state message
delta = msgDelta() 
mav = mavDynamics(SIM.ts_simulation)
# initialize the time keeping
flight_time = 0
start_time = time.time()
pixStartTime = mav.telemetry.getTime()
logger._file.write('RaspberryPi Time, Pixhawk Time, Pixhawk Time since boot: ' + str(start_time) + '' + str(pixStartTime.time_unix_usec) + '' + str(pixStartTime.time_boot_ms) + '\n')
# main loop
while True:
    # -------physical system-------------
    try:
        time.sleep(SEN.ts_sensors)
        mav.update(mav.delta, None, simulation=False)  # propagate the MAV dynamics
        flight_time = time.time() - start_time
        logger.addEntry(mav.true_state, mav.delta, mav.sensors, flight_time)
    except KeyboardInterrupt:
        mav.telemetry.disarm()
        mav.telemetry.mavlink.motors_disarmed_wait()
        print('Pixhawk Disarmed')
        break
    
