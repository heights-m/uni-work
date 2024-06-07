//
// vector3.c
//
#include "common.h"
#include "vector3.h"

static void is_vec3(void *obj) {
    ON_FALSE_EXIT(((refobj_t*)obj)->tag == OBJ_VEC3, strmsg("not vec3 type"));
}

static void to_vec3(/*in*/ refobj_t *obj, /*out*/ vec3_t **pp_res) {
    ON_FALSE_EXIT(obj->tag == OBJ_VEC3, strmsg("not vec3 type"));
    *pp_res = (vec3_t*)obj;
    (*pp_res)->ref.addref(&(*pp_res)->ref);    
}

//wirte [x, y, z] to buf
static int tostr(char *buf, /*in*/ vec3_t *self) {
    int i = 0;
    i += sprintf(buf + i, "[ ");
    i += self->x->tostr(buf + i, self->x);  i += sprintf(buf + i, ", ");
    i += self->y->tostr(buf + i, self->y);  i += sprintf(buf + i, ", ");
    i += self->z->tostr(buf + i, self->z);  i += sprintf(buf + i, " ]");
    return i;
}

//TODO: implement vec3_release
static void vec3_release(refobj_t *self) {
    is_vec3(self);
    vec3_t *v = (vec3_t*)self;

	refobj_decref(&v->ref);
	if (v->ref.cnt_ref == 0) {
		v->x->ref.release(&v->x->ref);
		v->y->ref.release(&v->y->ref);
		v->z->ref.release(&v->z->ref);
		refobj_free(&v->ref);
	}
}

//TODO: implement vec3_add
//e.g. add([1, 2, 3], [4, 5, 6]) = [1+4, 2+5, 3+6]
static void vec3_add(/*in*/ vec3_t *a, /*in*/ vec3_t *b, /*out*/ vec3_t **pp_res) {
    is_vec3(a);
    is_vec3(b);

    complex_t *x, *y, *z;

	a->x->add(a->x, b->x, &x);
	a->y->add(a->y, b->y, &y);
	a->z->add(a->z, b->z, &z);

	vec3_make(x, y, z, pp_res);
	x->ref.release(&x->ref);
	y->ref.release(&y->ref);
	z->ref.release(&z->ref);
}

//TODO: implement vec3_sub
//e.g. sub([1, 2, 3], [4, 5, 6]) = [1-4, 2-5, 3-6]
static void vec3_sub(/*in*/ vec3_t *a, /*in*/ vec3_t *b, /*out*/ vec3_t **pp_res) {
    is_vec3(a);
    is_vec3(b);

    complex_t *x, *y, *z;

	a->x->sub(a->x, b->x, &x);
	a->y->sub(a->y, b->y, &y);
	a->z->sub(a->z, b->z, &z);

	vec3_make(x, y, z, pp_res);
	x->ref.release(&x->ref);
	y->ref.release(&y->ref);
	z->ref.release(&z->ref);
}

//TODO: implement vec3_smul
//scalar multiplication, e.g. smul(2, [1, 2, 3]) = [2, 4, 6]
static void vec3_smul(/*in*/ complex_t *s, /*in*/ vec3_t *a, /*out*/ vec3_t **pp_res) {
    is_vec3(a);

    complex_t *x, *y, *z;

	s->mul(s, a->x, &x);
	s->mul(s, a->y, &y);
	s->mul(s, a->z, &z);

	vec3_make(x, y, z, pp_res);
	x->ref.release(&x->ref);
	y->ref.release(&y->ref);
	z->ref.release(&z->ref);
}

//TODO: implement vec3_prod
//inner product, e.g. prod([1, 2, 3], [4, 5, 6]) = 1*4 + 2*5 + 3*6 = 32
static void vec3_prod(/*in*/ vec3_t *a, /*in*/ vec3_t *b, /*out*/ complex_t **pp_res) {
    is_vec3(a);
    is_vec3(b);

    complex_t *x, *y, *z, *t;

	a->x->mul(a->x, b->x, &x);
	a->y->mul(a->y, b->y, &y);
	a->z->mul(a->z, b->z, &z);
	
	a->z->add(x, y, &t);
	a->x->add(t, z, pp_res);
	x->ref.release(&x->ref);
	y->ref.release(&y->ref);
	z->ref.release(&z->ref);
	t->ref.release(&t->ref);
}

//TODO: implement vec3_make
void vec3_make(/*in*/ complex_t *x, /*in*/ complex_t *y, /*in*/ complex_t *z, /*out*/ vec3_t **pp_res) {
    vec3_t *v = refobj_alloc(OBJ_VEC3, sizeof(vec3_t));
    v->ref.release = vec3_release;

	v->add = vec3_add;
	v->sub = vec3_sub;
	v->smul = vec3_smul;
	v->prod = vec3_prod;
	v->tostr = tostr;

	v->x = x;
	v->y = y;
	v->z = z;

	v->x->ref.addref(&v->x->ref);
	v->y->ref.addref(&v->y->ref);
	v->z->ref.addref(&v->z->ref);

	*pp_res = v;
	(*pp_res)->ref.addref(&(*pp_res)->ref);
	v->ref.release(&v->ref);
}
