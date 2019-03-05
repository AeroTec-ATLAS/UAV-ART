#include "FailSafeSwitch.hpp"

FailSafeSwitch switch1;

void startofTrans(void) {
  switch1.startOfTrans();
}

void handleCommand(void) {
  switch1.handleCommand();
}

int main(void) {
  wiringPiISR(RECEIVER_PIN, INT_EDGE_RISING, startofTrans);
  wiringPiISR(RECEIVER_PIN, INT_EDGE_FALLING, handleCommand);

  while (1) {
  }

  return 1;
}