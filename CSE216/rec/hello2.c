#include <stdio.h>

void greeting() {
	char name[100];
	printf("Enter ur name: ");
	scanf("%s", name);
	printf("Hello %s.\n", name);
}

int main() {
	greeting();
	return 0;
}
