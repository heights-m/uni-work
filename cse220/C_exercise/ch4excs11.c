#include <stdio.h>

int main(void) {
	int i, j, k;

	i = 1;
	printf("\n%d", i++ - 1);
	printf("\n%d", i);

	i = 10; j = 5;
	printf("\n%d", i++ - ++j);
	printf("\n%d %d", i, j);

	i = 7; j = 8;
	printf("\n%d", i++ - --j);
	printf("\n%d %d", i, j);

	i = 3; j = 4; k =5;
	printf("\n%d", i++ - j++ + --k);
	printf("\n%d %d %d", i, j, k);
}
