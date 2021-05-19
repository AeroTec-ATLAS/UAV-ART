/* =============================================================================
 *
 * pathfollowing.c
 *
 * =============================================================================
 */


#include "pidControl.h"
#include "messages.h"

#define CHI_INF = M_PI / 4
#define K_PATH = 0.05
#define K_ORBIT = 5
#define GRAVITY = 9.8

msgAutopilot autopilot_commands;

/* =============================================================================
 * pathfollower
 * =============================================================================
 */

msgAutopilot pathfollower(msgPath path, msgStates state){
    if(path.type ==  1){

    }
}

/* =============================================================================
 * pathfollower
 * =============================================================================
 */

 void follow_orbit(msgPath path, msgStates state){
    int lambda = 0;
    float[3][1] c = path.orbit_center;
    float[3][1] rho = path.orbit_radius;
    float[3][1] p;
    float[3][1] d;
    double phi;

    p[0][0] = state.pn;
    p[1][0] = state.pe;
    p[3][0] = state.h;
    d[0][0] = 
    d[0][0] = 
    d[0][0] = 
    
     if(strcmp(path.orbit_direction, "CW") == 0){
         lambda = 1;
     }
     else if(strcmp(path.orbit_direction, "CW") == 0){
         lambda = -1;
     }
     
 }





/* =============================================================================
 * warp
 * =============================================================================
 */

float wrap(float chi_c, float chi){
    while (chi_c-chi > chi){
        chi_c = chi_c - 2.0 * M_PI;
    }
    while (chi_c-chi < -chi){
        chi_c = chi_c + 2.0 * M_PI;
    }
    return chi_c;
}

/* =============================================================================
 * rotateToPath
 * =============================================================================
 */

float rotateToPath(chi_q){
    float array_return[3][3];
    
    array_return[0][0] = cos((double)chi_q);
    array_return[0][1] = sin((double)chi_q);
    array_return[0][2] = 0;
    array_return[1][0] = -sin((double)chi_q);
    array_return[1][1] = cos((double)chi_q);
    array_return[0][3] = 0;
    array_return[3][0] = 0;
    array_return[3][1] = 0;
    array_return[3][2] = 0;

    return array_return;
}

/* =============================================================================
 *
 * End of pathfollowing.c
 *
 * =============================================================================
 */
