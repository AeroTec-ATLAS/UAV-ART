#ifndef FAIL_SAFE_SWITCH_HPP
#define FAIL_SAFE_SWITCH_HPP

#include <stdint.h>
#include <stdio.h>
#include "GPIO.hpp"

#define RECEIVER_GPIO 1
#define NOISE_LIMIT 3

#define PPM_LH_BARRIER 1500

class FailSafeSwitch {
 public:
  FailSafeSwitch() {
    isPilotCommanding = false;  // TO DO como deve ser inicializado
    numEqualSignals = 0;

    receiverGPIO = GPIO(RECEIVER_GPIO);
  }

  void processAndFilter(uint16_t period) {
    // Returns true if the command must change and false otherwise

    bool newCommand;

    newCommand = period >= PPM_LH_BARRIER;

    if (newCommand != isPilotCommanding)
      numEqualSignals++;
    else
      numEqualSignals = 0;

    if (numEqualSignals == NOISE_LIMIT) {
      isPilotCommanding = newCommand;
      numEqualSignals = 0;

      printf("Changed!");
    }
  }

 private:
  uint8_t numEqualSignals;
  bool isPilotCommanding;

  GPIO receiverGPIO;
};

#endif