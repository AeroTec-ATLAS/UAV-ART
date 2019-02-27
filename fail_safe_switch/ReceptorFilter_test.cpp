#include <stdio.h>
#include "ReceptorFilter.hpp"

void printChange() {
  printf("Change\n");
}

int main(void) {
  ReceptorFilter receptor(printChange);

  receptor.executeOnConfirmation(true);
  receptor.executeOnConfirmation(true);
  receptor.executeOnConfirmation(true);
  receptor.executeOnConfirmation(true);
  receptor.executeOnConfirmation(true);

  return 1;
}