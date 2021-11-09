/* Colocar os includes todos*/
#include "pidControl.h"
#include "messages.h"
#include "parameters.h"
#include "Autopilot.h"
#include "pathfollowing.h"
#include <time.h>
#include <unistd.h>
#include <math.h>

bool video;

int main(){
    /*inicialize parameters*/
    /*inicialize autopilot*/
    parameters AP;
    AutoPilotInfo ctrl;
    AutoPilotReturn* autopReturn;
    msgDelta deltas;
    msgStates state;
    initialization_parameters(&AP, &ctrl);
    /*creat messages*/
    msgAutopilot commands;
    msgPath path;

    path.type = 'line';
    path.airspeed = 35;

    if (path.type == 'line'){
        path.line_origin[0] = 0.0;
        path.line_origin[1] = 0.0;
        path.line_origin[2] = -100.0;
        double a = path.line_direction[0]*path.line_direction[0];
        double b = path.line_direction[1]*path.line_direction[1];
        double c = path.line_direction[2]*path.line_direction[2];
        float norm = (float)sqrt(a+b+c);

        for(int i = 0; i < 3; i++)
            path.line_direction[i] /= norm;
        
    }else{
        /* Center of the orbit */
        path.orbit_center[0] = 0;
        path.orbit_center[1] = 0;
        path.orbit_center[2] = -100;
        /* Radius of the orbit */
        path.orbit_radius = 500; 
        /* orbit direction: 'CW'==clockwise, 'CCW'==counter clockwise */
        path.orbit_direction = "CW"; 
    }
    /*autopilot loop*/
    int sim_time = START_TIME;

    while(sim_time < END_TIME){ 
        commands = updatePathFollowing(path, state);
        autopReturn = autopilot(&AP, &commands, &state, &ctrl);
        sim_time += TS_SIMULATION;
    }
    return 0;
}