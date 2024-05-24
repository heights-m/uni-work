#include <stdio.h>

int main(void) {
	int n, digits;
	printf("Enter a number: ");
	scanf("%d", &n);

	if (n/1000 != 0) 
		digits = 4;
	else if (n/100 != 0)
		digits = 3;
	else if (n/10 != 0)
		digits = 2;
	else if (n/1 != 0)
		digits = 1;
	else
		digits = 0;

	printf("The number %d has %d digits", n, digits);
	return 0;
}
