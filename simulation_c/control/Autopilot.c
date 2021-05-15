"""
autopilot - Controlar automaticamente a dinâmica e atitude do aeromodelo.
	Inputs: msgAutopilot; delta_throttle; mavDynamics.true_state; SIM.start_time
	Outputs: msgState; msgDelta
"""

#include "pidControl.h"
#include "messages.h"

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

// Fazer estrutura com todos os controladores
    pidControl aileron_from_roll, roll_from_course, elevator_from_pitch, throttle_from_airspeed, pitch_from_airspeed, pitch_from_altitude;

    aileron_from_roll = initialization(AP->roll_kp, AP->roll_ki, AP->roll_kd, ts_control, 0.05, -AP->delta_a_max, AP->delta_a_max)
    roll_from_course = initialization(AP->course_kp, AP->course_ki, 0, ts_control, 0.05, -M_PI / 7.2, M_PI / 7.2)
    elevator_from_pitch = initialization(AP->pitch_kp, 0, AP->pitch_kd, ts_control, 0.05, -AP->delta_e_max, AP->delta_e_max)
    throttle_from_airspeed = initialization(AP->airspeed_throttle_kp, AP->airspeed_throttle_ki, 0, ts_control, 0.05, 0, 1)
    pitch_from_airspeed = initialization(AP->airspeed_pitch_kp, AP->airspeed_pitch_ki, 0, ts_control, sigma=0.05, M_PI / 6, M_PI/ 6)
    pitch_from_altitude = initialization(AP->altitude_kp, AP->altitude_ki, 0, ts_control, 0.05, -M_PI / 6, M_PI / 6)



    // inicialize message
    //self.commanded_state = msgState()
    //self.delta = msgDelta()

cmd_states autopilot(parameters *AP, states *state, cmd_states *cmd, ts_control)        //juntar o delta e o commanded_state numa só 
{
    //float pn = state.pn;  		// inertial North position
    //float pe = state.pe;  		// inertial East position
    float h = state->h; 			// altitude
    float Va = state->Va;  		// airspeed
    //float alpha = state.alpha; 	// angle of attack
    //float beta = state.beta;  	// side slip angle
    float phi = state->phi;  		// roll angle
    float theta = state->theta;  	// pitch angle
    float chi = state->chi;  		// course angle
    float p = state->p; 			// body frame roll rate
    float q = state->q; 			// body frame pitch rate
    //float r = state->r; 		    // body frame yaw rate
    //float Vg = state->Vg; 		// ground speed
    //float wn = state->wn; 		// wind North
    //float we = state->we; 		// wind East
    //float psi = state->psi; 		// heading
    //float bx = state->bx; 		// x-gyro bias
    //float by = state->by; 		// y-gyro bias
    //float bz = state->bz; 		// z-gyro bias

    float Va_c = cmd->airspeed_command;  		// commanded airspeed (m/s)
    float h_c = cmd->altitude_command;  		// commanded altitude (m)
    float chi_c = cmd->course_command; 		    // commanded course (rad)

    bool reset_flag;

    if (ts_control == 0)
        reset_flag = true;
    else
        reset_flag = false;

    // lateral autopilot

        float phi_c = update(roll_from_course, chi_c, chi, reset_flag) + cmd->phi_feedforward;
        //float phi_c = np.clip(phi_c, self.roll_from_course.low_limit, self.roll_from_course.high_limit) VER FUNÇÃO EQUIVALENTE
        float delta_a = update_with_rate(aileron_from_roll, phi_c, phi, p, reset_flag);
        float delta_r = 0;

    // longitudinal autopilot
        // saturate the altitude command
        // state machine

    int altitude_state = 1;

    // takeoff zone
    if (h <= AP->altitude_take_off_zone){
        if (altitude_state != 1)
            reset_flag = 1; 
        altitude_state = 1;
    }
    // climb zone
    else if (h <= h_c-AP->altitude_hold_zone){
        if (altitude_state != 2)
            reset_flag = 1; 
        altitude_state = 2;
    }
    // descent zone
    else if (h >= h_c+AP->altitude_hold_zone){
        if (altitude_state != 3)
            reset_flag = 1; 
        altitude_state = 3;
    }
    // hold zone
    else {
        if (altitude_state != 4)
            reset_flag = 1; 
        altitude_state = 4;
    }
    
    
    // implement state machine
    switch (altitude_state)
    {
        case 1:  // in take-off zone 
            float delta_t = 1;         //throttle_take_off
            float theta_c = (AP->theta_c_climb) * (1 - exp(-ts_control));
    
            break;
            
        case 2:  // climb zone
            float delta_t = 1          //throttle_take_off
            float theta_c = update(pitch_from_airspeed, Va_c, Va, reset_flag);

            break;
           
        case 3: // descend zone
            float delta_t = 0
            float theta_c = update(pitch_from_airspeed, Va_c, Va, reset_flag);

            break;
            
        case 4: // altitude hold zone
            float delta_t = AP->throttle_trim + update(throttle_from_airspeed, Va_c, Va, reset_flag)
            float theta_c = update(pitch_from_altitude, h_c, h, reset_flag)
            
            break;
    }

        float delta_e = update_with_rate(elevator_from_pitch,theta_c, theta, q, reset_flag)

        // construct output and commanded states
        c_states->delta_a = delta_a;
        c_states->delta_e = delta_e;
        c_states->delta_r = delta_r;
        c_states->delta_t = delta_t;

        c_states->h = cmd->altitude_command;
        c_states->Va = cmd->airspeed_command;
        c_states->phi = phi_c;
        c_states->theta = theta_c;
        c_states->chi = cmd->course_command;
        
    return c_states;
}