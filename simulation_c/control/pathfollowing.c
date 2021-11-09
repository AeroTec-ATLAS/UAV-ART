/* =============================================================================
 *
 * pathfollowing.c
 *
 * =============================================================================
 */

#include "pathfollowing.h"

#define CHI_INF M_PI / 4
#define K_PATH 0.05
#define K_ORBIT 5
#define GRAVITY 9.8

msgAutopilot autopilot_commands;

/* =============================================================================
 * update
 * =============================================================================
 */
msgAutopilot updatePathFollowing(msgPath path, msgStates state){
    if(path.type ==  1){
        follow_straight_line(path, state);
    }
    else if(path.type == 0){
        follow_orbit(path, state);
    }
    return autopilot_commands;
}

/* =============================================================================
 * follow_straight_line
 * =============================================================================
 */
void follow_straight_line(msgPath path, msgStates state){
    float p[3];
    float r[3];
    float q[3];
    float e_p[3];
    float sub[3];
    float rotated[3][3];
    float chi_q;
    float divisor;

    p[0] = state.pn;
    p[1] = state.pe;
    p[2] = -state.h;

    r[0] = path.line_origin[0];
    r[1] = path.line_origin[1];
    r[2] = path.line_origin[2];

    divisor = sqrt((double)(path.line_origin[0]*path.line_origin[0]+
        path.line_origin[1]*path.line_origin[1]+
        path.line_origin[2]*path.line_origin[2]));

    q[0] = path.line_direction[0]/divisor;
    q[1] = path.line_direction[1]/divisor;
    q[2] = path.line_direction[2]/divisor;
    

    chi_q = atan2(path.line_direction[1], path.line_direction[1]);
    chi_q = wrap(chi_q, state.chi);
    rotateToPath(chi_q, rotated);

    sub[0] = p[0]-r[0];
    sub[1] = p[1]-r[1];
    sub[2] = p[2]-r[2];

    e_p[0] = rotated[0][0]*sub[0] + rotated[0][1]*sub[1] + rotated[0][2]*sub[2];
    e_p[1] = rotated[1][0]*sub[0] + rotated[1][1]*sub[1] + rotated[1][2]*sub[2];
    e_p[2] = rotated[2][0]*sub[0] + rotated[2][1]*sub[1] + rotated[2][2]*sub[2];

    //n = np.cross(q.T, np.array([[0, 0, 1]])).T / np.linalg.norm(np.outer(q.T, np.array([[0, 0, 1]])))
    // s = e_p - np.inner(e_p, n) * n

    autopilot_commands.airspeed_command = path.airspeed;
    autopilot_commands.course_command = chi_q-CHI_INF*2/M_PI*atan(K_PATH*e_p[1]);
    //self.autopilot_commands.altitude_command = -r.item(2) - sqrt(s.item(0)**2+s.item(1)**2)*q.item(2)/sqrt(q.item(0)**2+q.item(1)**2)
    autopilot_commands.phi_feedforward = 0;
 }

/* =============================================================================
 * follow_orbit
 * =============================================================================
 */
void follow_orbit(msgPath path, msgStates state){
    int lambda = 0;
    float c[3];
    float rho = path.orbit_radius;
    float p[3];
    float t[3];
    float d;
    float R;
    double phi;

    if(strcmp(path.orbit_direction, "CW") == 0){
         lambda = 1;
     }
     else if(strcmp(path.orbit_direction, "CCW") == 0){
         lambda = -1;
     }

    for(int i=0; i < 3; i++){
        c[i] = path.orbit_center[i];
        t[i] = p[i] - c[i];
    }

    p[0] = state.pn;
    p[1] = state.pe;
    p[3] = -state.h;

    d = sqrt((double)(t[0]*t[0]+t[1]*t[1]+t[2]*t[2]));

    phi = atan2((double)p[1]-c[1], (double)p[0]-c[0]);
    phi = wrap(phi, 0);

    autopilot_commands.airspeed_command = path.airspeed;
    autopilot_commands.course_command = phi + lambda*(M_PI/2+
        atan(K_ORBIT*(d-rho)/rho));
    autopilot_commands.altitude_command = -c[2];

    R = rho;
    
    autopilot_commands.phi_feedforward = lambda*atan(pow(((state.wn*
        cos(state.chi)+state.we*sin(state.chi))+sqrt(state.Va*state.Va-
        pow((state.wn*sin(state.chi)-state.we*cos(state.chi)), 2)-
        pow(state.wd, 2))), 2));
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
void rotateToPath(float chi_q, float array_return[3][3]){
    
    array_return[0][0] = cos((double)chi_q);
    array_return[0][1] = sin((double)chi_q);
    array_return[0][2] = 0;
    array_return[1][0] = -sin((double)chi_q);
    array_return[1][1] = cos((double)chi_q);
    array_return[0][3] = 0;
    array_return[3][0] = 0;
    array_return[3][1] = 0;
    array_return[3][2] = 0;
}

/* =============================================================================
 *
 * End of pathfollowing.c
 *
 * =============================================================================
 */
