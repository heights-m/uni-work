#include <stdio.h>

int main (void) {

	int n, i, sqr;
	printf("Enter a number: ");
	scanf("%d", &n);

	for (i = 2; i*i <= n; i += 2) {
		printf("\n%d", i*i);
	}

	return 0;
}
