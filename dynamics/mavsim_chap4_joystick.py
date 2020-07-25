"""
mavsimPy
    - Chapter 4 assignment for Beard & McLain, PUP, 2012
    - Update history:  
        12/27/2018 - RWB
        1/17/2019 - RWB
        2/24/2020 - RWB
"""
import sys
sys.path.append('..')
import numpy as np
import parameters.simulation_parameters as SIM

from video.mav_viewer import mavViewer
from kinematics.data_viewer import dataViewer
from dynamics.mav_dynamics import mavDynamics
from dynamics.wind_simulation import windSimulation
from tools.log import log
from message_types.msg_delta import msgDelta
from tools.joystick_Input import joystick

controlJoystick = joystick(True)
# initialize the visualization
VIDEO = False  # True==write video, False==don't write video
mav_view = mavViewer()  # initialize the mav viewer
data_view = dataViewer()  # initialize view of data plots
logFile = log('dados_log.txt')
if VIDEO is True:
    from video.video_writer import videoWriter
    video = videoWriter(video_name="chap4_video.avi",
                        bounding_box=(0, 0, 1000, 1000),
                        output_rate=SIM.ts_video)

# initialize elements of the architecture
wind = windSimulation(SIM.ts_simulation)
wind._steady_state = np.array([[5., 2., 0.]]).T  # Steady wind in NED frame
mav = mavDynamics(SIM.ts_simulation)

# initialize the simulation time
sim_time = SIM.start_time
plot_time = sim_time

delta = msgDelta()

# main simulation loop
while sim_time < SIM.end_time:
    delta_e, delta_a, delta_r, delta_t, autopilot = controlJoystick.getInputs()
    # -------set control surfaces-------------
    #delta_e += 0.001 * (np.random.random() - 0.5)
    #delta_a += 0.001 * (np.random.random() - 0.5)
    #delta_r += 0.001 * (np.random.random() - 0.5)
    #delta_t += 0.001 * (np.random.random() - 0.5)
    delta.from_array(np.array([[delta_e, delta_a, delta_r, delta_t]]).T)
    # transpose to make it a column vector

    # -------physical system-------------
    current_wind = wind.update()  # get the new wind vector
    mav.update(delta, current_wind)  # propagate the MAV dynamics

    # -------update viewer-------------
    if sim_time - plot_time > SIM.ts_plotting:
        mav_view.update(mav.true_state)  # plot body of MAV
        plot_time = sim_time
    data_view.update(mav.true_state,  # true states
                     mav.true_state,  # estimated states
                     mav.true_state,  # commanded states
                     SIM.ts_simulation)
    logFile.addEntry(mav.true_state, delta, sim_time)
    if VIDEO is True:
        video.update(sim_time)

    # -------increment time-------------
    sim_time += SIM.ts_simulation
    if mav.true_state.h <= 0:  # Touches the ground
        break
logFile.closeLog()
input("Press any key to exit...")
if VIDEO is True:
    video.close()
