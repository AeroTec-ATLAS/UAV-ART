/* =============================================================================
 *
 * pidControl.h
 *
 * =============================================================================
 */

#ifndef PID_CONTROL_H
#define PID_CONTROL_H

#include <stdio.h>
#include <stdbool.h>
#include <math.h>

typedef struct {
	float kp;
	float ki;
	float kd;
	float Ts;
	float high_limit;
	float low_limit;
	float integrator;
	float error_delay_1;
	float error_dot_delay_1;
	float y_dot;
	float y_delay_1;
	float y_dot_delay_1;
	float a1;
	float a2;
	
} pidControl;

typedef struct {
	//gravity = MAV.gravity  # gravity constant			Investigar o MAVLINK para gravity e rho
	//rho = MAV.rho  # density of air
	float sigma; //  =  0.5 // low pass filter gain for derivative

	//----------roll loop-------------
	float roll_kp; // = 1
	float roll_ki; // = 0.4000
	float roll_kd; // = 0.1209

	//----------course loop-------------
	float course_kp; // = 5.8067
	float course_ki; // = 0.7285

	//----------pitch loop-------------

	float pitch_kp; // = -3
	float pitch_kd; // = -1.1622
	float theta_c_climb; // = 0.5236
	float delta_e_max; // = 0.5236

	//----------altitude--------------

	float altitude_state; // = 0
	float altitude_kp; // = 0.0190
	float altitude_ki; // = 6.3312e-04
	float altitude_hold_zone; // = 25  / moving saturation limit around current altitude
	float altitude_take_off_zone; // = 40

	//---------airspeed hold using throttle---------------
	float airspeed_throttle_kp; // = 0.0049
	float airspeed_throttle_ki; // = 0.0013

	//---------airspeed hold using pitch---------------
	float airspeed_pitch_kp; // = -0.1355
	float airspeed_pitch_ki; // = -0.0270

	//----------sideslip-------------
	float sideslip_kp; // 3
	float sideslip_ki; // 2.5378

	//----------throttle-------------
	float throttle_trim; // = 0.6031

	//--------surface_limits------------
	float delta_a_max; // = 0.3491
	float delta_r_max; // = 0.7854
} parameters


/* =============================================================================
 * saturate
 * =============================================================================
 */

float saturate(pidControl* pc, int u);

#endif

/* =============================================================================
 *
 * End of pidControl.h
 *
 * =============================================================================
 */