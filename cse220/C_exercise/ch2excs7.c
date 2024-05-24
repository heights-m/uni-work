#include <stdio.h>

int main(void) {
	int twenty, ten, five, amt;
	printf("Enter a dollar amount: ");
	scanf("%d", &amt);
	twenty = amt/20;
	amt = amt%20; 
	ten = amt/10;
	amt = amt%10;
	five = amt/5;
	amt = amt%5; 
	
	printf("\n$20 bills: %d\n$10 bills: %d\n$5 bills: %d\n$1 bills: %d", twenty, ten, five, amt);
	/*printf("\n$20 bills: %d", twenty);
	printf("\n$10 bills: %d", ten);
	printf("\n$5 bills: %d", five);
	printf("\n$1 bills: %d", amt);*/
	return 0;
}
