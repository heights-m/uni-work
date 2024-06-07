//
// expr.c
//

#include "expr.h"
#include <stdio.h>

//number
//
static void eval_num(/*in*/ expr_t *self, /*out*/ rat_t **pp_res) {
    expr_num_t *expr = (expr_num_t*) self;
    ON_FALSE_EXIT(self->ref.tag == OBJ_EXPR_NUM, strmsg("tag (%d) is not OBJ_EXPR_NUM", self->ref.tag));

    //TODO: return expr->n
    *pp_res = expr->n;
    (*pp_res)->ref.addref(&(*pp_res)->ref);
}
static void print_num(/*in*/ expr_t *self) {
    expr_num_t *expr = (expr_num_t*) self;
    ON_FALSE_EXIT(self->ref.tag == OBJ_EXPR_NUM, strmsg("tag (%d) is not OBJ_EXPR_NUM", self->ref.tag));
    expr->n->print(expr->n);
}
static void release_num(refobj_t *ref) {
    expr_num_t *expr = (expr_num_t*) ref;
    
    //TODO: implement release
    //  - call refobj_decref
    //  - if cnt_ref is 0, release expr->n and
    //    free expr->ref (refobj_free)
    refobj_decref(&expr->ref);
    if(expr->ref.cnt_ref == 0) {
        expr->n->ref.release(&expr->n->ref);
        refobj_free(&expr->ref);
    }
}
void expr_make_num(/*in*/ rat_t *n, /*out*/ expr_t **pp_res) {
    expr_num_t* expr  = refobj_alloc(OBJ_EXPR_NUM, sizeof(expr_num_t));
    expr->ref.release = release_num;
    expr->eval        = eval_num;
    expr->print       = print_num;

    //TODO: copy n to expr->n
    expr->n  = n;
    expr->n->ref.addref(&expr->n->ref);

    //TODO: return expr
    *pp_res = (expr_t*)expr;
    (*pp_res)->ref.addref(&(*pp_res)->ref);
    expr->ref.release(&expr->ref);
}

//common functions for binary operators
//
typedef void (*rat_op_t)(rat_t* a, rat_t* b, rat_t** pp_res);
static rat_op_t rat_op(char *str_op) {
    rat_t *rat;
    rat_make(1, 1, &rat);
    rat_op_t op = str_op == "add" ? rat->add
                : str_op == "sub" ? rat->sub
                : str_op == "mul" ? rat->mul
                : str_op == "div" ? rat->div
                : NULL
                ;
    rat->ref.release(&rat->ref);
    return op;
}
static void eval_opr(/*in*/  expr_t *self,
                     /*out*/ rat_t **pp_res) {
    expr_opr_t *expr = (expr_opr_t*) self;
    ON_FALSE_EXIT(self->ref.tag == OBJ_EXPR_OPR, strmsg("tag (%d) is not OBJ_EXPR_OPR", self->ref.tag));

    //TODO: evaluate expr->a and expr->b
    rat_t *a, *b;
    expr->a->eval(expr->a, &a);
    expr->b->eval(expr->b, &b);

    //TODO: call opr with a and b and get the result in pp_res
    expr->opr(a, b, pp_res);

    //TODO: return
    a->ref.release(&a->ref);
    b->ref.release(&b->ref);
}
static void print_opr(/*in*/expr_t *self) {
    expr_opr_t *expr = (expr_opr_t*) self;
    ON_FALSE_EXIT(self->ref.tag == OBJ_EXPR_OPR, strmsg("tag (%d) is not OBJ_EXPR_OPR", self->ref.tag));
    char *opr = expr->opr == rat_op("add") ? "+"
              : expr->opr == rat_op("sub") ? "-"
              : expr->opr == rat_op("mul") ? "*"
              : expr->opr == rat_op("div") ? "/"
              : "?"
              ;

    expr->a->print(expr->a);
    printf(" %s ", opr);
    expr->b->print(expr->b);
}
static void release_opr(refobj_t *ref) {
    expr_opr_t *expr = (expr_opr_t*)ref;

    //TODO: implement release
    //  - call refobj_decref
    //  - if cnt_ref is 0, release expr->a, expr->b and
    //    free expr->ref (refobj_free)
    refobj_decref(&expr->ref);
    if(expr->ref.cnt_ref == 0) {
        expr->a->ref.release(&expr->a->ref);
        expr->b->ref.release(&expr->b->ref);
        refobj_free(&expr->ref);
    }
}

//make expr_opr without opr
static void make_expr_opr(/*in*/ expr_t *a, /*in*/ expr_t *b, char *str_opr, /*out*/ expr_t **pp_res) {
    expr_opr_t* expr  = refobj_alloc(OBJ_EXPR_OPR, sizeof(expr_opr_t));
    expr->ref.release = release_opr;
    expr->eval        = eval_opr;
    expr->print       = print_opr;

    //TODO: copy a to expr->a and b to expr->b
    expr->a = a;
    expr->b = b;
    expr->a->ref.addref(&expr->a->ref);
    expr->b->ref.addref(&expr->b->ref);

    //update opr using rat_op
    expr->opr = rat_op(str_opr);

    //return the result
    *pp_res = (expr_t*)expr;
    (*pp_res)->ref.addref(&(*pp_res)->ref);
    expr->ref.release(&expr->ref);
}

void expr_make_add(/*in*/ expr_t *a, /*in*/ expr_t *b, /*out*/ expr_t **pp_res) {
    make_expr_opr(a, b, "add", pp_res);
}
void expr_make_sub(/*in*/ expr_t *a, /*in*/ expr_t *b, /*out*/ expr_t **pp_res) {
    make_expr_opr(a, b, "sub", pp_res);
}
void expr_make_mul(/*in*/ expr_t *a, /*in*/ expr_t *b, /*out*/ expr_t **pp_res) {
    make_expr_opr(a, b, "mul", pp_res);
}
void expr_make_div(/*in*/ expr_t *a, /*in*/ expr_t *b, /*out*/ expr_t **pp_res) {
    make_expr_opr(a, b, "div", pp_res);
}
