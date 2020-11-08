from dronekit import connect


class telemetryData():
    def __init__(self, localIP='', raspberryIP=''):
        self.localIP = localIP
        self.raspberryip = raspberryIP
        if localIP != '' and raspberryIP != '':
            self.networkMode = True
        else:
            self.networkMode = False
        if self.networkMode:
            import subprocess
            subprocess.Popen('startRaspConnection.bat ' + self.raspberryip + ' ' + self.localIP, creationflags=subprocess.CREATE_NEW_CONSOLE)

        connection_string = self.get_connection_string()
        print("Connecting to vehicle on: %s" % (connection_string))
        self.vehicle = connect(connection_string, wait_ready=True, baud=921600)

    def get_connection_string(self):
        if self.networkMode:
            return self.localIP + ":14550"
        else:
            return '/dev/serial0'
