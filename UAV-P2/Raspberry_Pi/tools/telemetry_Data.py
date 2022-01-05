from pymavlink import mavutil
from tools.my_vehicle import MyVehicle

class telemetryData():
    def __init__(self, USB=False):
        if not USB:
            self.mavlink = mavutil.mavlink_connection("/dev/serial0", baud=57600)
        else:
            self.mavlink = mavutil.mavlink_connection("/dev/ttyAMA0")
        self.mavlink.wait_heartbeat()

    def getIMU(self):
        try:
            return self.mavlink.messages['HIGHRES_IMU']
        except:
            pass

    def getAttitude(self):
        try:
            return self.mavlink.messages['ATTITUDE']
        except:
            pass

    def getGPS(self):
        try:
            return self.mavlink.messages['GLOBAL_POSITION_INT']
        except:
            pass

    def getPosition(self):
        try:
            return self.mavlink.messages['LOCAL_POSITION_NED']
        except:
            pass

    def getWind(self):
        try:
            return self.mavlink.messages['WIND_COV']
        except:
            pass

    def getVFR(self):
        try:
            return self.mavlink.messages['VFR_HUD']
        except:
            pass

    def getRC(self):
        try:
            return self.mavlink.messages['RC_CHANNELS_SCALED']
        except:
            pass

    def getTime(self):
        return self.mavlink.recv_match(type='SYSTEM_TIME',blocking=True)