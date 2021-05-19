/* Colocar os includes todos*/
#include pidControl.h
#include messages.h
#include parameters.h


int main(){
    /*inicialize parameters*/
    parameters AP;
    initialization_parameters(AP);

    /*inicialize autopilot*/
    autopilot_struct ctrl;
    ctrl = autopilotInit(AP,ts_control);

    /*creat messages*/
    msgAutopilot commands;
    msgDelta deltas;
    msgStates state;
    msgPath path;

    /*creat flags*/
    bool failsafeSwitch = 0;

    /*autopilot loop*/
    do{
    while(failsafeSwitch == 1)
    {

    /*retirar dados dos sensores*/
    /*-------------------------------------------*/
    /*state = /*função dos sensores*/
    /*-------------------------------------------*/

    /*retirar os comandos para o pathfollower*/
    /*-------------------------------------------*/
    /*path = /*pathmanager()*/
    /*-------------------------------------------*/

    /*retirar os comandos para o autopilot*/
    /*-------------------------------------------*/
    /*commands = pathfollower(/*dados para o pathfollower)*/
    /*-------------------------------------------*/

    /*correr o autopilot*/
    /*-------------------------------------------*/
    deltas = autopilot(ctrl, AP, state, commands, ts_control);
    /*-------------------------------------------*/

    /*enviar os dados para as superfícies de controlo*/
    /*-------------------------------------------*/
    /*controlSurfaces(deltas)*/
    /*-------------------------------------------*/

    }
    }while (1);

    return 0
}