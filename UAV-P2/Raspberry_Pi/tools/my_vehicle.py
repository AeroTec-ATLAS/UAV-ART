"""
© Copyright 2015-2016, 3D Robotics.
my_vehicle.py:
Custom Vehicle subclass to add IMU data.
GPS_RAW_INT
"""

from dronekit import Vehicle


class HighResIMU(object):
    """
    The HighRes IMU readings for the usual 9DOF sensor setup. 
    The IMU readings in SI units in NED body frame
    
    The message definition is here: https://mavlink.io/en/messages/
    
    :param time_boot_us: Timestamp (microseconds since system boot). #Note, not milliseconds as per spec
    :param xacc: X acceleration (mg)
    :param yacc: Y acceleration (mg)
    :param zacc: Z acceleration (mg)
    :param xgyro: Angular speed around X axis (millirad /sec)
    :param ygyro: Angular speed around Y axis (millirad /sec)
    :param zgyro: Angular speed around Z axis (millirad /sec)
    :param xmag: X Magnetic field (milli tesla)
    :param ymag: Y Magnetic field (milli tesla)
    :param zmag: Z Magnetic field (milli tesla)    
    """
    def __init__(self, time_sec=None, xacc=None, yacc=None, zacc=None, xgyro=None, ygyro=None, zgyro=None, xmag=None, ymag=None, zmag=None, abs_pressure=None, diff_pressure=None, pressure_alt=None, temperature=None, fields_updated=None):
        """
        HighResIMU object constructor.
        """
        self.time_sec = time_sec
        self.xacc = xacc
        self.yacc = yacc
        self.zacc = zacc
        self.xgyro = zgyro
        self.ygyro = ygyro
        self.zgyro = zgyro
        self.xmag = xmag        
        self.ymag = ymag
        self.zmag = zmag
        self.abs_pressure=abs_pressure
        self.diff_pressure=diff_pressure      
        
    def __str__(self):
        """
        String representation used to print the RawIMU object. 
        """
        return "RAW_IMU: time_boot_us={},xacc={},yacc={},zacc={},xgyro={},ygyro={},zgyro={},xmag={},ymag={},zmag={}".format(self.time_boot_us, self.xacc, self.yacc,self.zacc,self.xgyro,self.ygyro,self.zgyro,self.xmag,self.ymag,self.zmag)

class GPSRawInt(object):
    """
    The HighRes IMU readings for the usual 9DOF sensor setup. 
    The IMU readings in SI units in NED body frame
    
    The message definition is here: https://mavlink.io/en/messages/
    
    :param time_boot_us: Timestamp (microseconds since system boot). #Note, not milliseconds as per spec
    :param xacc: X acceleration (mg)
    :param yacc: Y acceleration (mg)
    :param zacc: Z acceleration (mg)
    :param xgyro: Angular speed around X axis (millirad /sec)
    :param ygyro: Angular speed around Y axis (millirad /sec)
    :param zgyro: Angular speed around Z axis (millirad /sec)
    :param xmag: X Magnetic field (milli tesla)
    :param ymag: Y Magnetic field (milli tesla)
    :param zmag: Z Magnetic field (milli tesla)    
    """
    def __init__(self, time_sec=None, fix_type=None, lat=None, lon=None, alt=None, eph=None, epv=None, vel=None, cog=None, satellites_visible=None):
        """
        HighResIMU object constructor.
        """
        self.time_sec = time_sec
        self.lat = lat
        self.lon = lon
        self.alt = alt
        self.vel = vel
        self.cog = cog    
        
    def __str__(self):
        """
        String representation used to print the RawIMU object. 
        """
        return "RAW_IMU: time_boot_us={},xacc={},yacc={},zacc={},xgyro={},ygyro={},zgyro={},xmag={},ymag={},zmag={}".format(self.time_boot_us, self.xacc, self.yacc,self.zacc,self.xgyro,self.ygyro,self.zgyro,self.xmag,self.ymag,self.zmag)

class RCChannels(object):
   
    def __init__(self, time_sec=None, port=None, chan1_scaled=None, chan2_scaled=None, chan3_scaled=None, chan4_scaled=None, chan5_scaled=None, chan6_scaled=None, chan7_scaled=None, chan8_scaled=None, rssi=None):
        """
        RCChannels object constructor.
        """
        self.time_sec = time_sec
        self.rc_1 = chan1_scaled/100.
        self.rc_2 = chan2_scaled/100.
        self.rc_3 = chan3_scaled/100.
        self.rc_4 = chan4_scaled/100.
        self.rc_5 = chan5_scaled/100.
        self.rc_6 = chan6_scaled/100.
        self.rc_7 = chan7_scaled/100.
        self.rc_8 = chan8_scaled/100.

        
    def __str__(self):
        """
        String representation used to print the RawIMU object. 
        """
        return "RAW_IMU: time_boot_us={},xacc={},yacc={},zacc={},xgyro={},ygyro={},zgyro={},xmag={},ymag={},zmag={}".format(self.time_boot_us, self.xacc, self.yacc,self.zacc,self.xgyro,self.ygyro,self.zgyro,self.xmag,self.ymag,self.zmag)


class MyVehicle(Vehicle):
    def __init__(self, *args):
        super(MyVehicle, self).__init__(*args)

        # Create an Vehicle.raw_imu object with initial values set to None.
        self._highres_imu = HighResIMU()
        self._gps_raw_int = GPSRawInt()
        self._rc_channels = RCChannels()

        # Create a message listener using the decorator.   
        @self.on_message('HIGHRES_IMU')
        def listener(self, name, message):
            """
            The listener is called for messages that contain the string specified in the decorator,
            passing the vehicle, message name, and the message.
            
            The listener writes the message to the (newly attached) ``vehicle._highres_imu`` object 
            and notifies observers.
            """
            self._highres_imu.time_sec=message.time_usec/(10^6) # TODO: Consistency in units used
            self._highres_imu.xacc=message.xacc
            self._highres_imu.yacc=message.yacc
            self._highres_imu.zacc=message.zacc
            self._highres_imu.xgyro=message.xgyro
            self._highres_imu.ygyro=message.ygyro
            self._highres_imu.zgyro=message.zgyro
            self._highres_imu.xmag=message.xmag
            self._highres_imu.ymag=message.ymag
            self._highres_imu.zmag=message.zmag
            self._highres_imu.abs_pressure=message.abs_pressure
            self.highres_imu.diff_pressure=message.diff_pressure

            
            # Notify all observers of new message (with new value)
            #   Note that argument `cache=False` by default so listeners
            #   are updated with every new message
            self.notify_attribute_listeners('highres_imu', self._highres_imu) 

        @self.on_message('GPS_RAW_INT')
        def listener(self, name, message):
            self._gps_raw_int.time_sec=message.time_usec/(10^6)
            self._gps_raw_int.lat=message.lat
            self._gps_raw_int.lon=message.lon
            self._gps_raw_int.alt=message.alt/1000.0
            self._gps_raw_int.vel=message.vel/100.0
            self._gps_raw_int.cog=message.cog/100.0

        @self.on_message('RC_CHANNELS_SCALED')
        def listener(self, name, message):
            self._rc_channels.time_sec=message.time_usec/(10^6)
            self._rc_channels.elevator=message.rc_1 # TODO: Attribute control surfaces
            self._rc_channels.aileron=message.rc_2  # TODO: Calibrate according to max deflection
            self._rc_channels.rudder=message.rc_3
            self._rc_channels.throttle=message.rc_4

    @property
    def highres_imu(self):
        return self._highres_imu

    @property
    def gps_raw_int(self):
        return self._gps_raw_int
    
    @property
    def rc_channels(self):
        return self._rc_channels