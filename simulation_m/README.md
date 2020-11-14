# simulation_m
You can select different Matlab simulations, but we recommend trying the three main ones, 
one where you can try the autopilot controller with an airspeed, heading and altitude command, 
one where the autopilot will follow a path provided, or  one where you can estimate the aerodynamic 
coefficients of a given model aircraft, using flight data.
## Autopilot
To run this simulation, run the main.m file located in the control/autopilot folder. An animation will 
run once the simulation is done.
## Estimation of Aerodynamic Coefficients
To run this simulation, first you need to run read_data.m file located in the control/estimation folder. 
Then you have to run get_coefs.m file located in the same folder. Additionally, in that folder, you can 
analyse two different .txt files with flight data.
## Path following
A system that enables the aircraft to follow straight lines and orbits.
It is written on top of the autopilot folder so you need to have both folders side-by-side.
To run this Matlab simulation, run the .m file located in the control/path_following folder. 
You can either follow a straight line path or an orbital path, and you can define the path 
to follow inside the .m file. An animation will run once the simulation is done.
