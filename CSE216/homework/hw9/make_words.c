#include "make_words.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//whether c is an alphabet
static int is_alpha(char c) {
    return 'a' <= c && c <= 'z' || 'A' <= c && c <= 'Z';
}

//TODO: return the number of words in str
int word_count(char* str) {
	int wc = 0, prev_isal = 0, isal;
	for (; *str != '\0'; str++) {
		isal = is_alpha(*str);
		if (!isal && prev_isal) {
			wc++;
		}
		prev_isal = isal;
	}
	return wc;
	//how do we know the len of str? loop?
}

//TODO: return the array of words in str and the number of words
void make_words(char *str, char ***pwords, int *pwc) {
    int wc = word_count(str), prev_isal = 0, isal;
    char **words = malloc(wc * sizeof(char *)); /*hint: using malloc, allocate char* array
                          of wc elements*/    
    /*hint: for each word in str, allocate memory using malloc
            and copy the word to the memory*/

    *pwords  = words;
    *pwc = wc;
	char *pbuff;

	for (; *str != '\0'; str++) {
		
		isal = is_alpha(*str);
		if (prev_isal) {
			if (isal) {
				*pbuff = *str;
				pbuff++;
			} else {
				*pbuff = '\0';
				pbuff = *words;
				*words = malloc(strlen(pbuff) + 1);
				strcpy(*words, pbuff);
				words++;
			}
		} else {
			if (isal) {
				char buffer[100];
				*words = buffer;
				pbuff = buffer;
				*pbuff = *str;
				pbuff++;
			}
		}
		prev_isal = isal;
	}

}

//print words
void print_words(char **words, int wc) {
    int i;
    printf("--print words----------\n");
    for(i = 0; i < wc; i++)
        printf("%s\n", words[i]);
}

