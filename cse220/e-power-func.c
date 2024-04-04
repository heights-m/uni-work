#include <stdio.h>

double powerSeries (double x, double eps) {

	int i, denum = 1;
	double n, e = 1.f, numer = 1.f;
	i = 1;	
	while (1) {
		denum *= i;
		numer *= x;
		n = numer/denum;
		if (n < eps) {break;}
		e += n;
		i++;
	}
	return e;
}

int main (void) {
	double x;
	double e, eps;
	
	printf("Enter x: ");
	scanf("%lf", &x);
	printf("Enter epsilon: ");
	scanf("%lf", &eps);

	e = powerSeries(x, eps);	

	printf("%g", e);
	//printf("\nnon-user input\n");
	//printf("%f", powerSeries(3.0, 0.001));
	return 0;
}	
