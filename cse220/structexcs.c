#include <stdio.h>
#define LEN 100

int main (void) {

	struct {
		char family_name[LEN];
		char name[LEN];
		int id;
		float gpa;
		char gender;
	} student1;

	printf("Enter surname: ");
	scanf("%s", &student1.family_name);
	printf("Enter name: ");
	fgets("%s", &student1.name);
	printf("Enter ID: ");
	scanf("%d", &student1.id);
	printf("Enter GPA: ");
	scanf("%f", &student1.gpa);
	printf("Enter gender: ");
	scanf("%c", &student1.gender);

	printf("Surname: %s", student1.family_name);
	printf("Name: %s", student1.name);
	printf("ID: %d", student1.id);
	printf("GPA: %f", student1.gpa);
	printf("Gendr: %c", student1.gender);
	return 0;
}
