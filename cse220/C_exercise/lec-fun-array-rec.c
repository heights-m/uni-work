#include <stdio.h>

int FindMax (int n, int a[n]) {
	if (n < 0) { return a[0];}
	if (a[n-1] < a[n]) {
		a[n-1] = a[n];
	}
	FindMax(n-1, a);
}


int main (void) {
	
	int a[10];
	printf("Type 10 int: ");
	
	for (int i = 0; i < 10; i++) {
	scanf("%d", &a[i]);
	}

	printf("%d", FindMax(10, a));
	return 0;
	
}
