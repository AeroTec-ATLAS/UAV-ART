"""
mavsim_python
    - Chapter 10 assignment for Beard & McLain, PUP, 2012
    - Last Update:
        3/11/2019 - RWB
"""
import numpy as np
import sys
sys.path.append('..')

from control.autopilot import autopilot
from message_types.msg_autopilot import msgAutopilot
from control.path_follower import path_follower
#from tools.ground_connection import groundProxy
#from tools.sensor_viewer import SensorViewer
from tools.log import log
from dynamics.wind_simulation import windSimulation
from control.autopilot import autopilot
from dynamics.mav_dynamics import mavDynamics
from control.servo_stimulation import servo_stimulation
import parameters.simulation_parameters as SIM
from tools.autopilot_Command import autopilotCommand

localIP='192.168.1.237'
raspIP='192.168.1.38'
#sensors=Sensors()

# initialize the visualization
#ground=groundProxy()
#servo=servo_stimulation()

# initialize elements of the architecture
ctrl = autopilot(0.01)
#sensor_view = SensorViewer()  # initialize view of sensor data plots
#obsv = observer(SIM.ts_simulation)

path_follow = path_follower()

logger = log('Test flight.txt')

# path definition
from message_types.msg_path import msgPath
from message_types.msg_state import msgState
from message_types.msg_delta import msgDelta

path = msgPath()
state = msgState()  # instantiate state message
delta = msgDelta()

commandWindow = autopilotCommand()
commands = msgAutopilot()
wind = windSimulation(SIM.ts_simulation)
wind._steady_state = np.array([[5., 2., 0.]]).T  # Steady wind in NED frame
mav = mavDynamics(SIM.ts_simulation, localIP, raspIP)

# path.type = 'line'
path.type = 'orbit'
if path.type == 'line':
    path.line_origin = np.array([[0.0, 0.0, -100.0]]).T
    path.line_direction = np.array([[0.5, 1.0, -0.05]]).T
    path.line_direction = path.line_direction / np.linalg.norm(path.line_direction)
    path.airspeed = 35
else:  # path.type == 'orbit'
    path.orbit_center = np.array([[0.0, 0.0, -100.0]]).T  # center of the orbit
    path.orbit_radius = 500.0  # radius of the orbit
    path.orbit_direction = 'CW'  # orbit direction: 'CW'==clockwise, 'CCW'==counter clockwise
    path.airspeed = 35

# initialize the simulation time
sim_time = 0
previous_t = 0
nprint = 1

# main simulation loop
import time
while True:
    # -------observer-------------
    #state = sensors.update(state)
    #state.h=0
    # -------path follower-------------
    commandWindow.root.update_idletasks()
    commandWindow.root.update()
    commands.airspeed_command = commandWindow.slideVa.get()  # Va_command.square(sim_time)
    commands.course_command = np.deg2rad(commandWindow.slideChi.get())  # chi_command.square(sim_time)
    commands.altitude_command = commandWindow.slideH.get()  # h_command.square(sim_time)
    autopilot_commands = commands #path_follow.update(path, state)
    # autopilot_commands = path_follow.update(path, mav.true_state)  # for debugging

    # -------controller-------------
    delta, commanded_state = ctrl.update(autopilot_commands, state, previous_t, sim_time)
    previous_t = delta.throttle
    #servo.stimulation(delta.to_array())

    if nprint == 200:
        print("--------------------")
        print(np.degrees(delta.to_array()))
        nprint = 1

    nprint = nprint +1
    logger.addEntry(mav.true_state, delta, mav.sensors, sim_time)
    # -------update viewer-------------
    #ground.sendToVisualizer(state, delta)
    # -------physical system-------------
    time.sleep(0.01)
    current_wind = wind.update()  # get the new wind vector
    mav.update(delta, current_wind)  # propagate the MAV dynamics
    #sensor_view.update(mav.sensors,  # sensor values
     #                  SIM.ts_simulation)
    # -------increment time-------------
    sim_time += 0.01
