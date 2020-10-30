# UAV-ART (UAV Alameda Research Team)
## *Innovating the ART of flying*

We are a university research team working on an autonomous, unmanned aircraft! We are a part of AeroTec (the Aerospace Engineering student's group of Instituto Superior Técnico in Lisbon). You can find more about us here: https://aerotec.pt/. We are divided into 4 different teams, Structures, Systems, Control and Vision.

In this repository you can find the code that runs our aircraft, divided into three main sections, simualation_m (dedicated to the Matlab simulation of the UAV), simulation_py (dedicated to the Python simulation of the UAV), and vision (dedicated to the work of the vision team, which will later be integrated into the control of the aircraft). There are also two other sections, UAV-P2 and ground_station, dedicated to the code that runs onboard the aircraft and the code to visualize sensor data, respectively. Inside each folder you'll find the README for those files. So far we have only tested our controller in a simulation environment, however, we expect to soon be able to test it on the aeromodel built by our structures team! You can see the progresses we've made in the past year in this short ["A Year in review"](https://youtu.be/h7s87GzxMtY).

Most of our work is based on *Small Unmanned Aircraft* by R. Beard and T. McLain, whose repository can be consulted here: https://magiccvs.byu.edu/gitlab/uavbook/mavsim_template_files. You should also check out *DroneKit Python* (https://github.com/dronekit/dronekit-python) and *OpenCV* (https://opencv.org/).

### System Architecture
Our flight controller was designed taking into account the linearised aircraft dynamics, and it is organised into two main blocks: the path-follower which given a desired path in three-dimensional space provides altitude, course, and airspeed references to another block, the autopilot, which ultimately inputs commands to the control surfaces and motor so as to follow the defined path. It is worth pointing out that our controller was designed based on the assumptions that it is run on a fixed wing aircraft, with no flaps, and with a "T" shaped tail. 

The design of the path-following controller is yet to be complete. At this stage, two guidance laws are being developed for tracking straight-line segments and constant-altitude circular orbits. These two basic blocks shall be later employed to synthesise more complex paths which pass through a set of pre-established waypoints.

On board our aircraft we have (for the time being) a Raspberry Pi 3 Model B+, a Pixhawk (with a GPS antenna and running the PX4 firmware) and all other eletronic equipment required to power the motor and servos. All sensor data is gathered in the Pixhawk, which then routes this data through the TELEM2 port using Mavlink to the Raspberry Pi. This data is then processed in the Raspberry Pi, where our flight controller is running, and the servo inputs are calculated here. These are then converted to PWM signals, transmitted through the GPIO to the fail-safe board, and from there these signals go to each individual servo, in order to actuate the control surfaces. 

### Structures
You can find the model for our aeromodel [here](https://viewer.autodesk.com/id/dXJuOmFkc2sub2JqZWN0czpvcy5vYmplY3Q6YTM2MHZpZXdlci90NjM3MzkxNTg4NDM0NTcwNDc4Xzc3N2RkZjkwLWM5M2ItNGViOS05NDRlLTVlNTQ3OTU4ZjY5NC5jb2xsYWJvcmF0aW9u?sheetId=OWNjYjFlZGQtZDQ0MC00ZTVmLTg0MTEtYWRkYjlkNzQxZjdm).

### Acknowledgements
We express our uttermost sincere gratitude to those who made this project thrive. We would like to thank, in particular, Leonardo Pedroso for his invaluable contribution to the design of the autopilot, and João Canas for all his words of encouragement, advice, and support.

![Logos](https://i.imgur.com/HNF4COq.png)


