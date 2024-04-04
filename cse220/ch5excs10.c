#include <stdio.h>

int main(void) {
	int numgrade;

	printf("Enter numberical grade: ");
	scanf("%d", &numgrade);
	printf("\nLetter grade: ");

	numgrade = numgrade/10;

	switch (numgrade) {
		case 10: printf("A");
			 break;
		case 9: printf("A");
			 break;
		case 8: printf("B");
			 break;
		case 7: printf("C");
			 break;
		case 6: printf("D");
			 break;
		default: printf("F");
			 break;
	}

	return 0;
}
