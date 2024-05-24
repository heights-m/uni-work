#include <stdio.h>
#include <string.h>

int find_min(char *str, int from) {
	int min = from;
	for (; from < strlen(str)-1; from++) {
		if (str[from] < str[min]) {
			min = from;
		}
	}
	return min;
}

void sort(char *str) {
	int min;
	char temp;
	for (int i = 0; i < strlen(str)-1; i++) {
		min = find_min(str, i);
		temp = str[i];
		str[i] = str[min];
		str[min] = temp;
	}
}

int main() {
	char str[100];
	printf("Enter a string: ");
	scanf("%99s",str);
	sort(str);
	printf("Result: %s\n", str);
	return 0;
}
