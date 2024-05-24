#include <stdio.h>

/* Write a function PrintAssembly 
 * Arguements: array A of int
 * 		length N of array
 * And prints elements in ascending order without sorting the array*/

int PrintAscending (int a[], int n) {
	int max = a[0], i;
	
	for (i = 1; i < n; i++) {
		if (a[i] > max) {
			max = a[i];
		}
	}
	return max;
}


int main (void) {
	
	int a[10];
	printf("Type 10 int: ");
	
	for (int i = 0; i < 10; i++) {
	scanf("%d", &a[i]);
	}

	printf("%d", FindMax(a, 10));
	return 0;
	
}
