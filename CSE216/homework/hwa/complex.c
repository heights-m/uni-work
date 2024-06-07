//
// complex.c
//
#include "complex.h"
#include "rect.h"
#include "polar.h"
#include <stdio.h>

//TODO: implement add using re and im; return rect_t to pp_res
void complex_add(/*in*/ complex_t *a, /*in*/ complex_t *b, /*out*/ complex_t **pp_res) {
	double ar = a->re(a);
	double ai = a->im(a);
	double br = b->re(b);
	double bi = b->im(b);

	rect_make(ar + br, ai + bi, pp_res);
}

//TODO: implement sub using re and im; return rect_t to pp_res
void complex_sub(/*in*/ complex_t *a, /*in*/ complex_t *b, /*out*/ complex_t **pp_res) {

	rect_make(a->re(a) - b->re(b), a->im(a) - b->im(b), pp_res);
}

//TODO: implement mul using mag and ang; return polar_t to pp_res
void complex_mul(/*in*/ complex_t *a, /*in*/ complex_t *b, /*out*/ complex_t **pp_res) {
	
	polar_make(a->mag(a) * b->mag(b), a->ang(a) + b->ang(b), pp_res);
}

//TODO: implement div using mag and ang; return polar_t to pp_res
void complex_div(/*in*/ complex_t *a, /*in*/ complex_t *b, /*out*/ complex_t **pp_res) {

	polar_make(a->mag(a) / b->mag(b), a->ang(a) - b->ang(b), pp_res);
}
