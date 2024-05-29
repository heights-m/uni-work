#ifndef __BINTREE__
#define __BINTREE__

/* reci_bintree.h
*/
#include <stdio.h>

//offset of m in st
#define offsetof(st, m)         ( (size_t) &(((st *)0)->m) )

//container address when the address of m in st is ptr
#define containerof(ptr, st, m) ((st *) (((char*)(ptr)) - offsetof(st, m)))

typedef struct node node_t;
struct node {
    node_t *left, *right;
};

typedef struct bintree bintree_t;
struct bintree {
    node_t *root;
    void    (*add)       (bintree_t *tree, node_t *n, int (*comp)(node_t *a, node_t *b));
    node_t* (*find)      (bintree_t *tree, void *data, int (*comp)(node_t *a, void* data));
    void    (*preorder)  (bintree_t *tree, void (*visit)(node_t *a));
    void    (*inorder)   (bintree_t *tree, void (*visit)(node_t *a));
    void    (*postorder) (bintree_t *tree, void (*visit)(node_t *a));
};

extern bintree_t *make_bintree();
extern void free_bintree(bintree_t *tree);

#endif