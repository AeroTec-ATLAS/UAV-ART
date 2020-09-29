"""
mavsim_python
    - Chapter 5 assignment for Beard & McLain, PUP, 2012
    - Last Update:
        2/2/2019 - RWB
"""
import sys
sys.path.append('..')
import numpy as np
import parameters.simulation_parameters as SIM

from video.mav_viewer import mavViewer
from kinematics.data_viewer import dataViewer
from dynamics.mav_dynamics import mavDynamics
from dynamics.wind_simulation import windSimulation
from dynamics_linear.trim import compute_trim
from dynamics_linear.compute_models import compute_model
from tools.signals import signals

# initialize the visualization
VIDEO = False  # True==write video, False==don't write video
mav_view = mavViewer()  # initialize the mav viewer
data_view = dataViewer()  # initialize view of data plots
if VIDEO is True:
    from video.video_writer import videoWriter
    video = videoWriter(video_name="chap5_video.avi",
                        bounding_box=(0, 0, 1000, 1000),
                        output_rate=SIM.ts_video)

# initialize elements of the architecture
wind = windSimulation(SIM.ts_simulation)
mav = mavDynamics(SIM.ts_simulation)

# use compute_trim function to compute trim state and trim input
Va = 25.
gamma = 10.*np.pi/180.
trim_state, trim_input = compute_trim(mav, Va, gamma)
mav._state = trim_state  # set the initial state of the mav to the trim state
delta = trim_input  # set input to constant constant trim input

# # compute the state space model linearized about trim
compute_model(mav, trim_state, trim_input)

# this signal will be used to excite modes
input_signal = signals(amplitude=.05,
                       duration=0.01,
                       start_time=2.0)

# initialize the simulation time
sim_time = SIM.start_time

# main simulation loop
print("Press Command-Q to exit...")
while sim_time < SIM.end_time:

    # -------physical system-------------
    current_wind = np.zeros((6,1))
    # this input excites the phugoid mode by adding an impulse at t=5.0
    # delta[0][0] += input_signal.impulse(sim_time)
    mav.update(delta, current_wind)  # propagate the MAV dynamics

    # -------update viewer-------------
    mav_view.update(mav.true_state)  # plot body of MAV
    data_view.update(mav.true_state,  # true states
                     mav.true_state,   # estimated states
                     mav.true_state,  # commanded states
                     SIM.ts_simulation)
    if VIDEO is True:
        video.update(sim_time)

    # -------increment time-------------
    sim_time += SIM.ts_simulation

if VIDEO is True:
    video.close()




