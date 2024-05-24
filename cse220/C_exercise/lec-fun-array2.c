#include <stdio.h>
#define COLM 4

int FindMax2 (int a[][COLM], int row, int colm) {
	int max = a[0][0], i, j = 1;
	
	for (i = 0; i < row; i++) {
		for (; j < colm; j++) {
			if (a[i][j] > max) {
				max = a[i][j];}
		}
		j = 0;
	}
	return max;
}


int main (void) {
	int a2[5][4] = {
			     {2, 3, 4, 5},
			     {2, 3, 84, 5},
			     {2, 0, 4, 5},
			     {-33, 3, 4, 5},
			     {2, 3, 4, 5},
			    };

	printf("%d", FindMax2(a2, 5, 4));
	return 0;
	
}
