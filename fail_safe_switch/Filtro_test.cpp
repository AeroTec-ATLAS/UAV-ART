#include <stdio.h>
#include "Recetor.hpp"

void printChange() {
  printf("Change\n");
}

int main(void) {
  Recetor recetor(printChange);

  recetor.executeOnConfirmation(true);
  recetor.executeOnConfirmation(true);
  recetor.executeOnConfirmation(true);
  recetor.executeOnConfirmation(true);
  recetor.executeOnConfirmation(true);

  return 1;
}