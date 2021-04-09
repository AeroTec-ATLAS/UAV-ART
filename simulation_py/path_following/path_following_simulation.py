"""
mavsim_python
    - Chapter 10 assignment for Beard & McLain, PUP, 2012
    - Last Update:
        3/11/2019 - RWB
"""
import sys
sys.path.append('..')
import keyboard
import numpy as np
import parameters.simulation_parameters as SIM
import parameters.planner_parameters as PLAN

from kinematics.data_viewer import dataViewer
from dynamics.wind_simulation import windSimulation
from control.autopilot import autopilot
from dynamics.mav_dynamics import mavDynamics
# from chap8.observer import observer
from path_following.path_manager import PathManager
from path_following.path_follower import path_follower
from path_following.path_viewer import path_viewer
from tools.ground_connection import groundProxy
from path_following.waypoint_viewer import WaypointViewer

# initialize the visualization
VIDEO = False  # True==write video, False==don't write video
path_view = path_viewer()  # initialize the viewer
data_view = dataViewer()  # initialize view of data plots
ground=groundProxy()
if VIDEO == True:
    from video.video_writer import video_writer
    video = video_writer(video_name="chap10_video.avi",
                         bounding_box=(0, 0, 1000, 1000),
                         output_rate=SIM.ts_video)

# initialize elements of the architecture
wind = windSimulation(SIM.ts_simulation)
wind._steady_state = np.array([[5., 2., 0.]]).T  # Steady wind in NED frame
mav = mavDynamics(SIM.ts_simulation)
ctrl = autopilot(SIM.ts_simulation)
#obsv = observer(SIM.ts_simulation)
path_follow = path_follower()
path_manager = PathManager()
# path definition
from message_types.msg_path import msgPath
path = msgPath()
# path.type = 'line'
path.type = 'manager'
if path.type == 'line':
    path.line_origin = np.array([[0.0, 0.0, -100.0]]).T
    path.line_direction = np.array([[0.5, 1.0, -0.05]]).T
    path.line_direction = path.line_direction / np.linalg.norm(path.line_direction)
    path.airspeed = 35
elif path.type == 'orbit':
    path.orbit_center = np.array([[0.0, 0.0, -100.0]]).T  # center of the orbit
    path.orbit_radius = 500.0  # radius of the orbit
    path.orbit_direction = 'CW'  # orbit direction: 'CW'==clockwise, 'CCW'==counter clockwise
    path.airspeed = 35

# waypoint definition
from message_types.msg_waypoints import msgWaypoints
waypoints = msgWaypoints()
waypoints.type = 'straight_line'
#waypoints.type = 'fillet'
#waypoints.type = 'dubins'
Va = PLAN.Va0
print("Speed for waypoints is: ", Va)
waypoints.add(np.array([[0, 0, -100]]).T, Va, np.radians(0), np.inf, 0, 0)
waypoints.add(np.array([[2000, 0, -100]]).T, Va, np.radians(45), np.inf, 0, 0)
waypoints.add(np.array([[0, -2000, -100]]).T, Va, np.radians(45), np.inf, 0, 0)
waypoints.add(np.array([[2000, 2000, -100]]).T, Va, np.radians(-135), np.inf, 0, 0)
waypoints.add(np.array([[0, 0, -100]]).T, Va, np.radians(0), np.inf, 0, 0)

print(waypoints.ned)
# initialize the simulation time
sim_time = SIM.start_time
previous_t = 0
plot_timer = 0
# main simulation loop
while sim_time < SIM.end_time:

    # -------observer-------------
    # measurements = mav.sensors()  # get sensor measurements
    # estimated_state = obsv.update(measurements)  # estimate states from measurements
    estimated_state = mav.true_state
   
    # -------path manager-------------
    path = path_manager.update(waypoints, PLAN.R_min, estimated_state)

    # -------path follower-------------
    autopilot_commands = path_follow.update(path, estimated_state)
    # autopilot_commands = path_follow.update(path, mav.true_state)  # for debugging

    # -------controller-------------
    delta, commanded_state = ctrl.update(autopilot_commands, estimated_state, previous_t, sim_time)
    previous_t = delta.throttle
    
    # -------physical system-------------
    current_wind = wind.update()  # get the new wind vector
    mav.update(delta, current_wind)  # propagate the MAV dynamics

    # -------update viewer-------------
    path_view.update(path, mav.true_state)  # plot path and MAV
    data_view.update(mav.true_state,  # true states
                     estimated_state,  # estimated states
                     commanded_state,  # commanded states
                     SIM.ts_simulation)
    ground.sendToVisualizer(mav.true_state, delta)
    if VIDEO == True:
        video.update(sim_time)

    # -------increment time-------------
    sim_time += SIM.ts_simulation

if VIDEO == True:
    video.close()