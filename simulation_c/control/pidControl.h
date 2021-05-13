/* =============================================================================
 *
 * pidControl.h
 *
 * =============================================================================
 */

#ifndef PID_CONTROL_H
#define PID_CONTROL_H

typedef struct {
	double kp;
	double ki;
	double kd;
	double Ts;
	double high_limit;
	double low_limit;
	double integrator;
	double error_delay_1;
	double error_dot_delay_1;
	double y_dot;
	double y_delay_1;
	double y_dot_delay_1;
	double a1;
	double a2;
	
} pidControl;


/* =============================================================================
 * saturate
 * =============================================================================
 */

double saturate(pidControl* pc, int u);

#endif

/* =============================================================================
 *
 * End of pidControl.h
 *
 * =============================================================================
 */