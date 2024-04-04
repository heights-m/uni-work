#include <stdio.h>

int FindMax (int a[], int n) {
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
