import tkinter as tk


class autopilotCommand:

    def __init__(self, defaultVa=35, defaultChi=0, defaultH=100):
        self.root = tk.Tk()
        self.root.title('Autopilot Input')
        self.slideVa = tk.Scale(self.root, from_=50, to=0, label='Va', length=150)
        self.slideChi = tk.Scale(self.root, from_=-180, to=180, orient=tk.HORIZONTAL, label='Chi', length=150)
        self.slideH = tk.Scale(self.root, from_=200, to=0, label='Altitude', length=150)
        self.slideVa.set(defaultVa)
        self.slideChi.set(defaultChi)
        self.slideH.set(defaultH)
        self.slideVa.pack(side='left')
        self.slideChi.pack(side='left')
        self.slideH.pack(side='left')
