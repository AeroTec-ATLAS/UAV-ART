#ifndef RECEPTOR_FILTER_HPP
#define RECEPTOR_FILTER_HPP

#include <stdint.h>

class ReceptorFilter {
 public:
  ReceptorFilter(int newNoiseLimit) {
    noiseLimit = newNoiseLimit;

    lastSequence = false;
    numEqualSignals = 0;
  }

  void receiveAndExecute(bool newSignal, void (*action)(void)) {
    // If a sequence of noiseLimit 1's is detected after one of 0's, registers
    // it and executes action. If a sequence of noiseLimit 0's is detected after
    // one of 1's, registers it

    if (newSignal == lastSequence)
      numEqualSignals = 0;
    else
      numEqualSignals++;

    if (numEqualSignals == noiseLimit) {
      lastSequence = newSignal;
      numEqualSignals = 0;

      if (newSignal)
        (*action)();
    }
  }

 private:
  uint8_t noiseLimit;

  uint8_t numEqualSignals;
  bool lastSequence;  // Last sequence's elements value
};

#endif