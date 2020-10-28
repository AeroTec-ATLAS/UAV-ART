#Send data by UDP
# Connect to wifi hotspot and use ip: 10.3.141.1 port:10000
network_mode = True
local_ip='192.168.1.237'
raspberry_ip='192.168.1.17'
#Save Log Files
logging_mode = False

#Display data in terminal window
verbose = True


data_rate = 30      #ms
data_rate_gps = 1000 #ms
###########################


from time import sleep, time
from datetime import datetime

# Import DroneKit-Python
from dronekit import connect, VehicleMode

def get_connection_string():
    if network_mode:
        return local_ip +":14550"
    else:
        return '/dev/serial0'

def pause():
     print("Waiting 2s")
     sleep(2)

def get_log_file():
    import os
    fn = datetime.now().strftime('logs/%Y_%m_%d %H_%M_%S.log').split(' ')
    try:
        os.mkdir(fn[0])
    except:
        print("File exists")
        pass
    return open('/'.join(fn),"w")

connection_string = get_connection_string()

if network_mode:
    import subprocess
    subprocess.Popen('startRaspConnection.bat '+raspberry_ip+' '+local_ip, creationflags=subprocess.CREATE_NEW_CONSOLE)
# Connect to the Vehicle.
print("Connecting to vehicle on: %s" % (connection_string))
vehicle = connect(connection_string, wait_ready=True, baud=921600)

# Get some vehicle attributes (state)
print( "Get some vehicle attribute values:" )
print( " GPS: %s" % vehicle.gps_0 )
print( " Battery: %s" % vehicle.battery )
print( " Last Heartbeat: %s" % vehicle.last_heartbeat )
print( " Is Armable?: %s" % vehicle.is_armable )
print( " System status: %s" % vehicle.system_status.state )
print( " Mode: %s" % vehicle.mode.name )   # settable

pause()

if logging_mode:
    f = get_log_file()

print("\n|-- Starting data stream --|\n")
b = ""
w = False
sleep(0.5)

#vehicle.armed = True
st = time()

while 1:
    try:
        #b = "{0:8.4f} {1:8.4f} {2:8.4f}".format(vehicle.attitude.pitch, vehicle.attitude.yaw, vehicle.attitude.roll)
        att = str(vehicle.attitude)
        loc = str(vehicle.location.global_relative_frame)
        vel = str(vehicle.velocity)
        t = time()-st
        if b == att:
            if not w:
                print ("Warning: rate may be too low! (current: %d ms)",data_rate)
                w = True
            sleep(0.001)
            continue
        else:
            b = "{0} {1} {2}".format(att,loc,vel)
            l = 'Time: {0:7.3f}s | {1}'.format(t,b)
            if logging_mode:
                f.write(l+'\n')
            
            if verbose:
                print(l)
            
            if w:
                w = False
                
        #sleep(float(data_rate)/1000 + (t +st -time()))
        
    except KeyboardInterrupt:
        break
vehicle.armed = False
print("\n|--- End of data stream ---|\n")

# Close File
if logging_mode:
    f.close()

# Close vehicle object before exiting script
vehicle.close()

print("Completed")
pause()