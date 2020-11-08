import sys
sys.path.append('..')
from socket import *
from message_types.msg_state import msgState
from message_types.msg_delta import msgDelta
import json

class groundProxy:
    def __init__(self, host='127.0.0.1', port=14501):
        self.host=host
        self.port=port
        self.server=socket(AF_INET, SOCK_DGRAM)

    def sendToVisualizer(self, state, delta):
        localState=state
        localState.aileron=delta.aileron
        localState.elevator=delta.elevator
        localState.throttle=delta.throttle
        localState.rudder=delta.rudder
        self.server.sendto(json.dumps(localState.__dict__).encode("UTF-8"), (self.host,self.port))

    def close(self):
        self.server.close()
