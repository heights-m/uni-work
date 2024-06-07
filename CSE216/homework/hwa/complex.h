#ifndef __COMPLEX__
#define __COMPLEX__

#include "refobj.h"

typedef struct complex complex_t;
struct complex {
    refobj_t ref;
    double ( *re  )(/*in*/ complex_t *self);
    double ( *im  )(/*in*/ complex_t *self);
    double ( *mag )(/*in*/ complex_t *self);
    double ( *ang )(/*in*/ complex_t *self);
    void   ( *add )(/*in*/ complex_t *a, /*in*/ complex_t *b, /*out*/ complex_t **pp_res);
    void   ( *sub )(/*in*/ complex_t *a, /*in*/ complex_t *b, /*out*/ complex_t **pp_res);
    void   ( *mul )(/*in*/ complex_t *a, /*in*/ complex_t *b, /*out*/ complex_t **pp_res);
    void   ( *div )(/*in*/ complex_t *a, /*in*/ complex_t *b, /*out*/ complex_t **pp_res);
    int    ( *tostr )(char *buf, /*in*/ complex_t *self);
};

extern void rect_make(double r, double i, /*out*/ complex_t **pp_res);
extern void polar_make(double r, double i, /*out*/ complex_t **pp_res);
extern double deg2rad(double deg);
extern double rad2deg(double rad);

#endif
