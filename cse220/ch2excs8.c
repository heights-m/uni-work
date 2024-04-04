#include <stdio.h>

int main(void) {
	float loan, rate, mnthpay;
	printf("Enter amount of loan: ");
	scanf("%f", &loan);
	printf("\nEnter interest rate: ");
	scanf("%f", &rate);
	printf("\nEnter monthy payment: ");
	scanf("%f", &mnthpay);

	rate = rate/100/12;
	float firstpay = loan - mnthpay +  (loan*rate);
	float scndpay = firstpay - mnthpay +  (firstpay*rate);
	float thirdpay = scndpay - mnthpay +  (scndpay*rate);

	printf("\nBalance after first payment: %.2f\nBalance after second payment: %.2f\nBalance after third payment: %.2f", firstpay, scndpay, thirdpay);
	return 0;
}
