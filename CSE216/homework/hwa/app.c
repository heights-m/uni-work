//
// app.c
//
#include <stdio.h>
#include "rect.h"
#include "polar.h"
#include "vector3.h"

void test_vector() {
    char buf[256];
    int i = 0;

    printf("--test vector--------------------\n");

    complex_t *x, *y, *z;
    rect_make(1, 0, &x);
    rect_make(0, 1, &y);
    rect_make(1, 1, &z);

    vec3_t *a, *b, *c, *d;
    vec3_make(x, x, x, &a);
    x->ref.release(&x->ref);
    i += a->tostr(buf + i, a);    i += sprintf(buf + i, "\n");

    vec3_make(y, y, y, &b);
    y->ref.release(&y->ref);
    i += b->tostr(buf + i, b);    i += sprintf(buf + i, "\n");

    a->add(a, b, &c);
    a->ref.release(&a->ref);
    b->ref.release(&b->ref);
    i += c->tostr(buf + i, c);    i += sprintf(buf + i, "\n");

    b->smul(z, c, &d);
    z->ref.release(&z->ref);
    i += d->tostr(buf + i, d);    i += sprintf(buf + i, "\n");

    complex_t *e;
    c->prod(c, d, &e);
    i += e->tostr(buf + i, e);    i += sprintf(buf + i, "\n");
    c->ref.release(&c->ref);
    d->ref.release(&d->ref);
    e->ref.release(&e->ref);

    printf("%s", buf);
}

void test_complex() {
    char buf[256];
    int i = 0;

    printf("--test complex-------------------\n");

    complex_t *a, *b, *c, *d;
    rect_make(1, 1, &a);
    i += a->tostr(buf + i, a);    i += sprintf(buf + i, "\n");

    polar_make(1, deg2rad(45), &b);
    i += b->tostr(buf + i, b);    i += sprintf(buf + i, "\n");

    b->mul(b, b, &c);
    i += c->tostr(buf + i, c);    i += sprintf(buf + i, "\n");
    b->ref.release(&b->ref);

    a->add(a, c, &d);
    i += d->tostr(buf + i, d);    i += sprintf(buf + i, "\n");
    a->ref.release(&a->ref);
    c->ref.release(&c->ref);
    d->ref.release(&d->ref);

    printf("%s", buf);
}

int main() {
    test_complex();
    test_vector();
    refobj_check_dealloc();
    return 0;
}
