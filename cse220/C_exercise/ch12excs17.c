#include <stdio.h>
#define LEN 5

int sum_2DArr (const int a[][LEN], int n) {

  int i, sum = 0;
  int *p;

  for (p = *a; p < *a + (LEN * n); p++) {
    sum += *p;
  }
  return sum;
}

int main (void) {
  int a[3][5] = {
		 {1, 1, 1, 1, 1},
		 {1, 1, 1, 1, 1},
		 {1, 1, 1, 1, 1}};
  printf("%d", sum_2DArr(a[0], 3));
  return 0;
}
