#ifndef __FREQ_WORDS__
#define __FREQ_WORDS__

typedef struct word_freq {
    char *word;
    int  freq;
} word_freq_t;

//TODO: add function declarations
extern void make_word_freqs(char **sorted_words, int wc, word_freq_t **pword_freqs, int *puwc);
extern void print_word_freqs(word_freq_t *word_freqs, int uwc); 

#endif
