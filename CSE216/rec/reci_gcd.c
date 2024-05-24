#include <stdio.h>

int gcd (int a, int b) {
	if (a == b) {
		return a;
	} else if (a > b) {
		return gcd((a - b), b);
	} else {
		return gcd((b - a), a);
	}
}

int main() {
	int a, b;
	printf("Enter a: ");
	scanf("%d", &a);
	
	printf("Enter b: ");
	scanf("%d", &b);
	printf("GCD: %d", gcd(a, b));
	return 0;
}
