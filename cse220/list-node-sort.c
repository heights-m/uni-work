#include <stio.h>

struct node {
	int value;
	struct node *next;
}

struct node *insert_sort (struct node *l, int n) {
	struct node *prev, *next, *p;
	p = l;
	while (1) {
		if (!p) { 
			p->value = n; 
			return p;
		}
		next = p->next;
		if (!next) {
			p->next = malloc(sizeof(struct node));
			p->next->value = n;
		}
