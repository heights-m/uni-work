//
// polar.c
//
#include "complex.h"
#include "polar.h"
#include <math.h>

static void to_polar(/*in*/ complex_t *self, /*out*/ polar_t **pp_res) {
    ON_FALSE_EXIT(self->ref.tag == OBJ_POLAR, strmsg("not polar type"));
    *pp_res = (polar_t*)self;
    (*pp_res)->ref.addref(&(*pp_res)->ref);
}

//TODO: implement re, re( m e^i a ) = m * cos a
static double re(/*in*/ complex_t *self) {
    polar_t *pol;
    to_polar(self, &pol);

	double r = pol->m * cos(pol->a);
	pol->ref.release(&pol->ref);
	return r;
}

//TODO: implement im, im( m e^i a ) = m * sin a
static double im(/*in*/ complex_t *self) {
    polar_t *pol;
    to_polar(self, &pol);

	double i = pol->m * sin(pol->a);
	pol->ref.release(&pol->ref);
	return i;
}

//TODO: implement mag, mag( m e^i a ) = m
static double mag(/*in*/ complex_t *self) {
    polar_t *pol;
    to_polar(self, &pol);

	double m = pol->m;
	pol->ref.release(&pol->ref);
	return m;
}

//TODO: implement ang, ang( m e^i a ) = a
static double ang(/*in*/ complex_t *self) {
    polar_t *pol;
    to_polar(self, &pol);

	double a = pol->a;
	pol->ref.release(&pol->ref);
	return a;
}

//write m e^i a to buf
static int tostr(char *buf, complex_t *self) {
    polar_t *pol;
    to_polar(self, &pol);
    int ret = sprintf(buf, "%g e^i %g", pol->m, pol->a);
    pol->ref.release(&pol->ref);
    return ret;
}

//TODO: implement polar_make
void polar_make(double m, double a, /*out*/ complex_t **pp_res) {
    extern void complex_add(/*in*/ complex_t *a, /*in*/ complex_t *b, /*out*/ complex_t **pp_res);
    extern void complex_sub(/*in*/ complex_t *a, /*in*/ complex_t *b, /*out*/ complex_t **pp_res);
    extern void complex_mul(/*in*/ complex_t *a, /*in*/ complex_t *b, /*out*/ complex_t **pp_res);
    extern void complex_div(/*in*/ complex_t *a, /*in*/ complex_t *b, /*out*/ complex_t **pp_res);

    polar_t *pol = refobj_alloc(OBJ_POLAR, sizeof(polar_t));

    pol->re = re;
	pol->im = im;
	pol->mag = mag;
	pol->ang = ang;
	pol->add = complex_add;
	pol->sub = complex_sub;
	pol->mul = complex_mul;
	pol->div= complex_div;
	pol->tostr = tostr;
	
	pol->m = m;
	pol->a = a;

	*pp_res = (complex_t*) pol;
	(*pp_res)->ref.addref(&(*pp_res)->ref);
	pol->ref.release(&pol->ref);
}

//deg to radian
double deg2rad(double deg) {
    double pi = acos(-1);
    return pi / 180 * deg;
}

//radian to deg
double rad2deg(double rad) {
    double pi = acos(-1);
    return 180 / pi * rad;
}
