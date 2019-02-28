#include "GPIO.hpp"

int main(void) {
  GPIO receiver(21);
  bool val;

  if (!receiver.exportGPIO())
    return 1;

  receiver.setDir("in");

  receiver.getVal(&val);

  printf("%d\n", val);

  receiver.unexportGPIO();

  return 1;
}