#ifndef FAIL_SAFE_SWITCH_HPP
#define FAIL_SAFE_SWITCH_HPP

#include <stdint.h>
#include <stdio.h>
#include <sys/time.h> // Add -lrt to compilation command
#include <wiringPi.h> // Add -lwiringPi to compilation command
#include "pins.hpp"

#define NOISE_LIMIT 15
#define PPM_LH_BARRIER 1500

typedef struct timeval TRANSITION;

class FailSafeSwitch
{
public:
  FailSafeSwitch()
  {
    isPilotCommanding = true; // In flight beginning, the pilot is in command
    numEqualSignals = 0;

    last = TRANSITION{0, 0};

    wiringPiSetup();

    pinMode(TRI_STATE_PIN, OUTPUT);

    digitalWrite(TRI_STATE_PIN, HIGH);
  }

  void startOfTrans()
  {
    gettimeofday(&last, NULL);
  }

  void handleCommand()
  {
    TRANSITION curr;
    TRANSITION diff;

    gettimeofday(&curr, NULL);

    timersub(&last, &curr, &diff); // Saves current time - last time in diff

    // The new command is interpreted as the signal reading being or not
    // above a specified period of transmission
    bool newCommand = diff.tv_sec * 10e6 + diff.tv_usec >= PPM_LH_BARRIER;

    // If the new command imposes a change
    if (newCommand != isPilotCommanding)
      numEqualSignals++;
    else
      numEqualSignals = 0;

    // If the new command is confirmed via repetition of signals
    if (numEqualSignals == NOISE_LIMIT)
    {
      // Executes command
      //digitalWrite(TRI_STATE_PIN, newCommand);
      printf("%d\n", newCommand);

      // Resets auxilary variables
      isPilotCommanding = newCommand;
      numEqualSignals = 0;
    }
  }

private:
  TRANSITION last;

  uint8_t numEqualSignals;
  bool isPilotCommanding;
};

#endif