#include <stdio.h>
#include "pidControl.h"
#include "messages.h"

msgAutopilot updatePathFollowing(msgPath path, msgStates state);

void follow_straight_line(msgPath path, msgStates state);

void follow_orbit(msgPath path, msgStates state);

float wrap(float chi_c, float chi);

void rotateToPath(float chi_q, float array_return[3][3]);