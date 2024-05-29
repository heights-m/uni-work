/* reci_bintree_test.c
*/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "reci_bintree.h"

/***************************************************
 * struct word
*/
typedef struct word word_t;
struct word {
    char *str;
    node_t node;
};
word_t* make_word(char *str) {
    word_t *word = malloc(sizeof(word_t));
    word->str = strdup(str);
    word->node.left = word->node.right = NULL;
}

/***************************************************
 * build a binary tree of words
*/
int comp(node_t *a, node_t *b) {
    //TODO: get the container of a and b and
    //      compare their str using strcmp
}
bintree_t *build(char **words) {
    bintree_t *tree = make_bintree();
    for(int i = 0; words[i] != NULL; i++) {
        word_t *word = make_word(words[i]);
        tree->add(tree, &word->node, comp);
    }
    return tree;
}

/***************************************************
 * find word from tree
*/
int comp_data(node_t *a, void *data) {
    //TODO: get the container of a and cast data to char*
    //      compare str and data using strcmp
}
void find(bintree_t *tree, char *str) {
    node_t *node = tree->find(tree, str, comp_data);
    word_t *word = containerof(node, word_t, node);
    printf("** find moe: %s\n", word->str);
}

/***************************************************
 * sort
*/
void visit(node_t *node) {
    word_t *word = containerof(node, word_t, node);
    printf("%s\n", word->str);
}
void print_sorted(bintree_t *tree) {
    printf("** sorted\n");
    //TODO: inorder traverse tree with visit
}


/***************************************************
 * destroy tree
*/
void visit_free(node_t *node) {
    word_t *word = containerof(node, word_t, node);
    free(word->str);
    free(word);
}
void free_tree(bintree_t *tree) {
    //TODO: postorder traverse tree with visit_free
    
    //TODO: free tree using free_bintree
}


/***************************************************
 * test
*/
void test() {
    char *words[] = {
        "Eeny", "meeny", "miny", "moe",
        "Catch", "a", "tiger", "by", "the", "toe",
        "If", "he", "hollers", "let", "him", "go",
        "Eeny", "meeny", "miny", "moe", NULL
    };

    bintree_t *tree = build(words);

    find(tree, "moe");

    print_sorted(tree);

    free_tree(tree);
}
int main() {
    test();
}
