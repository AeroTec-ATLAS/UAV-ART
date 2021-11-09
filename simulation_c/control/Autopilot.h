/* =============================================================================
 *
 * Autopilot.h
 *
 * =============================================================================
 */

#include "messages.h"
#include "pidControl.h"

typedef struct{

    msgStates states;
    msgDelta delta;

} AutoPilotReturn;

typedef struct{

    pidControl* aileron_from_roll;
    pidControl* roll_from_course;
    pidControl* elevator_from_pitch;
    pidControl* throttle_from_airspeed;
    pidControl* pitch_from_airspeed;
    pidControl* pitch_from_altitude;
    msgStates command_state;

} AutoPilotInfo;


void initialization_parameters(parameters *AP, AutoPilotInfo *autoPilot);

AutoPilotReturn* autopilot(parameters *AP, msgAutopilot *cmd , msgStates *state, AutoPilotInfo *autoPilot);
/* =============================================================================
 *
 * End of Autopilot.h
 *
 * =============================================================================
 */
