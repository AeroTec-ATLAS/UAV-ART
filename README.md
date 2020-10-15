# UAV-ART (UAV Alameda Research Team)
## UAV-P1

We are a university research team working on an autonomous, unmanned aircraft! We are a part of AeroTec (the Aerospace Engineering student's group of Instituto Superior Técnico in Lisbon). You can find more about us here: https://aerotec.pt/. We are divided into 4 different teams, Structures, Systems, Control and Vision. You can also find the differente CAD models for our aeromodels here: *LINK DA DRIVE*

In this repository you can find the code that runs our aircraft, divided into three main sections, simualation_m (dedicated to the Matlab simulation of the UAV), simulation_py (dedicated to the Python simulation of the UAV), and vision (dedicated to the work of the vision team, which will later be integrated into the control of the aircraft). So far we have only tested our controller in a simulation environment, however, we expect to soon be able to test it on the aeromodel built by our structures team!

Most of our work is based on *Small Unmanned Aircraft* by R. Beard and T. McLain, whose repository can be consulted here: https://magiccvs.byu.edu/gitlab/uavbook/mavsim_template_files. You should also check out *DroneKit Python* (https://github.com/dronekit/dronekit-python) and *OpenCV* (https://opencv.org/).

### simulation_m
To run the Matlab simulation, simply run the _main.m_ file located in the autopilot folder. An animation will run once the simulation is done.

### simulation_py
You can choose to run different simulations, but we recommend trying the two main ones, one where you can try the autopilot controller with an airspeed, heading and altitude command as well as manual control of the aircraft, or one where the autopilot will follow a path provided.
#### Controller
To run this simulation, run the _mavsim_chap6.py_ file located in the control folder. Should a PS4 controller be plugged in, you'll be able to control the aircraft and the autopilot switch with it. In this case, the left analog will control both the ailerons and the elevator, the right analog controls the rudder, the R2 button controls the throttle and the circle and triangle button, turn the autopilot off and on respectively. When the autopilot is on, the input to it can be defined in the window that will open along the simulation.
#### Path following
To run this simulation, run the _mavsim_chap7.py_ file located in the path_following folder. You can either follow a straight line path or an orbital path, and you can define the path to follow inside the _mavsim_chap7.py_ file.
![UAV](https://i.imgur.com/LkZeDza.png)
![AeroTec](https://imgur.com/a/cMBN6Ov)
![IST](https://imgur.com/a/jLdXv5b)

We thank everyone who has contributed to the project so far for their amazing work!




