/* =============================================================================
 *
 * pidControl.c
 *
 * =============================================================================
 */

/*
Controlador PID - Define um controlador multifacetado que funciona para cada um dos parâmetros do aeromodelo.
	INIT_Input: kp, ki, kd da variável a controlar; sim_time; sigma; limites de satuação;
	UPDATE_Input: prev_u (assegurar continuidade no delta_t); y_ref (valor de referência); y (valor atual); reset_flag;
	UPDATE_WITH_RATE_Input: y_ref; y; ydot (primeira derivada da variável de controlo); reset_flag;
	Output: u_sat (variável que representa o valor do próximo estado no controlo - já com saturações)
"""
*/

#include "pidControl.h"


/* =============================================================================
 * initialization
 * =============================================================================
 */

pidControl* initialization(float kp, float ki, float kd, float Ts, 			
					float sigma, float low_limit, float high_limit){

	pidControl* pc; 			/*VER SE É APONTADOR OU NÃO*/

	pc->kp = kp;
	pc->ki = ki;
	pc->kd = kd;
	pc->Ts = Ts;
	pc->high_limit = high_limit;
	pc->low_limit = low_limit;
	pc->integrator = 0.0;
	pc->error_delay_1 = 0.0;
	pc->error_dot_delay_1 = 0.0;
	pc->y_dot = 0.0;
	pc->y_delay_1 = 0.0;
	pc->y_dot_delay_1 = 0.0;

	//gains for differentiator
	pc->a1 = (2.0 * sigma - Ts) / (2.0 * sigma + Ts);
	pc->a2 = 2.0 / (2.0 * sigma + Ts);

	return pc;			//VER SE É APONTADOR OU NÃO
}


/* =============================================================================
 * update
 * =============================================================================
 */

float update(pidControl* pc, float y_ref, float y, bool reset_flag){

	float error;
	float error_dot;
	float u;
	float u_sat;

	if(reset_flag){
		pc->integrator = 0.0;
		pc->error_delay_1 = 0.0;
		pc->y_dot = 0.0;
		pc->y_delay_1 = 0.0;
		pc->y_dot_delay_1 = 0.0;
	}

	//compute the error
	error = y_ref - y;

	//update the integrator using trapazoidal rule
	pc->integrator = pc->integrator + (pc->Ts/2) * (error + pc->error_delay_1);

	//update the differentiator
	error_dot = pc->a1 * pc->error_dot_delay_1 + pc->a2 * (error - pc->error_delay_1);

	//PID control
	u = pc->kp * error + pc->ki * pc->integrator + pc->kd * error_dot;

	//saturate PID control at limit
	u_sat = saturate(pc, u);
	
	//integral anti-windup
    //adjust integrator to keep u out of saturation
	if(fabs(pc->ki) > 0.0001){
		pc->integrator = pc->integrator + (pc->Ts / pc->ki) * (u_sat - u);
	}

	//update the delayed variables
	pc->error_delay_1 = error;
	pc->error_dot_delay_1 = error_dot;

	return u_sat;
}

/* =============================================================================
 * update_with_rate
 * =============================================================================
 */

float update_with_rate(pidControl* pc, float y_ref, float y, float ydot, bool reset_flag){

	float error;
	float u;
	float u_sat;

	if(reset_flag){
		pc->integrator = 0.0;
		pc->error_delay_1 = 0.0;
	}

	//compute the error
	error = y_ref - y;

	//update the integrator using trapazoidal rule
	pc->integrator = pc->integrator + (pc->Ts/2) * (error + pc->error_delay_1);

	//PID control
	u = pc->kp * error + pc->ki * pc->integrator - pc->kd * ydot;

	//saturate PID control at limit
	u_sat = saturate(pc, u);

    //integral anti-windup
    //adjust integrator to keep u out of saturation
	if(fabs(pc->ki) > 0.0001){
		pc->integrator = pc->integrator + (pc->Ts / pc->ki) * (u_sat - u);
	}		            

	pc->error_delay_1 = error;
	
	return u_sat;
}

/* =============================================================================
 * saturate
 * =============================================================================
 */

float saturate(pidControl* pc, int u){

	float u_sat;

	//saturate u at +- pc->limit
	if(u >= pc->high_limit){
		u_sat = pc->high_limit;
	}
	else if (u <= pc->low_limit){
		u_sat = pc->low_limit;
	}
	else{
		u_sat = u;
	}

	return u_sat;
}

/* =============================================================================
 *
 * End of pidControl.c
 *
 * =============================================================================
 */