from tools.telemetry_Data import telemetryData

class Sensors:
    def __init__(self, localIP='',raspIP=''):
        self.telemetry = telemetryData(localIP,raspIP)

    def update(self, state):
        vehicle = self.telemetry.vehicle
        state.pn = vehicle.location.local_frame.north
        state.pe = vehicle.location.local_frame.east
        state.h = vehicle.location.global_frame.alt
        state.phi = vehicle.attitude.roll
        state.theta = vehicle.attitude.pitch
        state.psi = vehicle.attitude.yaw 
        return state