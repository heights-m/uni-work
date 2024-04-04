#include <stdio.h>

int main (void) {
	int n, ten;
	printf("enter a two-digit number: ");
	scanf("%d", &n);
	ten = n/10;
	n -= ten;
	
	if (ten >= 10) { 
		printf("NOT A 2-DIGIT");
		return 0;
	}

	switch (ten) {
		case: 
}
