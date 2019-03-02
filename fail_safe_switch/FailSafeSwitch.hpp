#ifndef FAIL_SAFE_SWITCH_HPP
#define FAIL_SAFE_SWITCH_HPP

#include <stdint.h>
#include <stdio.h>
#include <sys/time.h>  // Add -lrt to compilation command
#include <wiringPi.h>  // Add -lwiringPi to compilation command

#define RECEIVER_PIN 22
#define TRI_STATE_PIN 29

#define NOISE_LIMIT 15
#define PPM_LH_BARRIER 1500

typedef struct timeval TRANSITION_TIME;

class FailSafeSwitch {
 public:
  FailSafeSwitch() {
    isPilotCommanding = true;  // No início do voo, o comando será do piloto
    numEqualSignals = 0;

    lastTransition = TRANSITION_TIME{0, 0};

    wiringPiSetup();

    pinMode(RECEIVER_PIN, INPUT);
    pinMode(TRI_STATE_PIN, OUTPUT);
  }

  void startOfTransmission() { gettimeofday(&lastTransition, NULL); }

  void handleCommand() {
    TRANSITION_TIME curr;

    gettimeofday(&curr, NULL);

    // The new command is interpreted as being or not above a specified period
    // of transmission
    bool newCommand = (curr.tv_sec - lastTransition.tv_sec) * 10e6 +
                          curr.tv_usec - lastTransition.tv_usec >=
                      PPM_LH_BARRIER;

    // If the new command imposes a change
    if (newCommand != isPilotCommanding)
      numEqualSignals++;
    else
      numEqualSignals = 0;

    // If the new command is confirmed via repetition of signals
    if (numEqualSignals == NOISE_LIMIT) {
      // Executes command
      digitalWrite(TRI_STATE_PIN, newCommand);

      // Resets auxilary variables
      isPilotCommanding = newCommand;
      numEqualSignals = 0;
    }
  }

 private:
  TRANSITION_TIME lastTransition;

  uint8_t numEqualSignals;
  bool isPilotCommanding;
};

#endif