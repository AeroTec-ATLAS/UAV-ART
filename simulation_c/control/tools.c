#include <stdio.h>

float transpose(float[][] inputArray, int rows, int columns){
    float aux[columns][rows];
    
    for (int i = 0; i < rows; i++)
        for (int j = 0; j < columns; j++)
            aux[j][i] = inputArray[i][j];
    
    return aux;
}