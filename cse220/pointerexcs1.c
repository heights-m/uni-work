#include <stdio.h>

int main (void) {
	int i, *p;
	i = 13;
	p = &i;

	printf("\n%d", *p);
	printf("\n%d", &p);
	printf("\n%d", *&p);
	printf("\n%d", &*p);
	//printf("\n%d", *i);
	printf("\n%d", &i);
	printf("\n%d", *&i);
	//printf("\n%d", &*i);
	return 0;
}
