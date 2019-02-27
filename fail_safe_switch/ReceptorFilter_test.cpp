// Compile using g++ ReceptorFilter_test.cpp -o ReceptorFilter_test

#include "ReceptorFilter.hpp"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void printChange() {
  printf("Change\n");
}

int main(void) {
  uint8_t newSignal;
  ReceptorFilter filter(3);

  while (1) {
    srand(time(NULL));

    newSignal = rand() % 2;

    printf("%d\n", newSignal);

    filter.receiveAndExecute(newSignal, printChange);

    for (uint64_t i = 0; i < 200000000; i++) {
    }
  }

  return 1;
}