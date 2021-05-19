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