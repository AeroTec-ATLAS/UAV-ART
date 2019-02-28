#ifndef GPIO_HPP
#define GPIO_HPP

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

class GPIO {
 public:
  GPIO() { num = 0; }
  GPIO(uint8_t newNum) { num = newNum; }

  uint8_t getNum() { return num; }

  bool exportGPIO() {
    FILE* exportF;

    exportF = fopen("/sys/class/gpio/export", "w");

    if (exportF == NULL)
      return false;

    fprintf(exportF, "%d", num);

    fclose(exportF);

    return true;
  }

  bool unexportGPIO() {
    FILE* unexportF;

    unexportF = fopen("/sys/class/gpio/unexport", "w");

    if (unexportF == NULL)
      return false;

    fprintf(unexportF, "%d", num);

    fclose(unexportF);

    return true;
  }

  bool setDir(bool isInput) {
    FILE* setDirF;
    char setDirF_path[33];

    sprintf(setDirF_path, "/sys/class/gpio/gpio%d/direction", num);

    setDirF = fopen(setDirF_path, "w");

    if (setDirF == NULL)
      return false;

    fprintf(setDirF, isInput ? "in" : "out");

    fclose(setDirF);

    return true;
  }

  bool setVal(bool isHigh) {
    FILE* setValF;
    char setValF_path[29];

    sprintf(setValF_path, "/sys/class/gpio/gpio%d/value", num);

    setValF = fopen(setValF_path, "w");

    if (setValF == NULL)
      return false;

    fprintf(setValF, isHigh ? "1" : "0");

    fclose(setValF);

    return 0;
  }

  bool getVal(bool* val) {
    FILE* getValF;
    char preVal;
    char getValF_path[29];

    sprintf(getValF_path, "/sys/class/gpio/gpio%d/value", num);

    getValF = fopen(getValF_path, "r");

    if (getValF == NULL)
      return false;

    fgetc(getValF);

    *val = preVal == 49;  // "1" ASCII code

    fclose(getValF);

    return true;
  }

 private:
  uint8_t num;
};

#endif