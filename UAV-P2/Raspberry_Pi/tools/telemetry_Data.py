from pymavlink import mavutil
from tools.my_vehicle import MyVehicle
import time

class telemetryData():
    def __init__(self, USB=False):
        if not USB:
            self.mavlink = mavutil.mavlink_connection("/dev/serial0", baud=57600)
        else:
            self.mavlink = mavutil.mavlink_connection("/dev/ttyAMA0")
        self.mavlink.wait_heartbeat()
        print('Connected to Pixhawk')
        self.request_message_interval(mavutil.mavlink.MAVLINK_MSG_ID_SYSTEM_TIME, 10)
        self.request_message_interval(mavutil.mavlink.MAVLINK_MSG_ID_ATTITUDE, 200)
        self.request_message_interval(mavutil.mavlink.MAVLINK_MSG_ID_HIGHRES_IMU, 200)
        self.request_message_interval(mavutil.mavlink.MAVLINK_MSG_ID_WIND_COV, 200)
        self.request_message_interval(mavutil.mavlink.MAVLINK_MSG_ID_GLOBAL_POSITION_INT, 10)
        self.request_message_interval(mavutil.mavlink.MAVLINK_MSG_ID_LOCAL_POSITION_NED, 10)
        self.request_message_interval(mavutil.mavlink.MAVLINK_MSG_ID_RC_CHANNELS, 200)
        self.request_message_interval(mavutil.mavlink.MAVLINK_MSG_ID_VFR_HUD, 50)
        print('Awaiting GPS')
        self.mavlink.recv_match(type='GLOBAL_POSITION_INT', blocking=True, timeout=10)
        print('GPS Connected or GPS Timeout')
        timeUsec = self.mavlink.recv_match(type='SYSTEM_TIME', blocking=True).time_unix_usec
        clk_id = time.CLOCK_REALTIME
        print(clk_id)
        print(float(timeUsec)/1000.)
        time.clock_settime(clk_id, float(timeUsec)/1E6)
        print('Time set')
        print('Arming Pixhawk')
        self.arm()
        self.mavlink.motors_armed_wait()
        print('Pixhawk Armed')
        
        
    def request_message_interval(self, message_id: int, frequency_hz: float):
        """
        Request MAVLink message in a desired frequency,
        documentation for SET_MESSAGE_INTERVAL:
            https://mavlink.io/en/messages/common.html#MAV_CMD_SET_MESSAGE_INTERVAL

        Args:
            message_id (int): MAVLink message ID
            frequency_hz (float): Desired frequency in Hz
        """
        self.mavlink.mav.command_long_send(
            self.mavlink.target_system, self.mavlink.target_component,
            mavutil.mavlink.MAV_CMD_SET_MESSAGE_INTERVAL, 0,
            message_id, # The MAVLink message ID
            1e6 / frequency_hz, # The interval between two messages in microseconds. Set to -1 to disable and 0 to request default rate.
            0, # Target address of message stream (if message has target address fields). 0: Flight-stack default (recommended), 1: address of requestor, 2: broadcast.
            0, 0, 0, 0)
        
    def arm(self):
        self.mavlink.mav.command_long_send(
            self.mavlink.target_system,
            self.mavlink.target_component,
            mavutil.mavlink.MAV_CMD_COMPONENT_ARM_DISARM,
            0,
            1, 0, 0, 0, 0, 0, 0)
        
    def disarm(self):
        self.mavlink.mav.command_long_send(
            self.mavlink.target_system,
            self.mavlink.target_component,
            mavutil.mavlink.MAV_CMD_COMPONENT_ARM_DISARM,
            0,
            0, 0, 0, 0, 0, 0, 0)

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
