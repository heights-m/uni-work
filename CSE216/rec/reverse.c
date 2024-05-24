#include <stdio.h>
#include <string.h>

void reverse (char str[]) {
	int i = 0;
	int j = strlen(str) - 1;
	while (i < j) {
		char temp = str[i];
		str[i] = str[j];
		str[j] = temp;
		i++;
		j--;
	}
}

int main () {
	char str[100];
	printf("Enter a string: ");
	scanf("%99s", str);
	reverse(str);
	printf("result: %s\n", str);
	return 0;
}
