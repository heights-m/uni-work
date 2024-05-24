#include <stdio.h>

int main (void) {
	int i, n;
	float denum = 1.f, e = 1.f;
	
	printf("Enter an integer: ");
	scanf("%d", &n);
	
	i = 0;	
	while (i < n) {
		denum *= i+1;
		e += 1.f/denum;
		i++;
	}

	printf("%f", e);
	return 0;
}	
