//
// vector3.h
//
#ifndef __VECTOR3__
#define __VECTOR3__

#include "complex.h"

typedef struct vec3 vec3_t;
struct vec3 {
    refobj_t ref;
    void ( *add   )(/*in*/ vec3_t *a,    /*in*/ vec3_t *b, /*out*/ vec3_t **pp_res);
    void ( *sub   )(/*in*/ vec3_t *a,    /*in*/ vec3_t *b, /*out*/ vec3_t **pp_res);
    void ( *smul  )(/*in*/ complex_t *s, /*in*/ vec3_t *a, /*out*/ vec3_t **pp_res);
    void ( *prod  )(/*in*/ vec3_t *a,    /*in*/ vec3_t *b, /*out*/ complex_t **pp_res);
    int  ( *tostr )(char *buf, /*in*/ vec3_t *self);
    complex_t *x, *y, *z;    
};

extern void vec3_make(/*in*/ complex_t *x, /*in*/ complex_t *y, /*in*/ complex_t *z, /*out*/ vec3_t **pp_res);

#endif
