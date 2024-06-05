#include <stdio.h>
#define LEN 100

struct student {
  char family_name[LEN];
  char other_name[LEN];
  char gender;
  int id;
  float gpa;
};

void add_student(struct student a[], int len, int n) {
  struct student *p;
  char c[2];
  for (p = a; p < a + n; p++) {
    struct student s;
    printf("Enter family name: ");
    scanf("%s", &s.family_name);
    printf("Enter other names: ");
    gets(c);
    fgets(&s.other_name, LEN, stdin);
    printf("Enter gender (m/f): ");
    scanf("%c", &s.gender);
    printf("Enter id: ");
    scanf("%d", &s.id);
    printf("Enter GPA: ");
    scanf("%f", &s.gpa);
    printf("\n");
    *p = s;
  }
}

void print_student(struct student s) {
  printf("\nFamily name: %s\nOther names: %sGender: %c\nID: %d\nGPA: %.2f\n", s.family_name, s.other_name, s.gender, s.id, s.gpa);
}

void print_gpa(struct student a[], int n) {
  float min = 5, prev = -1;
  int count = 0;
  struct student *p;
  while (count < n) {
    for (p = a; p < a+n; p++) {
      if (p->gpa < min && p->gpa > prev) {
        min = p->gpa;
      }
    }
    for (p = a; p < a+n; p++) {
      if (p->gpa == min) {
        print_student(*p);
        count++;
      }
    }
    prev = min;
    min = 5;
  }
}

void print_gender(struct student a[], int n) {
  struct student *p;
  for (p = a; p < a+n; p++) {
    if (p->gender == 'f') {
      print_student(*p);
    }
  }
  for (p = a; p < a+n; p++) {
    if (p->gender == 'm') {
      print_student(*p);
    }
  }
}

int main(void) {
  struct student student_arr[LEN];
  add_student(student_arr, LEN, 10);
  printf("Students by GPA:");
  print_gpa(student_arr, 10);
  printf("\nStudents by gender:");
  print_gender(student_arr, 10);
}
