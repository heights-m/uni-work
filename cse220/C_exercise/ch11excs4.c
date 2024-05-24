#include <stdio.h>

void swap(int *p, int *q) {
	int temp;
	temp = *p;
	*p = *q;
	*q = temp;
}

void split_time(long total_sec, int *hr, int *min, int *sec) {

	*hr = total_sec/3600;
	total_sec %= 3600;
	*min = total_sec/60;
	*sec = total_sec%60;
}

int main(void) {
	int i = 3, j = 9;
	swap(&i, &j);
	printf("i: %d j: %d", i, j);
	long secs = 19472;
	int hr, min, sec;
	split_time(secs, &hr, &min, &sec);
	printf("\nhrs: %d mins: %d sec: %d", hr, min, sec);
}
