"""
mavsim_python
    - Chapter 6 assignment for Beard & McLain, PUP, 2012
    - Last Update:
        2/5/2019 - RWB
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
from control.autopilot import autopilot
from tools.signals import signals
from tools.autopilot_Command import autopilotCommand
from tools.joystick_Input import joystick

controlJoystick = joystick()
# initialize the visualization
VIDEO = False  # True==write video, False==don't write video
mav_view = mavViewer()  # initialize the mav viewer
data_view = dataViewer()  # initialize view of data plots
if VIDEO is True:
    from video.video_writer import videoWriter
    video = videoWriter(video_name="chap6_video.avi", bounding_box=(0, 0, 1000, 1000), output_rate=SIM.ts_video)

# initialize elements of the architecture
wind = windSimulation(SIM.ts_simulation)
wind._steady_state = np.array([[5., 2., 0.]]).T  # Steady wind in NED frame
mav = mavDynamics(SIM.ts_simulation)
ctrl = autopilot(SIM.ts_simulation)

# autopilot commands
from message_types.msg_autopilot import msgAutopilot
commands = msgAutopilot()

Va_command = signals(dc_offset=35.0, amplitude=3.0, start_time=2.0, frequency=0.01)

h_command = signals(dc_offset=100.0, amplitude=30.0, start_time=0.0, frequency=0.02)

chi_command = signals(dc_offset=np.radians(180), amplitude=np.radians(45), start_time=5.0, frequency=0.015)

commandWindow = autopilotCommand()
# initialize the simulation time
sim_time = SIM.start_time
# main simulation loop
while sim_time < SIM.end_time:
    delta_e, delta_a, delta_r, delta_t, autopilot = controlJoystick.getInputs()
    if autopilot != 2:
        commandWindow.setAutopilot(autopilot)

    # -------autopilot commands-------------
    commandWindow.root.update_idletasks()
    commandWindow.root.update()
    commands.airspeed_command = commandWindow.slideVa.get()  # Va_command.square(sim_time)
    commands.course_command = np.deg2rad(commandWindow.slideChi.get())  # chi_command.square(sim_time)
    commands.altitude_command = commandWindow.slideH.get()  # h_command.square(sim_time)

# -------controller-------------
    if not commandWindow.paused:
        estimated_state = mav.true_state  # uses true states in the control
        delta, commanded_state = ctrl.update(commands, estimated_state, sim_time)
        if (not commandWindow.autopilot):
            delta.from_array(np.array([[delta_e, delta_a, delta_r, delta_t]]).T)

# -------physical system-------------
        current_wind = wind.update()  # get the new wind vector
        mav.update(delta, current_wind)  # propagate the MAV dynamics

    # -------update viewer-------------
        mav_view.update(mav.true_state)  # plot body of MAV
        data_view.update(mav.true_state,  # true states
                         estimated_state,  # estimated states
                         commanded_state,  # commanded states
                         delta,				
                         SIM.ts_simulation)
    if VIDEO is True:
        video.update(sim_time)
# -------increment time-------------
    if not commandWindow.paused:
        sim_time += SIM.ts_simulation
    if not commandWindow.open:
        break
input("Press any key to shutdown...")
if VIDEO is True:
    video.close()
