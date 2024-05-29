/* reci_bintree.c
*/
#include <stdio.h>
#include <stdlib.h>
#include "reci_bintree.h"

//forward definitions
static void tree_add(bintree_t *tree, node_t *n, int (*comp)(node_t *a, node_t *b));
static node_t* tree_find(bintree_t *tree, void *data, int (*comp)(node_t *a, void *data));
static void tree_preorder(bintree_t *tree, void (*visit)(node_t *a));
static void tree_inorder(bintree_t *tree, void (*visit)(node_t *a));
static void tree_postorder(bintree_t *tree, void (*visit)(node_t *a));

/***************************************************
 * make a bin_tree rooted at root
*/
bintree_t *make_bintree() {
    //TODO: allocate memory for tree
    bintree_t *tree = malloc(sizeof(bintree_t)); 

    //TODO: copy function pointers to tree
    tree->root      = NULL;
    tree->add       = tree_add;
    tree->find      = tree_find;
    tree->preorder  = tree_preorder;
    tree->inorder   = tree_inorder;
    tree->postorder = tree_postorder;
    return tree;
}

/***************************************************
 * free bin_tree
*/
void free_bintree(bintree_t *tree) {
    free(tree);
}
/***************************************************
 * add n to the subtree rooted at root
 * comp(a, b) returns 1 if a > b; 0 if a == b; -1 if a < b
*/
static void add(node_t *root, node_t *n, int (*comp)(node_t *a, node_t *b)) {
    tree_add(
}
static void tree_add(bintree_t *tree, node_t *n, int (*comp)(node_t *a, node_t *b)) {
    if(tree->root == NULL)
        tree->root = n;
    else 
        add(tree->root, n, comp);
} 

/***************************************************
 * find a node from the subtree rooted at root
 * comp(a, data) returns 1 if a > data; 0 if a == data; -1 if a < data
*/
static node_t* find(node_t *root, void *data, int (*comp)(node_t *a, void* data)) {
    if(root == NULL)
        return NULL;
    int c = comp(root, data);
    //TODO implement find
}
static node_t* tree_find(bintree_t *tree, void *data, int (*comp)(node_t *a, void *data)) {
    return find(tree->root, data, comp);
} 

/***************************************************
 * preorder traverse the subtree rooted at root
 * call visit when visiting a node
*/
static void preorder(node_t *root, void (*visit)(node_t *a)) {
    //TODO: implement preorder
}
static void tree_preorder(bintree_t *tree, void (*visit)(node_t *a)) {
    return preorder(tree->root, visit);
} 

/***************************************************
 * inorder traverse the subtree rooted at root
 * call visit when visiting a node
*/
static void inorder(node_t *root, void (*visit)(node_t *a)) {
    //TODO: implement order
}
static void tree_inorder(bintree_t *tree, void (*visit)(node_t *a)) {
    return inorder(tree->root, visit);
} 

/***************************************************
 * postorder traverse the subtree rooted at root
 * call visit when visiting a node
*/
static void postorder(node_t *root, void (*visit)(node_t *a)) {
    //TODO: implement postorder
}
static void tree_postorder(bintree_t *tree, void (*visit)(node_t *a)) {
    return postorder(tree->root, visit);
} 
