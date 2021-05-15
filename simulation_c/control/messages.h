#include <stdio.h>
#include <stdbool.h>
#include <math.h>

typedef struct {

    float airspeed_command     // commanded airspeed m/s
    float course_command       // commanded course angle in rad
    float altitude_command     // commanded altitude in m
    float phi_feedforward      // feedforward command for roll angle

    float elevator;            //elevator command
    float aileron;             //aileron command
    float rudder;              //rudder command
    float throttle;            //throttle command

} cmd_states;


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

} states;