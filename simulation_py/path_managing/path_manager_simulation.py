"""
mavsim_python
    - Chapter 11 assignment for Beard & McLain, PUP, 2012
    - Last Update:
        3/26/2019 - RWB
        2/27/2020 - RWB
"""
import sys
sys.path.append('..')
import numpy as np
import copy
import parameters.simulation_parameters as SIM
import parameters.planner_parameters as PLAN

from kinematics.data_viewer import dataViewer
from dynamics.wind_simulation import windSimulation
from control.autopilot import autopilot
from dynamics.mav_dynamics import mavDynamics
#from chap8.observer import Observer
from path_following.path_follower import path_follower
from path_managing.path_manager import pathManager
from path_managing.waypoint_viewer import waypointViewer

# initialize the visualization
VIDEO = False  # True==write video, False==don't write video
waypoint_view = waypointViewer()  # initialize the viewer
data_view = dataViewer()  # initialize view of data plots
if VIDEO is True:
    from video.video_writer import videoWriter
    video = videoWriter(video_name="chap11_video.avi",
                        bounding_box=(0, 0, 1000, 1000),
                        output_rate=SIM.ts_video)

# initialize elements of the architecture
wind = windSimulation(SIM.ts_simulation)
mav = mavDynamics(SIM.ts_simulation)
autopilot = autopilot(SIM.ts_simulation)
initial_state = copy.deepcopy(mav.true_state)
#observer = observer(SIM.ts_simulation, initial_state)
path_follower = path_follower()
path_manager = pathManager()

# waypoint definition
from message_types.msg_waypoints import msgWaypoints
waypoints = msgWaypoints()
#waypoints.type = 'straight_line'
#waypoints.type = 'fillet'
waypoints.type = 'dubins'
Va = PLAN.Va0
waypoints.add(np.array([[0, 0, -100]]).T, Va, np.radians(0), np.inf, 0, 0)
waypoints.add(np.array([[1000, 0, -100]]).T, Va, np.radians(45), np.inf, 0, 0)
waypoints.add(np.array([[0, 1000, -100]]).T, Va, np.radians(45), np.inf, 0, 0)
waypoints.add(np.array([[1000, 1000, -100]]).T, Va, np.radians(-135), np.inf, 0, 0)
waypoints.add(np.array([[0, 0, -100]]).T, Va, np.radians(0), np.inf, 0, 0)

# initialize the simulation time
sim_time = SIM.start_time
plot_timer = 0

# main simulation loop
print("Press Command-Q to exit...")
while sim_time < SIM.end_time:
    # -------observer-------------
    measurements = mav.sensors()  # get sensor measurements
    estimated_state = mav.true_state #observer.update(measurements)  # estimate states from measurements

    # -------path manager-------------
    path = path_manager.update(waypoints, PLAN.R_min, estimated_state)

    # -------path follower-------------
    autopilot_commands = path_follower.update(path, estimated_state)

    # -------autopilot-------------
    delta, commanded_state = autopilot.update(autopilot_commands, estimated_state, sim_time)


    # -------physical system-------------
    current_wind = wind.update()  # get the new wind vector
    mav.update(delta, current_wind)  # propagate the MAV dynamics

    # -------update viewer-------------
    if plot_timer > SIM.ts_plotting:
        waypoint_view.update(mav.true_state, path, waypoints)  # plot path and MAV
        data_view.update(mav.true_state,  # true states
                         estimated_state,  # estimated states
                         commanded_state,  # commanded states
                         delta,  # input to aircraft
                         SIM.ts_plotting)
        plot_timer = 0
    plot_timer += SIM.ts_simulation

    if VIDEO is True:
        video.update(sim_time)

    # -------increment time-------------
    sim_time += SIM.ts_simulation

if VIDEO is True:
    video.close()




