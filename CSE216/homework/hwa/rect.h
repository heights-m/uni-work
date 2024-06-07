//
// rect.h
//
#ifndef __RECT__
#define __RECT__

#include "complex.h"

typedef struct rect rect_t;
struct rect {
    //struct complex
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

    //struct rect specific
    double r;
    double i;
};

#endif
