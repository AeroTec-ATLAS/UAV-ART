"""
mavSimPy 
    - Chapter 2 assignment for Beard & McLain, PUP, 2012
    - Update history:  
        2/24/2020 - RWB
"""
import sys
sys.path.append('..')
from video.mav_viewer import mavViewer
import parameters.simulation_parameters as SIM
from message_types.msg_state import msgState
from message_types.msg_delta import msgDelta
from telemetry.telemetry_Data import telemetryData
from tools.ground_connection import groundProxy
ground=groundProxy()
# initialize messages
state = msgState()  # instantiate state message
delta = msgDelta() 
localIP='192.168.1.237'
raspIP='192.168.1.15'
telemetry=telemetryData(localIP,raspIP)
vehicle=telemetry.vehicle
# initialize viewers and video
VIDEO = False  # True==write video, False==don't write video
#mav_view = mavViewer()
if VIDEO is True:
    from video.video_writer import videoWriter
    video = videoWriter(video_name="chap2_video.avi",
                        bounding_box=(0, 0, 1000, 1000),
                        output_rate=SIM.ts_video)

# initialize the simulation time
sim_time = SIM.start_time

# main simulation loop
while sim_time < SIM.end_time:
    # -------vary states to check viewer-------------
    state.pn = vehicle.location.local_frame.north
    state.pe = vehicle.location.local_frame.east
    state.h = vehicle.location.global_frame.alt
    state.phi = vehicle.attitude.roll
    state.theta = vehicle.attitude.pitch
    state.psi = vehicle.attitude.yaw 

    # -------update viewer and video-------------
    #mav_view.update(state)
    ground.sendToVisualizer(state, delta)
    if VIDEO is True:
        video.update(sim_time)

    # -------increment time-------------
    sim_time += SIM.ts_simulation

input("Press any key to exit...")
if VIDEO is True:
    video.close()



