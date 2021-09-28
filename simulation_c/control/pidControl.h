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

/* =============================================================================
 * initialization
 * =============================================================================
 */
pidControl* initialization(float kp, float ki, float kd, float Ts, 			
					float sigma, float low_limit, float high_limit);

/* =============================================================================
 * update
 * =============================================================================
 */
float update(pidControl* pc, float y_ref, float y, bool reset_flag);

/* =============================================================================
 * update
 * =============================================================================
 */
float update_with_rate(pidControl* pc, float y_ref, float y, float ydot, bool reset_flag);

#endif

/* =============================================================================
 *
 * End of pidControl.h
 *
 * =============================================================================
 */