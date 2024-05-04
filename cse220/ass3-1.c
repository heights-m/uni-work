#include <stdio.h>

void printWord (int i, char a[]) {

  for (; i != ' ' || i != '\0'; i++) {
    printf("%c", a[i]);
  }
}

int main(void) {
  char sentence[10000];
  char c;
  int i = 0;
  printf("Enter a sentence: ");
  
  while (1) {

    scanf("%c", &c);

    if (c == '.' || c == '!' || c == '?') {
      break;
    }
    
    sentence[i] = c;
    i++;
  }
  
  printf("Reversal of sentence:");
  for (; i >= 0; i--) {
    
    if (sentence[i] == ' '|| i == 1) {
      printf(" ");
      printWord(i-1, sentence);
    }
  }
  printf("%c", c);
  
  return 0;
}
