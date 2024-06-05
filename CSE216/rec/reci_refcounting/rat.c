//
// rat.c
//
#include "rat.h"        //include the declarations of rat.h
#include <stdio.h>

static int sign(int a) {
    return a < 0 ? -1 : 1;
}
static int iabs(int a) {
    return a < 0 ? -a : a;
}
static int gcd(int a, int b) {
    return  a > b ? gcd(a - b, b)
        :   b > a ? gcd(b - a, a)
        :   a
        ;
}

static int get_num(/*in*/ rat_t* r) {
    return r->num;
}
static int get_den(/*in*/ rat_t* r) {
    return r->den;
}
static void print(/*in*/ rat_t* r) {
    printf("[%d / %d]", r->num, r->den);
}
static void rat_add(/*in*/ rat_t* a, /*in*/ rat_t* b, /*out*/ rat_t** pp_res) {
    int num = a->num * b->den + b->num * a->den;
    int den = a->den * b->den;
    rat_make(num, den, pp_res);
}
static void rat_sub(/*in*/ rat_t* a, /*in*/ rat_t* b, /*out*/ rat_t** pp_res) {
    int num = a->num * b->den - b->num * a->den;
    int den = a->den * b->den;
    rat_make(num, den, pp_res);
}
static void rat_mul(/*in*/ rat_t* a, /*in*/ rat_t* b, /*out*/ rat_t** pp_res) {
    int num = a->num * b->num;
    int den = a->den * b->den;
    rat_make(num, den, pp_res);
}
static void rat_div(/*in*/ rat_t* a, /*in*/ rat_t* b, /*out*/ rat_t** pp_res) {
    int num = a->num * b->den;
    int den = a->den * b->num;
    rat_make(num, den, pp_res);
}

void rat_make(int num, int den, /*out*/ rat_t** pp_res) {
    rat_t* ret = refobj_alloc(OBJ_RAT, sizeof(rat_t));

    ret->get_num = get_num;  //copy the function pointers
    ret->get_den = get_den;
    ret->print   = print;
    ret->add     = rat_add;
    ret->sub     = rat_sub;
    ret->mul     = rat_mul;
    ret->div     = rat_div;

    int s = sign(num) * sign(den);
    int g = gcd(iabs(num), iabs(den)); //reduce the fraction 
    ret->num = num / g * s;
    ret->den = den / g;

    *pp_res = ret;
    (*pp_res)->ref.addref(&(*pp_res)->ref);
    ret->ref.release(&ret->ref);
}

