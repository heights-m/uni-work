//
// rect.c
//
#include "complex.h"
#include "rect.h"
#include <math.h>

static void to_rect(/*in*/ complex_t *self, /*out*/ rect_t **pp_res) {
    ON_FALSE_EXIT(self->ref.tag == OBJ_RECT, strmsg("not rect type"));
    *pp_res = (rect_t*)self;
    (*pp_res)->ref.addref(&(*pp_res)->ref);
}

//TODO: implement re, re( a + bi ) = a
static double re(/*in*/ complex_t *self) {
    rect_t *rec;
    to_rect(self, &rec);

	double a = rec->r;
	rec->ref.release(&rec->ref);
	return a;
}

//TODO: implement im, im( a + bi ) = b
static double im(/*in*/ complex_t *self) {
    rect_t *rec;
    to_rect(self, &rec);

	double b = rec->i;
	rec->ref.release(&rec->ref);
	return b;
}

//TODO: implement mag, mag( a + bi ) = sqrt(a*a + b*b)
static double mag(/*in*/ complex_t *self) {
    rect_t *rec;
    to_rect(self, &rec);

	double a = rec->r;
	double b = rec->i;
	double m = sqrt(a*a + b*b);
	rec->ref.release(&rec->ref);
	return m;
}

//TODO: implement ang, ang( a + bi ) = atan2(b, a)
static double ang(/*in*/ complex_t *self) {
    rect_t *rec;
    to_rect(self, &rec);

	double a = rec->r;
	double b = rec->i;
	double an = atan2(b, a);
	rec->ref.release(&rec->ref);
	return an;
}

//write a + bi to buf
static int tostr(char *buf, /*in*/ complex_t *self) {
    rect_t *rec;
    to_rect(self, &rec);
    int ret = sprintf(buf, "%g + %g i", rec->r, rec->i);
    rec->ref.release(&rec->ref);
    return ret;
}

//TODO: implement rect_make
void rect_make(double r, double i, /*out*/ complex_t **pp_res) {
    extern void complex_add(/*in*/ complex_t *a, /*in*/ complex_t *b, /*out*/ complex_t **pp_res);
    extern void complex_sub(/*in*/ complex_t *a, /*in*/ complex_t *b, /*out*/ complex_t **pp_res);
    extern void complex_mul(/*in*/ complex_t *a, /*in*/ complex_t *b, /*out*/ complex_t **pp_res);
    extern void complex_div(/*in*/ complex_t *a, /*in*/ complex_t *b, /*out*/ complex_t **pp_res);

    rect_t *rec = refobj_alloc(OBJ_RECT, sizeof(rect_t));
	rec->re = re;
	rec->im = im;
	rec->mag = mag;
	rec->ang = ang;
	rec->add = complex_add;
	rec->sub = complex_sub;
	rec->mul = complex_mul;
	rec->div = complex_div;
	rec->tostr = tostr;
    rec->r = r;
	rec->i = i;

	*pp_res = (complex_t*) rec;
	(*pp_res)->ref.addref(&(*pp_res)->ref);
	rec->ref.release(&rec->ref);
}
