#include "FSS.hpp"

FailSafeSwitch switch1;

void startOfTrans() {
  switch1.startOfTrans();
}

void handleCommand() {
  switch1.handleCommand();
}

int main(void) {
  wiringPiISR(RECEIVER_PIN, INT_EDGE_RISING, startOfTrans);
  wiringPiISR(RECEIVER_PIN, INT_EDGE_FALLING, handleCommand);

  while (1) {
  }

  return 1;
}
