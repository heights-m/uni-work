#include <stdio.h>

int main (void) {

	int n, i, sqr;
	printf("Enter a number: ");
	scanf("%d", &n);
	
	if (n >= 2) {
		i = 2;
		do {
		printf("\n%d", i*i);
		i += 2;
		} while (i*i <= n);
	}
	return 0;
}
