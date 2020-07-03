import tkinter as tk


class autopilotCommand:

    def __init__(self, defaultVa=35, defaultChi=0, defaultH=100):
        self.root = tk.Tk()
        self.root.title('Autopilot Input')
        self.paused = False
        self.open = True
        self.root.bind("p", self.pause)
        self.root.bind("q", self.close)
        self.autopilotState = tk.Label(self.root, text='Autopilot ON', bg='green')
        self.slideVa = tk.Scale(self.root, from_=50, to=0, label='Va', length=150)
        self.slideChi = tk.Scale(self.root, from_=-180, to=180, orient=tk.HORIZONTAL, label='Chi', length=360)
        self.slideH = tk.Scale(self.root, from_=200, to=0, label='Altitude', length=150)
        self.slideVa.set(defaultVa)
        self.slideChi.set(defaultChi)
        self.slideH.set(defaultH)
        self.autopilotState.pack(side='top')
        self.slideVa.pack(side='left')
        self.slideChi.pack(side='left')
        self.slideH.pack(side='left')
        self.autopilot = True

    def setAutopilot(self, autopilotState):
        self.autopilot = autopilotState
        if autopilotState:
            self.autopilotState.config(text='Autopilot ON', bg='green')
        else:
            self.autopilotState.config(text='Autopilot OFF', bg='red')

    def pause(self, event):
        if self.paused:
            self.paused = False
        else:
            self.paused = True

    def close(self, event):
        self.open = False
