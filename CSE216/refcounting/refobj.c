// refobj.c
//
#include "refobj.h"
#include "common.h"
#include <stdlib.h>

//statistics
refstat_t stat;

//forward definitions
static void default_addref(refobj_t *ref);
static void default_release(refobj_t *ref);

//allocate container and init ref obj
void *refobj_alloc(tag_t tag, size_t size) {
    char *obj = calloc(1, size);     //allocate memory
    refobj_t *ref = (refobj_t*)obj;
    ref->tag      = tag;             //tag of the object
    ref->cnt_ref  = 1;               //reference count is set to 1
    ref->addref   = default_addref;  //default addref    
    ref->release  = default_release; //default release
    stat.cnt_obj[ref->tag]++;        //update stat
    stat.cnt_ref[ref->tag]++;
    return obj;
}

//free the container of ref
void refobj_free(refobj_t *ref) {
    char* obj = (char*)ref;
    ON_FALSE_EXIT(ref->cnt_ref == 0,
        strmsg("destroying live refobj, cnt_ref: %d", ref->cnt_ref));
    stat.cnt_obj[ref->tag]--;       //update stat
    free(obj);                      //deallocate memory
}

//increase cnt_ref of ref
void refobj_incref(refobj_t *ref) {
    ON_FALSE_EXIT(ref->cnt_ref > 0,
        strmsg("nonpositive cnt_ref: %d", ref->cnt_ref));
    ref->cnt_ref++;                 //increase reference count
    stat.cnt_ref[ref->tag]++;       //update stat
}

//decrease cnt_ref of ref
void refobj_decref(refobj_t *ref) {
    ON_FALSE_EXIT(ref->cnt_ref > 0,
        strmsg("nonpositive cnt_ref: %d", ref->cnt_ref));
    ref->cnt_ref--;                 //decrease reference count
    stat.cnt_ref[ref->tag]--;       //update stat
}

//check whether all refobjs are deallocated correctly
void refobj_check_dealloc() {
    int i, allzero = 1;

    for(i = 0; i < OBJ_COUNT; i++) {
        allzero &= stat.cnt_ref[i] == 0;
        allzero &= stat.cnt_obj[i] == 0;
    }

    if(!allzero) {
        fprintf(stderr, "cnt_ref = [ ");
        for(i = 0; i < OBJ_COUNT; i++)
            fprintf(stderr, "%d, ", stat.cnt_ref[i]);
        fprintf(stderr, "]\n");

        fprintf(stderr, "cnt_obj = [ ");
        for(i = 0; i < OBJ_COUNT; i++)
            fprintf(stderr, "%d, ", stat.cnt_obj[i]);
        fprintf(stderr, "]\n");

        ON_FALSE_EXIT(0, "error: deallocating refobjs");
    }
}

//default addref for reference counting
static void default_addref(refobj_t *ref) {
    refobj_incref(ref);         //increase reference count
}

//default release for reference counting
static void default_release(refobj_t *ref) {
    refobj_decref(ref);         //decrease the reference count
    if(ref->cnt_ref == 0)       //free the object if the count is 0
        refobj_free(ref);
}
