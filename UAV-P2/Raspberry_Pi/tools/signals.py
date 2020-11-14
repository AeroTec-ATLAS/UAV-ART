"""
mavsim_python
    - Chapter 5 assignment for Beard & McLain, PUP, 2012
    - Last Update:
        2/5/2019 - RWB
"""
import numpy as np
import matplotlib.pyplot as plt

class signals:
    def __init__(self,
                 amplitude=1.0,
                 frequency=1.0,
                 start_time=0.0,
                 duration=0.01,
                 dc_offset = 0.0):
        self.amplitude = amplitude
        self.frequency = frequency  # radians/sec
        self.period = 1.0/frequency
        self.start_time = start_time  # sec
        self.duration = duration
        self.dc_offset = dc_offset
        self.last_switch = start_time

    def step(self, time):
        '''Step function'''
        if time >= self.start_time:
            y = self.amplitude
        else:
            y = 0.0
        return y + self.dc_offset

    def sinusoid(self, time):
        '''sinusoidal function'''
        if time >= self.start_time:
            y = self.amplitude*np.sin(self.frequency * time)
        else:
            y = 0.0
        return y + self.dc_offset

    def square(self, time):
        '''square wave function'''
        if time < self.start_time:
            y = 0.0
        elif time < self.last_switch + self.period / 2.0:
            y = self.amplitude
        else:
            y = -self.amplitude
        if time >= self.last_switch + self.period:
            self.last_switch = time
        return y + self.dc_offset

    def sawtooth(self, time):
        '''sawtooth wave function'''
        if time < self.start_time:
            y = 0.0
        else:
            y = self.amplitude * (time-self.last_switch)
        if time >= self.last_switch + self.period:
            self.last_switch = time
        return y + self.dc_offset

    def impulse(self, time):
        '''impulse function'''
        if (time >= self.start_time) \
                and (time <= self.start_time+self.duration):
            y = self.amplitude
        else:
            y = 0.0
        return y + self.dc_offset


    def doublet(self, time):
        '''doublet function'''
        if (time >= self.start_time) \
                and (time < self.start_time + self.duration):
            y = self.amplitude
        elif (time >= self.start_time + self.duration) \
                and (time <= self.start_time + 2*self.duration):
            y = -self.amplitude
        else:
            y = 0.0
        return y + self.dc_offset

    def random(self, time):
        '''random function'''
        if (time >= self.start_time):
            y = self.amplitude*np.random.randn()
        else:
            y = 0.0
        return y + self.dc_offset

if __name__ == "__main__":
    # instantiate the system
    input = signals(amplitude=2.0, frequency=2.0)
    Ts = 0.01

    # main simulation loop
    sim_time = -1.0
    time = [sim_time]
    #output = [input.sinusoid(sim_time)]
    #output = [input.step(sim_time)]
    #output = [input.impulse(sim_time)]
    #output = [input.doublet(sim_time)]
    #output = [input.random(sim_time)]
    #output = [input.square(sim_time)]
    output = [input.sawtooth(sim_time)]
    while sim_time < 10.0:
        #y = input.sinusoid(sim_time)
        #y = input.step(sim_time)
        #y = input.impulse(sim_time)
        #y = input.doublet(sim_time)
        #y = input.random(sim_time)
        #y = input.square(sim_time)
        y = input.sawtooth(sim_time)

        sim_time += Ts   # increment the simulation time

        # update date for plotting
        time.append(sim_time)
        output.append(y)

    # plot output vs time
    plt.plot(time, output)
    plt.show()


