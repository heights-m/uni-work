#include <stdio.h>
#include <stdlib.h>

struct node {
	int value;
	struct node *next;
};

struct node *insert_sort (struct node *l, int n) {
	struct node *prev = NULL, *p;
	p = l;
	while (1) {
		if (!p) { 
			p = malloc(sizeof(struct node));
			p->value = n;
			p->next = NULL;
			return p;
		}
		if (n < p->value) {
			if (!prev) {
				prev = malloc(sizeof(struct node));
				prev->value = n;
				prev->next = p;
				return prev;
			}
			prev->next = malloc(sizeof(struct node));
			prev->next->value = n;
			prev->next->next = p;
			return l;
		}
		prev = p;
		p = prev->next;
		if (!p) {
			prev->next = malloc(sizeof(struct node));
			prev->next->value = n;
			prev->next->next = NULL;
			return l;
		}
	}
}

void print_list (struct node *l) {
	int i = 0;
	struct node *p = l;

	while (!p) {
		printf("Node %d: %d", i, p->value);
		p = p->next;
	}
}

int main(void) {
	struct node *head = NULL;
	int n;
	for (int i = 0; i < 10; i++) {
		printf("Type int : ");
		scanf("%d", &n);
		head = insert_sort(head, n);
	}
	print_list(head);
	return 0;
}
			
