#include <stdio.h>

int search(const int a[], int n, int key) {
	
	int *p;
	p = a;
	while (p < a + n) {
		if (*p == key) {
			return 1;
		}
		p++;
	}
	return 0;
}

double inner_product (double *a, double *b, int n) {

	double result = 0;
	for (int i = 0; i < n; i++) {
		result += *(a+i) * *(b+i);
	}
	return result;
}

int main (void) {
	int i, j;
	i = 6;
	j = -6;
	printf("%x\n", i);
	printf("%x\n", j);

	int ar[20] = {
			0, 0, 0, 0, 0,
			0, 0, 0, 0, 0,
			0, 5, 0, 0, 0,
			0, 0, 0, 0, 0,};
	printf("\n%d", search(ar, 20, 5));

	double x[3] = {1, 2, 3};
	double y[3] = {5, 2, 2};
	printf("\n%f", inner_product(&x, &y, 3));
	return 0;
}
