//
// app.c
//
#include "rat.h"
#include "expr.h"
#include <stdio.h>

int main() {
    rat_t* a, *b, *c;
    rat_make(1, 2, &a);
    rat_make(1, 3, &b);
    rat_make(1, 5, &c);

    expr_t *na, *nb, *nc;
    expr_make_num(a, &na);
    expr_make_num(b, &nb);
    expr_make_num(c, &nc);

    //a * b + b * c
    expr_t *x, *y, *z;
    expr_make_mul(na, nb, &x);
    expr_make_mul(nb, nc, &y);
    expr_make_add(x, y, &z);

    z->print(z);
    printf("\n");

    rat_t *d;
    z->eval(z, &d);
    d->print(d);
    printf("\n");


    a->ref.release(&a->ref);
    b->ref.release(&b->ref);
    c->ref.release(&c->ref);
    d->ref.release(&d->ref);

    na->ref.release(&na->ref);
    nb->ref.release(&nb->ref);
    nc->ref.release(&nc->ref);

    x->ref.release(&x->ref);
    y->ref.release(&y->ref);
    z->ref.release(&z->ref);

    refobj_check_dealloc();
}
