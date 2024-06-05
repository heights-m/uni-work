//
// rat.h
//
#ifndef __RAT__     //to avoid multiple inclusion
#define __RAT__
#include "refobj.h"

typedef struct rat rat_t;
struct rat {
    refobj_t ref;   //ref is at the beginning of rat (they have the same address)
    int  ( *get_num )(/*in*/ rat_t* r);
    int  ( *get_den )(/*in*/ rat_t* r);
    void ( *print   )(/*in*/ rat_t* r);
    void (* add     )(/*in*/ rat_t* a, /*in*/ rat_t* b, /*out*/ rat_t** pp_res);
    void (* sub     )(/*in*/ rat_t* a, /*in*/ rat_t* b, /*out*/ rat_t** pp_res);
    void (* mul     )(/*in*/ rat_t* a, /*in*/ rat_t* b, /*out*/ rat_t** pp_res);
    void (* div     )(/*in*/ rat_t* a, /*in*/ rat_t* b, /*out*/ rat_t** pp_res);

    int num;
    int den;
};

//extern: make it visible to other files
extern void rat_make(int num, int den, /*out*/ rat_t** pp_res);    

#endif
