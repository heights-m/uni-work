#include <stdio.h>

int power(int x, int n) {
	if (n == 0) { return 1;}
	if (n%2 == 0) {
		int temp = power(x, n/2);
		return temp * temp;
	} else {
		return x * power(x, n-1);
	}
}

int main (void) {
	int x, n;
	printf("Type x and n: ");
	scanf("%d %d", &x, &n);
	printf("%d", power(x, n));
	return 0;
}
