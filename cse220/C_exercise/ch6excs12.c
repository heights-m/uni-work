#include <stdio.h>

int main (void) {
	int i;
	float denum = 1.f, e = 1.f, eps, n;
	
	printf("Enter epsilon: ");
	scanf("%f", &eps);
	
	i = 0;	
	for (;;) {
		denum *= i+1;
		n = 1.f/denum;
		if (n < eps) break;
		e += n;
		i++;
	}

	printf("%f", e);
	return 0;
}	
