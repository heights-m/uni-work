#include <stdio.h>
#include <stdlib.h>
#define EPSILON (1e-8)

double fabs(double x) {
	return x < 0 ? -x : x;
}

double fx(double x) {
	return x*x - 2;
}

double bisection(double (*f)(double), double a, double b) {
	double m = (a + b)/2;
	if (fabs(a - b) < EPSILON) {
		return m;
	} else if ( f(a) * f(m) <= 0) {
		bisection(f, a, m);
	} else if ( f(m) * f(b) <= 0) {
		bisection(f, m, b);
	} else {
		printf("Error\n");
		exit(0);
}

int main() {
	double ans = bisection(fx, 0, 2);
	printf("ans: lf\n", ans);
	return 0
}
