//
// expr.h
//
#ifndef __EXPR__
#define __EXPR__

#include "refobj.h"
#include "rat.h"

typedef struct expr expr_t;
struct expr {
    refobj_t ref;   //ref is at the beginning of rat
    void ( *eval  )(/*in*/ expr_t *self, /*out*/ rat_t **pp_res);
    void ( *print )(/*in*/ expr_t *self);
};

typedef struct expr_num {
    refobj_t ref;   //first part is the same as expr_t
    void ( *eval  )(/*in*/ expr_t *self, /*out*/ rat_t **pp_res);
    void ( *print )(/*in*/ expr_t *self);

    rat_t *n; //number
} expr_num_t;

typedef struct expr_opr {
    refobj_t ref;   //first part is the same as expr_t
    void ( *eval  )(/*in*/ expr_t *self, /*out*/ rat_t **pp_res);
    void ( *print )(/*in*/ expr_t *self);

    void ( *opr ) (/*in*/ rat_t *a, /*in*/ rat_t *b, /*out*/ rat_t **pp_res); //operator
    expr_t *a;     //operand 1
    expr_t *b;     //operand 2
} expr_opr_t;

extern void expr_make_num(/*in*/ rat_t *n, /*out*/ expr_t **pp_res);
extern void expr_make_add(/*in*/ expr_t *a, /*in*/ expr_t *b, /*out*/ expr_t **pp_res);
extern void expr_make_sub(/*in*/ expr_t *a, /*in*/ expr_t *b, /*out*/ expr_t **pp_res);
extern void expr_make_mul(/*in*/ expr_t *a, /*in*/ expr_t *b, /*out*/ expr_t **pp_res);
extern void expr_make_div(/*in*/ expr_t *a, /*in*/ expr_t *b, /*out*/ expr_t **pp_res);

#endif
