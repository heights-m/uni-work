#include <stdio.h>

int main (void) {

	int n, i, sqr;
	printf("Enter a number: ");
	scanf("%d", &n);

	i = 2;
	while (i*i <= n) {
		printf("\n%d", i*i);
		i += 2;
	}
	return 0;
}
