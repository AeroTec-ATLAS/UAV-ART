#include <stdio.h>
#include <stdbool.h>
#include <math.h>

typedef struct {

    float airspeed_command     // comanded airspeed m/s
    float course_command       // commanded course angle in rad
    float altitude_command     // commanded altitude in m
    float phi_feedforward      // feedforward command for roll angle

} msgAutopilot;

typedef struct {

    float aileron;             //aileron command
    float elevator;            //elevator command
    float rudder;              //rudder command
    float throttle;            //throttle command

} msgDelta;



typedef struct {

    float pn;      //# inertial north position in meters
    float pe;      //# inertial east position in meters
    float h;       //# inertial altitude in meters
    float phi;     //# roll angle in radians
    float theta;   //# pitch angle in radians
    float psi;     //# yaw angle in radians
    float Va;      //# airspeed in meters/sec
    float alpha;   //# angle of attack in radians
    float beta;    //# sideslip angle in radians
    float p;       //# roll rate in radians/sec
    float q;       //# pitch rate in radians/sec
    float r;       //# yaw rate in radians/sec
    float Vg;      //# groundspeed in meters/sec
    float gamma;   //# flight path angle in radians
    float chi;     //# course angle in radians
    float wn;      //# inertial windspeed in north direction in meters/sec
    float we;      //# inertial windspeed in east direction in meters/sec
    float wd;      //# inertial windspeed in down direction in meters/sec
    float bx;      //# gyro bias along roll axis in radians/sec
    float by;      //# gyro bias along pitch axis in radians/sec
    float bz;      //# gyro bias along yaw axis in radians/sec

} msgStates;

/*
msg_path
    - messages type for input to path follower
*/
typedef struct
{
    int type;
    float airspeed;
    float line_origin[3][1];
    float line_direction[3][1];
    float orbit_center[3][1];
    float orbit_radius;
    bool orbit_direction; // CW = 0 | CCW = 1
    bool flag_path_changed;


} msgPath;


class msgPath:
    def __init__(self):
       // type='line' means straight line following, type='orbit' means orbit following
        self.type = 'line'
        //self.type = 'orbit'
        // desired airspeed along the path
        self.airspeed = 25
        // origin of the straight path line (r)
        self.line_origin = np.array([[0.0, 0.0, 0.0]]).T
        // direction of line -unit vector- (q)
        self.line_direction = np.array([[1.0, 0.0, 0.0]]).T
        // center of the orbit (c)
        self.orbit_center = np.array([[0.0, 0.0, 0.0]]).T
        // radius of the orbit (rho)
        self.orbit_radius = 50
        // orbit direction: 'CW'==clockwise, 'CCW'==counter clockwise
        self.orbit_direction = 'CW'
        // flag that indicates that a path has changed.  Used to signal a redraw in viewer
        self.flag_path_changed = True

    def signToDirection(self, sign):
        if sign == np.sign(1):
            self.orbit_direction='CW'
        elif sign == np.sign(-1):
             self.orbit_direction = 'CCW'
