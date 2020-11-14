"""
mavsim_python
    - Chapter 10 assignment for Beard & McLain, PUP, 2012
    - Last Update:
        3/11/2019 - RWB
"""
import numpy as np


from control.autopilot import autopilot
from control.path_follower import path_follower
from tools.ground_connection import groundProxy
from tools.sensors import Sensors
localIP='192.168.1.237'
raspIP='192.168.1.5'
sensors=Sensors(localIP, raspIP)
# initialize the visualization
ground=groundProxy()

# initialize elements of the architecture
ctrl = autopilot(0.01)
#obsv = observer(SIM.ts_simulation)
path_follow = path_follower()
# path definition
from message_types.msg_path import msgPath
from message_types.msg_state import msgState
from message_types.msg_delta import msgDelta
path = msgPath()
state = msgState()  # instantiate state message
delta = msgDelta() 
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
# main simulation loop
while True:
    # -------observer-------------
    state = sensors.update(state)
    # -------path follower-------------
    autopilot_commands = path_follow.update(path, state)
    # autopilot_commands = path_follow.update(path, mav.true_state)  # for debugging

    # -------controller-------------
    delta, commanded_state = ctrl.update(autopilot_commands, state, previous_t, sim_time)
    previous_t = delta.throttle

    # -------update viewer-------------
    ground.sendToVisualizer(state, delta)

    # -------increment time-------------
    sim_time += 0.01
