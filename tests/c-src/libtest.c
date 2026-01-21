#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>
#include <stddef.h>
#include <stdint.h>

#if defined(_MSC_VER)
#define EXPORT __declspec(dllexport)
#define IMPORT __declspec(dllimport)
#elif defined(__GNUC__)
#define EXPORT __attribute__((visibility("default")))
#define IMPORT
#else
#define EXPORT
#define IMPORT
#pragma warning Unknown dynamic link import/export semantics.
#endif

struct color {
    int8_t r;
    int8_t g;
    int8_t b;
    int8_t a;
};

struct test {
    int8_t a;
    char b;
    double c;
    char d;
    void* e;
    float f;
    char* g;
    int8_t h;
    void* i;
    int j;
    int k;
    int l;
    double m;
    float n;
};


void Scm_hello() {
    fprintf(stderr, "Hello from Scm_hello");
}

void print_string_pointer(char* p) {
    fprintf(stderr, "C print_string_pointer: %s\n", p);
}

void print_offsets() {
    fprintf(stderr, "C: Offset of a = %lu\n", offsetof(struct test, a));
    fprintf(stderr, "C: Offset of b = %lu\n", offsetof(struct test, b));
    fprintf(stderr, "C: Offset of c = %lu\n", offsetof(struct test, c));
    fprintf(stderr, "C: Offset of d = %lu\n", offsetof(struct test, d));
    fprintf(stderr, "C: Offset of e = %lu\n", offsetof(struct test, e));
    fprintf(stderr, "C: Offset of f = %lu\n", offsetof(struct test, f));
    fprintf(stderr, "C: Offset of g = %lu\n", offsetof(struct test, g));
    fprintf(stderr, "C: Offset of h = %lu\n", offsetof(struct test, h));
    fprintf(stderr, "C: Offset of i = %lu\n", offsetof(struct test, i));
    fprintf(stderr, "C: Offset of j = %lu\n", offsetof(struct test, j));
    fprintf(stderr, "C: Offset of k = %lu\n", offsetof(struct test, k));
    fprintf(stderr, "C: Offset of l = %lu\n", offsetof(struct test, l));
    fprintf(stderr, "C: Offset of m = %lu\n", offsetof(struct test, m));
    fprintf(stderr, "C: Offset of n = %lu\n", offsetof(struct test, n));
}

void check_offset(int member_index, int offset) {
    if (member_index == 1) {
        int true_offset = offsetof(struct test, a);
        printf("C: Checking that member_index : %u, is offset: %u, true offset: %u\n", member_index, offset, true_offset);
        fflush(stdout);
        assert(true_offset == offset);
    } else if (member_index == 2) {
        int true_offset = offsetof(struct test, b);
        printf("C: Checking that member_index : %u, is offset: %u, true offset: %u\n", member_index, offset, true_offset);
        fflush(stdout);
        assert(true_offset == offset);
    } else if (member_index == 3) {
        int true_offset = offsetof(struct test, c);
        printf("C: Checking that member_index : %u, is offset: %u, true offset: %u\n", member_index, offset, true_offset);
        fflush(stdout);
        assert(true_offset == offset);
    } else if (member_index == 4) {
        int true_offset = offsetof(struct test, d);
        printf("C: Checking that member_index : %u, is offset: %u, true offset: %u\n", member_index, offset, true_offset);
        fflush(stdout);
        assert(true_offset == offset);
    } else if (member_index == 5) {
        int true_offset = offsetof(struct test, e);
        printf("C: Checking that member_index : %u, is offset: %u, true offset: %u\n", member_index, offset, true_offset);
        fflush(stdout);
        assert(true_offset == offset);
    } else if (member_index == 6) {
        int true_offset = offsetof(struct test, f);
        printf("C: Checking that member_index : %u, is offset: %u, true offset: %u\n", member_index, offset, true_offset);
        fflush(stdout);
        assert(true_offset == offset);
    } else if (member_index == 7) {
        int true_offset = offsetof(struct test, g);
        printf("C: Checking that member_index : %u, is offset: %u, true offset: %u\n", member_index, offset, true_offset);
        fflush(stdout);
        assert(true_offset == offset);
    } else if (member_index == 8) {
        int true_offset = offsetof(struct test, h);
        printf("C: Checking that member_index : %u, is offset: %u, true offset: %u\n", member_index, offset, true_offset);
        fflush(stdout);
        assert(true_offset == offset);
    } else if (member_index == 9) {
        int true_offset = offsetof(struct test, i);
        printf("C: Checking that member_index : %u, is offset: %u, true offset: %u\n", member_index, offset, true_offset);
        fflush(stdout);
        assert(true_offset == offset);
    } else if (member_index == 10) {
        int true_offset = offsetof(struct test, j);
        printf("C: Checking that member_index : %u, is offset: %u, true offset: %u\n", member_index, offset, true_offset);
        fflush(stdout);
        assert(true_offset == offset);
    } else if (member_index == 11) {
        int true_offset = offsetof(struct test, k);
        printf("C: Checking that member_index : %u, is offset: %u, true offset: %u\n", member_index, offset, true_offset);
        fflush(stdout);
        assert(true_offset == offset);
    } else if (member_index == 12) {
        int true_offset = offsetof(struct test, l);
        printf("C: Checking that member_index : %u, is offset: %u, true offset: %u\n", member_index, offset, true_offset);
        fflush(stdout);
        assert(true_offset == offset);
    } else if (member_index == 13) {
        int true_offset = offsetof(struct test, m);
        printf("C: Checking that member_index : %u, is offset: %u, true offset: %u\n", member_index, offset, true_offset);
        fflush(stdout);
        assert(true_offset == offset);
    } else if (member_index == 14) {
        int true_offset = offsetof(struct test, n);
        printf("C: Checking that member_index : %u, is offset: %u, true offset: %u\n", member_index, offset, true_offset);
        fflush(stdout);
        assert(true_offset == offset);
    }
}


EXPORT struct test* init_struct(struct test* test) {
    print_offsets();
    test->a = 1;
    test->b = 'b';
    test->c = 3.0;
    test->d = 'd';
    test->e = NULL;
    test->f = 6.0;
    char* foo = malloc(sizeof("FOOBAR"));
    snprintf(foo, sizeof("FOOBAR") + 1, "FOOBAR");
    test->g = foo;
    test->h = 8;
    test->i = NULL;
    test->j = 10;
    test->k = 11;
    test->l = 12;
    test->m = 13;
    test->n = 14;
}

EXPORT int color_check(struct color* color) {
    printf("C: Value of r is %c\n", color->r);
    assert(color->r == 100);
    printf("C: Value of g is %c\n", color->g);
    assert(color->g == 101);
    printf("C: Value of b is %c\n", color->b);
    assert(color->b == 102);
    printf("C: Value of a is %c\n", color->a);
    assert(color->a == 103);
    return 0;
}

EXPORT int color_check_by_value(struct color color) {
    printf("C: Value of r is %i\n", color.r);
    assert(color.r == 100);
    printf("C: Value of g is %i\n", color.g);
    assert(color.g == 101);
    printf("C: Value of b is %i\n", color.b);
    assert(color.b == 102);
    printf("C: Value of a is %i\n", color.a);
    assert(color.a == 103);
    return 0;
}

EXPORT int test_check(struct test* test) {
    print_offsets();
    printf("C: Value of a is %c\n", test->a);
    assert(test->a == 1);
    printf("C: Value of b is %c\n", test->b);
    assert(test->b == 'b');
    printf("C: Value of c is %lf\n", test->c);
    //FIXME
    //assert(test->c == 3.0);
    printf("C: Value of d is %c\n", test->d);
    assert(test->d == 'd');
    printf("C: Value of e is %s\n", (char*)test->e);
    assert(test->e == NULL);
    printf("C: Value of f is %f\n", test->f);
    //FIXME
    //assert(test->f == 6.0);
    //FIXME
    //printf("C: Value of g is %f\n", test->g);
    //assert(strcmp(test->g, "foo") == 0);
    printf("C: Value of h is %i\n", test->h);
    assert(test->h == 8);
    printf("C: Value of i is %s\n", (char*)test->i);
    assert(test->i == NULL);
    //FIXME
    //printf("C: Value of j is %i\n", test->j);
    //assert(test->j == 10);
    //FIXME
    //printf("C: Value of k is %i\n", test->k);
    //assert(test->k == 11);
    //FIXME
    //printf("C: Value of l is %i\n", test->l);
    //assert(test->l == 12);
    //FIXME
    //printf("C: Value of m is %i\n", test->m);
    //assert(test->m == 13);
    //FIXME
    //printf("C: Value of n is %i\n", test->n);
    //assert(test->n == 14);
}

EXPORT int test_check_by_value(struct test test) {
    print_offsets();
    printf("C: Value of a is %i\n", test.a);
    assert(test.a == 1);
    printf("C: Value of b is %c\n", test.b);
    assert(test.b == 'b');
    printf("C: Value of c is %lf\n", test.c);
    assert(test.c == 3.0);
    printf("C: Value of d is %c\n", test.d);
    assert(test.d == 'd');
    printf("C: Value of e is %s\n", (char*)test.e);
    assert(test.e == NULL);
    printf("C: Value of f is %f\n", test.f);
    assert(test.f == 6.0);
    printf("C: Value of g is %s\n", test.g);
    assert(strcmp(test.g, "foo") == 0);
    printf("C: Value of h is %i\n", test.h);
    assert(test.h == 8);
    printf("C: Value of i is %s\n", (char*)test.i);
    assert(test.i == NULL);
    printf("C: Value of j is %i\n", test.j);
    assert(test.j == 10);
    printf("C: Value of k is %i\n", test.k);
    assert(test.k == 11);
    printf("C: Value of l is %i\n", test.l);
    assert(test.l == 12);
    printf("C: Value of m is %f\n", test.m);
    assert(test.m == 13);
    printf("C: Value of n is %f\n", test.n);
    assert(test.n == 14);
}

EXPORT struct test* test_new() {
    print_offsets();
    struct test* t = malloc(sizeof(struct test));
    t->a = 1;
    t->b = 'b';
    t->c = 3.0;
    t->d = 'd';
    t->e = NULL;
    t->f = 6.0;
    char* foo = malloc(sizeof("FOOBAR"));
    snprintf(foo, sizeof("FOOBAR") + 1, "FOOBAR");
    t->g = foo;
    t->h = 8;
    t->i = NULL;
    t->j = 10;
    t->k = 11;
    t->l = 12;
    t->m = 13;
    t->n = 14;
    return t;
}

EXPORT void takes_no_args() {
    fprintf(stderr, "I take no arguments :)");

}

EXPORT int takes_no_args_returns_int() {
    return 0;
}

EXPORT int test_passing_pointer_address(int* p1, int** p2) {
    printf("p1 value: %i\n", *p1);
    printf("p2 value: %i\n", **p2);
    int* p3 = malloc(sizeof(int));
    *p3 = 42;
    *p2 = p3;
    return 0;
}
