#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>
#include <stddef.h>

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

void print_string_pointer(char* p) {
    printf("C print_string_pointer: %s\n", p);
}

void print_offsets() {
    printf("C: Offset of a = %u\n", offsetof(struct test, a));
    printf("C: Offset of b = %u\n", offsetof(struct test, b));
    printf("C: Offset of c = %u\n", offsetof(struct test, c));
    printf("C: Offset of d = %u\n", offsetof(struct test, d));
    printf("C: Offset of e = %u\n", offsetof(struct test, e));
    printf("C: Offset of f = %u\n", offsetof(struct test, f));
    printf("C: Offset of g = %u\n", offsetof(struct test, g));
    printf("C: Offset of h = %u\n", offsetof(struct test, h));
    printf("C: Offset of i = %u\n", offsetof(struct test, i));
    printf("C: Offset of j = %u\n", offsetof(struct test, j));
    printf("C: Offset of k = %u\n", offsetof(struct test, k));
    printf("C: Offset of l = %u\n", offsetof(struct test, l));
    printf("C: Offset of m = %u\n", offsetof(struct test, m));
    printf("C: Offset of n = %u\n", offsetof(struct test, n));
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

EXPORT int test_check(struct test* test) {
    print_offsets();
    assert(test->a == 1);
    assert(test->b == 'b');
    assert(test->c == 3.0);
    assert(test->d == 'd');
    assert(test->e == NULL);
    assert(test->f == 6.0);
    assert(strcmp(test->g, "foo") == 0);
    assert(test->h == 8);
    assert(test->i == NULL);
    assert(test->j == 10);
    assert(test->k == 11);
    assert(test->l == 12);
    assert(test->m == 13);
    assert(test->n == 14);
}

EXPORT struct test* test_new(struct test* test) {
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
