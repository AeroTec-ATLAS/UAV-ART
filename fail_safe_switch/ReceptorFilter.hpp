#ifndef RECEPTOR_FILTER_HPP
#define RECEPTOR_FILTER_HPP

#include <stdint.h>

#define NOISE_SENS 4

class ReceptorFilter {
 public:
  Recetor(void (*newAction)(void)) {
    lastSignal = false;
    lastSequence = false;
    numEqualSignals = 0;

    action = newAction;
  }

  void setAction(void (*newAction)(void)) { action = newAction; }

  // If a sequence of 1's superior to the noise limit is detected, executes the
  // action
  void executeOnConfirmation(bool newSignal) {
    if ((newSignal == lastSignal || numEqualSignals == 0) &&
        newSignal != lastSequence)
      numEqualSignals++;
    else
      numEqualSignals = 0;

    if (numEqualSignals == NOISE_SENS) {
      lastSequence = newSignal;
      numEqualSignals = 0;

      if (newSignal)
        action();
    }

    lastSignal = newSignal;
  }

 private:
  uint8_t numEqualSignals;
  bool lastSignal;
  bool lastSequence;  // Last really trustable value (last sequence of
                      // NOISE_SENS equal signals)

  void (*action)(void);
};

#endif