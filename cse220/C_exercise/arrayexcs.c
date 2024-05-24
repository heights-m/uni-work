#include <stdio.h>

int main (void) {
	
	int a[10];
	int i, j, x;
	
	for (i = 0; i < 10; i++) {
		printf("\nType number: ");
		scanf("%d", &x);
		
		for (j = 0; j < i; j++) {
			if (a[j] > x) {
				break;
			}}
		for (int k = i; k > j; k--) {
			a[k] = a[k-1];
		}
		a[j] = x;
	}
	for (i = 0; i < 10; i++) {
		printf("%d, ", a[i]);
	}
	return 0;
}
