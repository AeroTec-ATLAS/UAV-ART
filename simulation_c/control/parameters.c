#include "messages.h" 
#include "pidControl"

void initialization_parameters(parameters *AP){

	AP->sigma = 0.5; //  =  0.5 // low pass filter gain for derivative

	//----------roll loop-------------
	AP->roll_kp = 1;
	AP->roll_ki = 0.4000;
	AP->roll_kd = 0.1209;

	//----------course loop-------------
	AP->course_kp = 5.8067;
	AP->course_ki = 0.7285;

	//----------pitch loop-------------

	AP->pitch_kp = -3;
	AP->pitch_kd = -1.1622;
	AP->theta_c_climb = 0.5236;
	AP->delta_e_max = 0.5236;
    
	//----------altitude--------------

	AP->altitude_state = 0;
	AP->altitude_kp = 0.0190;
	AP->altitude_ki = 6.3312e-04;
	AP->altitude_hold_zone = 25;  // moving saturation limit around current altitude
	AP->altitude_take_off_zone = 40;

	//---------airspeed hold using throttle---------------
	AP->airspeed_throttle_kp = 0.0049;
	AP->airspeed_throttle_ki = 0.0013;

	//---------airspeed hold using pitch---------------
	AP->airspeed_pitch_kp = -0.1355;
	AP->airspeed_pitch_ki = -0.0270;

	//----------sideslip-------------
	AP->sideslip_kp = 3;
	AP->sideslip_ki = 2.5378;

	//----------throttle-------------
	AP->throttle_trim = 0.6031;

	//--------surface_limits------------
	AP->delta_a_max = 0.3491;
	AP->delta_r_max = 0.7854;
}