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
    hasStarted = false;

    isPilotCommanding = true;  // TO DO como deve ser inicializado
    numEqualSignals = 0;

    wiringPiSetup();

    pinMode(RECEIVER_PIN, INPUT);
    pinMode(TRI_STATE_PIN, OUTPUT);
  }

  void receiveAndSwitch() {
    updateSignalStates();

    if (currState) {
      if (lastState == 0)
        // If it receives a HIGH and received a LOW, a positive transition
        // occurred and time is registered
        gettimeofday(&lastTransition, NULL);
    } else if (lastState == 1) {
      // If it receives a LOW and received a HIGH, a negative transition
      // occurred
      bool newCommand = getCommand();

      // If the new signal imposes a change
      if (newCommand != isPilotCommanding)
        numEqualSignals++;
      else
        numEqualSignals = 0;

      // If the new signal is confirmed via repetition of signals
      if (numEqualSignals == NOISE_LIMIT) {
        isPilotCommanding = newCommand;
        numEqualSignals = 0;

        digitalWrite(TRI_STATE_PIN, newCommand);
      }
    }
  }

 private:
  bool hasStarted;

  bool lastState;
  bool currState;

  TRANSITION_TIME lastTransition;

  uint8_t numEqualSignals;
  bool isPilotCommanding;

  void updateSignalStates() {
    if (!hasStarted) {
      lastState = digitalRead(RECEIVER_PIN);
      currState = digitalRead(RECEIVER_PIN);
    } else {
      lastState = currState;
      currState = digitalRead(RECEIVER_PIN);
    }
  }

  bool getCommand() {
    TRANSITION_TIME curr;
    uint32_t period;
    bool newCommand;

    gettimeofday(&curr, NULL);

    period = (curr.tv_sec - lastTransition.tv_sec) * 10e6 + curr.tv_usec -
             lastTransition.tv_usec;
    newCommand = period >= PPM_LH_BARRIER;
  }
};

#endif